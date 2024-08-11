// src/components/Background.js
// src/components/AnimatedBackground.js
"use client";

import React from 'react';

const AnimatedBackground = () => {
    return (
        <div className="relative">

            <div className="min-h-screen bg-gradient-to-r from-blue-900 via-purple-900 to-blue-900 flex items-center justify-center relative">
                <div className="absolute inset-0 bg-cover bg-center z-10 opacity-50" style={{ backgroundImage: "url('/generated-image.png')" }}></div>
                <div className="absolute inset-0 flex justify-center items-center z-20">
                    <div className="text-center text-white">
                        <h1 className="text-4xl font-bold mb-4">Welcome to Atlantic Insurance</h1>
                        <p className="text-lg">EReduce your risks, enhance your life experience, and secure your future assets.</p>
                    </div>
                </div>
                <div className="absolute inset-0 z-0">
                    <div className="w-full h-full flex items-center justify-center">
                        <div className="w-64 h-64 bg-white opacity-20 animate-pulse rounded-full"></div>
                        <div className="w-48 h-48 bg-white opacity-30 animate-ping rounded-full"></div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default AnimatedBackground;

