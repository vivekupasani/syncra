import React, { useState } from "react";
import { Mic, Users, Plus } from "lucide-react";
import one from "../public/one.png";

export default function SyncraWebsite() {
  const [visited, setVisited] = useState(100);

  return (
    <div className="min-h-screen bg-black relative overflow-hidden">
      {/* Background gradient effect */}
      <div className="absolute inset-0 bg-gradient-to-b from-black via-purple-900/20 to-black"></div>

      {/* Radial gradient effect in center */}
      <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-[1000px] h-[1000px] opacity-30">
        <div className="w-full h-full bg-gradient-radial from-purple-600/40 via-purple-800/20 to-transparent rounded-full"></div>
      </div>

      {/* Header */}
      <header className="relative z-10 flex justify-between items-center p-6">
        <div className="flex items-center space-x-3">
          <div className="flex -space-x-1">
            <div className="w-8 h-8 bg-gradient-to-br from-purple-500 to-pink-500 rounded-full border-2 border-black"></div>
            <div className="w-8 h-8 bg-gradient-to-br from-pink-500 to-orange-400 rounded-full border-2 border-black"></div>
          </div>
          <div className="text-white">
            <span className="font-bold text-lg">{visited}</span>
            <span className="ml-2 text-sm text-gray-300">People visited</span>
            <span className="ml-2 w-2 h-2 bg-green-400 rounded-full inline-block"></span>
          </div>
        </div>

        <button className="bg-gray-800/80 backdrop-blur-sm text-white px-6 py-2.5 rounded-full border border-gray-700 hover:bg-gray-700/80 transition-all duration-200 flex items-center space-x-2">
          <span className="font-medium">Launching Soon</span>
        </button>
      </header>

      {/* Main Content */}
      <main className="relative z-10 flex flex-col items-center justify-center px-6 py-12">
        {/* AI Voice Command Badge */}
        <div className="mb-12 bg-gray-800/60 backdrop-blur-sm rounded-full px-5 py-2.5 border border-gray-700/50">
          <div className="flex items-center space-x-3 text-white">
            <div className="w-6 h-6 bg-gradient-to-r from-purple-500 to-pink-500 rounded-full flex items-center justify-center p-1">
              <div className="w-full h-full bg-white rounded-full"></div>
            </div>
            <span className="text-sm font-medium text-gray-200">
              AI Voice Command
            </span>
          </div>
        </div>

        {/* Main Heading */}
        <h1 className="text-center mb-16 leading-tight">
          <div className="text-7xl md:text-8xl font-bold text-gray-400 mb-2">
            Effortless control
          </div>
          <div className="text-7xl md:text-8xl font-bold text-white">
            with Syncra
          </div>
        </h1>

        {/* App Screenshots Section */}
        <div className="w-full max-w-6xl mx-auto">
          <div className="text-center mb-12">
            <h2 className="text-4xl font-bold text-white mb-4">
              Experience the Power
            </h2>
            <p className="text-gray-400 text-xl max-w-2xl mx-auto">
              See how Syncra transforms your device interaction with intuitive
              voice commands
            </p>
          </div>

          {/* Screenshots Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-16">
            {/* Screenshot 1 */}
            <div className="group relative">
              <div className="absolute inset-0 bg-gradient-to-r from-purple-600/20 to-pink-600/20 rounded-2xl blur-xl opacity-0 group-hover:opacity-100 transition-all duration-500"></div>
              <div className="relative bg-gray-800/30 backdrop-blur-sm rounded-2xl p-4 border border-gray-700/50 hover:border-purple-500/50 transition-all duration-300 transform hover:scale-105 hover:-translate-y-2">
                <div className="aspect-[9/20] border-1 border-gray-500 hover:border-purple-500/50 bg-gradient-to-b from-gray-700 to-gray-800 rounded-xl flex items-center justify-center overflow-hidden">
                  <img
                    src="one.png"
                    alt="Syncra App Screen 1"
                    className="w-full h-full object-cover rounded-xl"
                    onError={(e) => {
                      e.target.style.display = "none";
                      e.target.nextSibling.style.display = "flex";
                    }}
                  />
                  <div className="hidden w-full h-full flex items-center justify-center text-gray-400">
                    <div className="text-center">
                      <Mic className="w-12 h-12 mx-auto mb-2 opacity-50" />
                      <p className="text-sm">Voice Control</p>
                    </div>
                  </div>
                </div>
                <div className="mt-4 text-center">
                  <h3 className="text-white font-semibold mb-1">
                    Voice Commands
                  </h3>
                  <p className="text-gray-400 text-sm">
                    Natural speech recognition
                  </p>
                </div>
              </div>
            </div>

            {/* Screenshot 2 */}
            <div className="group relative">
              <div className="absolute inset-0 bg-gradient-to-r from-blue-600/20 to-purple-600/20 rounded-2xl blur-xl opacity-0 group-hover:opacity-100 transition-all duration-500"></div>
              <div className="relative bg-gray-800/30 backdrop-blur-sm rounded-2xl p-4 border border-gray-700/50 hover:border-blue-500/50 transition-all duration-300 transform hover:scale-105 hover:-translate-y-2">
                <div className="aspect-[9/20] border-1 hover:border-blue-500/50 border-gray-500 bg-gradient-to-b from-gray-700 to-gray-800 rounded-xl flex items-center justify-center overflow-hidden">
                  <img
                    src="two.png"
                    alt="Syncra App Screen 2"
                    className="w-full h-full object-cover rounded-xl"
                    onError={(e) => {
                      e.target.style.display = "none";
                      e.target.nextSibling.style.display = "flex";
                    }}
                  />
                  <div className="hidden w-full h-full flex items-center justify-center text-gray-400">
                    <div className="text-center">
                      <Users className="w-12 h-12 mx-auto mb-2 opacity-50" />
                      <p className="text-sm">Smart Interface</p>
                    </div>
                  </div>
                </div>
                <div className="mt-4 text-center">
                  <h3 className="text-white font-semibold mb-1">
                    Smart Interface
                  </h3>
                  <p className="text-gray-400 text-sm">Intuitive design</p>
                </div>
              </div>
            </div>

            {/* Screenshot 3 */}
            <div className="group relative">
              <div className="absolute inset-0 bg-gradient-to-r from-green-600/20 to-blue-600/20 rounded-2xl blur-xl opacity-0 group-hover:opacity-100 transition-all duration-500"></div>
              <div className="relative bg-gray-800/30 backdrop-blur-sm rounded-2xl p-4 border border-gray-700/50 hover:border-green-500/50 transition-all duration-300 transform hover:scale-105 hover:-translate-y-2">
                <div className="aspect-[9/20] border-1 hover:border-green-500/50 border-gray-500 bg-gradient-to-b from-gray-700 to-gray-800 rounded-xl flex items-center justify-center overflow-hidden">
                  <img
                    src="three.png"
                    alt="Syncra App Screen 3"
                    className="w-full h-full object-cover rounded-xl"
                    onError={(e) => {
                      e.target.style.display = "none";
                      e.target.nextSibling.style.display = "flex";
                    }}
                  />
                  <div className="hidden w-full h-full flex items-center justify-center text-gray-400">
                    <div className="text-center">
                      <Plus className="w-12 h-12 mx-auto mb-2 opacity-50" />
                      <p className="text-sm">Quick Actions</p>
                    </div>
                  </div>
                </div>
                <div className="mt-4 text-center">
                  <h3 className="text-white font-semibold mb-1">
                    Quick Actions
                  </h3>
                  <p className="text-gray-400 text-sm">Instant responses</p>
                </div>
              </div>
            </div>

            {/* Screenshot 4 */}
            <div className="group relative">
              <div className="absolute inset-0 bg-gradient-to-r from-pink-600/20 to-orange-600/20 rounded-2xl blur-xl opacity-0 group-hover:opacity-100 transition-all duration-500"></div>
              <div className="relative bg-gray-800/30 backdrop-blur-sm rounded-2xl p-4 border border-gray-700/50 hover:border-pink-500/50 transition-all duration-300 transform hover:scale-105 hover:-translate-y-2">
                <div className="aspect-[9/20] border-1 border-gray-500 hover:border-pink-500/50 bg-gradient-to-b from-gray-700 to-gray-800 rounded-xl flex items-center justify-center overflow-hidden">
                  <img
                    src="four.png"
                    alt="Syncra App Screen 4"
                    className="w-full h-full object-cover rounded-xl"
                    onError={(e) => {
                      e.target.style.display = "none";
                      e.target.nextSibling.style.display = "flex";
                    }}
                  />
                  <div className="hidden w-full h-full flex items-center justify-center text-gray-400">
                    <div className="text-center">
                      <div className="w-12 h-12 mx-auto mb-2 bg-gradient-to-r from-purple-500 to-pink-500 rounded-full opacity-50"></div>
                      <p className="text-sm">AI Powered</p>
                    </div>
                  </div>
                </div>
                <div className="mt-4 text-center">
                  <h3 className="text-white font-semibold mb-1">AI Powered</h3>
                  <p className="text-gray-400 text-sm">
                    Intelligent automation
                  </p>
                </div>
              </div>
            </div>
          </div>

          {/* Call to Action */}
          <div className="text-center">
            <button className="bg-gradient-to-r from-purple-600 to-pink-500 text-white font-semibold py-4 px-8 rounded-full hover:from-purple-700 hover:to-pink-600 transition-all duration-300 transform hover:scale-105 shadow-lg text-lg">
              l a u n c h i n g - s o o n - f o r - a n d r o i d - i o s - a n d - w e b - p l a t f o r m s
            </button>
          </div>
        </div>
      </main>
    </div>
  );
}
