package com.example.backend.controller;

import com.example.backend.dto.PredictionRequest;
import com.example.backend.dto.PredictionResponse;
import com.example.backend.service.PredictionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/prediction")
@CrossOrigin(origins = "http://localhost:5173")
public class PredictionController {

    private final PredictionService predictionService;

    public PredictionController(PredictionService predictionService) {
        this.predictionService = predictionService;
    }

    @PostMapping("/predict")
    public ResponseEntity<PredictionResponse> predict(
            @RequestBody PredictionRequest request
    ) {
        PredictionResponse response =
                predictionService.predict(request);

        return ResponseEntity.ok(response);
    }
}