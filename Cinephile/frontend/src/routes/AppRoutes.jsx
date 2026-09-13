import { Route, Routes } from "react-router-dom";
import PrivateRoute from "./PrivateRoute";

import Landing from "../pages/public/Landing.jsx";
import Login from "../pages/public/Login.jsx";
import Register from "../pages/public/Register.jsx";
import ForgotPassword from "../pages/public/ForgotPassword.jsx";
import ResetPassword from "../pages/public/ResetPassword.jsx";
import PersonDetails from "../pages/user/people/PersonDetails.jsx";

import Movies from "../pages/user/movies/Movies.jsx";
import UserDashboard from "../pages/user/dashboard/UserDashboard.jsx";
import MovieDetails from "../pages/user/movies/MovieDetails.jsx";
import Trending from "../pages/user/movies/Trending.jsx";
import Genres from "../pages/user/movies/Genres.jsx";
import BoxOfficePrediction from "../pages/user/boxoffice/BoxOfficePrediction.jsx";
import LikedMovies from "../pages/user/library/LikedMovies.jsx";
import Watchlist from "../pages/user/library/Watchlist.jsx";
import WriteReview from "../pages/user/reviews/WriteReview.jsx";
import More from "../pages/user/More.jsx";
import VerifyNumber from "../pages/Auth/VerifyNumber.jsx";
import MyReviews from "../pages/user/reviews/MyReviews.jsx";
import WatchedFilms from "../pages/user/movies/WatchedFilms.jsx";

function AppRoutes() {
    return (
        <Routes>
            <Route path="/" element={<Landing />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/forgot-password" element={<ForgotPassword />} />
            <Route path="/reset-password" element={<ResetPassword />} />
            <Route path="/phoneverification" element={<VerifyNumber />} />

            <Route
                path="/dashboard"
                element={
                    <PrivateRoute>
                        <UserDashboard />
                    </PrivateRoute>
                }
            />

            <Route
                path="/movies"
                element={
                    <PrivateRoute>
                        <Movies />
                    </PrivateRoute>
                }
            />

            <Route
                path="/movies/:movieId"
                element={
                    <PrivateRoute>
                        <MovieDetails />
                    </PrivateRoute>
                }
            />

            <Route
                path="/movies/:id/review"
                element={
                    <PrivateRoute>
                        <WriteReview />
                    </PrivateRoute>
                }
            />

            <Route
                path="/trending"
                element={
                    <PrivateRoute>
                        <Trending />
                    </PrivateRoute>
                }
            />

            <Route
                path="/genres"
                element={
                    <PrivateRoute>
                        <Genres />
                    </PrivateRoute>
                }
            />

            <Route
                path="/box-prediction"
                element={
                    <PrivateRoute>
                        <BoxOfficePrediction />
                    </PrivateRoute>
                }
            />

            <Route
                path="/more"
                element={
                <PrivateRoute>
                    <More />
                </PrivateRoute>
            } />

            <Route
                path="/favorites"
                element={
                    <PrivateRoute>
                        <LikedMovies />
                    </PrivateRoute>
                }
            />

            <Route
                path="/watchlist"
                element={
                    <PrivateRoute>
                        <Watchlist />
                    </PrivateRoute>
                }
            />

            <Route
                path="/verify-number"
                element={<VerifyNumber />}
            />



            <Route
                path="/write_review"
                element={
                    <PrivateRoute>
                        <WriteReview />
                    </PrivateRoute>
                }
            />

            <Route
                path="/myreviews"
                element={
                    <PrivateRoute>
                        <MyReviews />
                    </PrivateRoute>
                } />

            <Route
                path="/mywatchedfilms"
                element={
                    <PrivateRoute>
                        <WatchedFilms />
                    </PrivateRoute>
                } />

            <Route
                path="/person/:id"
                element={
                    <PrivateRoute>
                        <PersonDetails />
                    </PrivateRoute>
                }
            />

        </Routes>

    );
}

export default AppRoutes;
