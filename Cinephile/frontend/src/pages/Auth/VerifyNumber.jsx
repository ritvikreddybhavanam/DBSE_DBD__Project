import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { register } from "../../services/authService";

function VerifyNumber() {
    const navigate = useNavigate();

    const [otp, setOtp] = useState("");
    const [error, setError] = useState("");
    const [loading, setLoading] = useState(false);

    const handleVerify = async (event) => {
        event.preventDefault();

        setError("");

        if (!/^[0-9]{6}$/.test(otp)) {
            setError("Please enter the 6-digit OTP.");
            return;
        }

        if (!window.confirmationResult) {
            setError(
                "Verification session expired. Please register again."
            );
            return;
        }

        try {
            setLoading(true);

            await window.confirmationResult.confirm(otp);

            const registrationData =
                sessionStorage.getItem("pendingRegistration");

            if (!registrationData) {
                setError(
                    "Registration data was not found. Please register again."
                );
                return;
            }

            const userData = JSON.parse(registrationData);

            await register(userData);

            sessionStorage.removeItem("pendingRegistration");

            window.confirmationResult = null;

            navigate("/login", {
                replace: true
            });

        } catch (error) {
            console.error("OTP verification failed:", error);

            if (
                error.code ===
                "auth/invalid-verification-code"
            ) {
                setError(
                    "Invalid OTP. Please check the code and try again."
                );
            } else if (
                error.code ===
                "auth/code-expired"
            ) {
                setError(
                    "OTP has expired. Please register again."
                );
            } else if (error.response?.data) {
                setError(
                    typeof error.response.data === "string"
                        ? error.response.data
                        : "Unable to create account."
                );
            } else {
                setError(
                    error.message ||
                    "Verification failed. Please try again."
                );
            }
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="flex min-h-screen items-center justify-center bg-[#0b0d0f] px-4 text-[#e0e3e8]">

            <div className="w-full max-w-md">

                <div className="rounded-2xl border border-[#262c30] bg-[#101418] p-8 shadow-[0_20px_70px_rgba(0,0,0,0.55)]">

                    <div className="text-center">

                        <h1 className="font-['Hanken_Grotesk'] text-4xl font-extrabold text-[#43fe6d]">
                            Film Buff
                        </h1>

                        <div className="mx-auto mt-4 h-1 w-12 rounded-full bg-[#43fe6d]" />

                        <h2 className="mt-6 text-2xl font-bold text-[#f1f3f4]">
                            Verify your phone
                        </h2>

                        <p className="mt-3 text-sm leading-6 text-[#92999f]">
                            Enter the 6-digit verification code
                            sent to your phone number.
                        </p>

                    </div>

                    {error && (
                        <div className="mt-6 rounded-lg border border-red-500/30 bg-red-500/10 px-4 py-3">
                            <p className="text-sm leading-5 text-red-400">
                                {error}
                            </p>
                        </div>
                    )}

                    <form
                        onSubmit={handleVerify}
                        className="mt-8 space-y-5"
                    >

                        <div>

                            <label
                                htmlFor="otp"
                                className="mb-2 block text-sm font-medium text-[#c7ced2]"
                            >
                                Verification Code
                            </label>

                            <input
                                id="otp"
                                name="otp"
                                type="text"
                                inputMode="numeric"
                                autoComplete="one-time-code"
                                placeholder="123456"
                                value={otp}
                                onChange={(event) => {
                                    const value =
                                        event.target.value.replace(
                                            /\D/g,
                                            ""
                                        );

                                    if (value.length <= 6) {
                                        setOtp(value);
                                    }
                                }}
                                maxLength={6}
                                required
                                className="h-14 w-full rounded-lg border border-[#2a3035] bg-[#181c20] px-4 text-center text-xl tracking-[0.5em] text-[#e0e3e8] outline-none transition-all placeholder:text-[#5f666b] focus:border-[#43fe6d] focus:bg-[#1a1f23] focus:ring-2 focus:ring-[#43fe6d]/10"
                            />

                        </div>

                        <button
                            type="submit"
                            disabled={loading}
                            className="group flex h-12 w-full items-center justify-center gap-2 rounded-lg bg-[#43fe6d] px-6 font-['Hanken_Grotesk'] text-base font-bold text-[#00390f] transition-all duration-200 hover:bg-[#6cff80] disabled:cursor-not-allowed disabled:opacity-60"
                        >

                            {loading ? (
                                <>
                                    <span className="material-symbols-outlined animate-spin text-[20px]">
                                        progress_activity
                                    </span>

                                    Verifying...
                                </>
                            ) : (
                                <>
                                    Verify & Create Account

                                    <span className="material-symbols-outlined text-[20px] transition-transform duration-200 group-hover:translate-x-1">
                                        arrow_forward
                                    </span>
                                </>
                            )}

                        </button>

                    </form>

                    <button
                        type="button"
                        onClick={() => navigate("/register")}
                        className="mt-6 w-full text-center text-sm text-[#777f85] transition-colors hover:text-[#43fe6d]"
                    >
                        ← Back to Registration
                    </button>

                </div>

            </div>

        </div>
    );
}

export default VerifyNumber;