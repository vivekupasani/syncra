const { GoogleGenAI } = require("@google/genai");
let tokens = 10;

exports.reviewCode = async (req, res) => {
  const { userInput } = req.body;

  if (!userInput) {
    return res.status(400).json({ error: "Contents field is required" });
  }

  if (tokens <= 0) {
    return res
      .status(400)
      .json({ error: "Token is insufficient. Please buy tokens! 😥" });
  }

  try {
    // // Initialize GoogleGenAI
    const ai = new GoogleGenAI({
      apiKey: "AIzaSyCY55Lx8w5nTjYWXjNcu212IrheeLp-P0c",
    });

    const response = await ai.models.generateContent({
      model: "gemini-1.5-flash",
      contents: `${userInput} `,
    });

    tokens -= 1;

    return res.status(200).json({
      status: "success",
      message: response.text,
      tokensRemaining: tokens,
    });
  } catch (error) {
    console.error("Error generating content:", error);
    return res.status(500).json({
      status: "error",
      message: "Failed to generate content",
    });
  }
};

exports.getTokens = (req, res) => {
  const { tokensCount } = req.body;
  const tokensToAdd = parseInt(tokensCount);
  tokens = tokens + tokensToAdd;

  res.json({
    status: "success",
    message: `Tokens added successfully. Current tokens: ${tokens}`,
    tokensRemaining: tokens,
  });
};
