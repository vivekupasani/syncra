const { GoogleGenAI, Modality } = require("@google/genai");
let tokens = 10;

const api_key = process.env.API_KEY;

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

exports.textInput = async (req, res) => {
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
    const ai = new GoogleGenAI({
      apiKey: api_key,
    });

    const response = await ai.models.generateContent({
      model: "gemini-1.5-flash",
      contents: `${userInput}`,
    });

    tokens -= 1;

    return res.status(200).json({
      status: "success",
      content: response.text,
      tokensRemaining: tokens,
      contentType: "text",
    });
  } catch (error) {
    console.error("Error generating content:", error);
    return res.status(500).json({
      status: "error",
      content: "Failed to generate content",
    });
  }
};

exports.imageInput = async (req, res) => {
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
    const ai = new GoogleGenAI({
      apiKey: api_key,
    });

    const response = await ai.models.generateContent({
      model: "gemini-2.0-flash-preview-image-generation",
      contents: userInput,
      config: {
        responseModalities: [Modality.TEXT, Modality.IMAGE],
      },
    });

    let imageBase64 = null;

    for (const part of response.candidates[0].content.parts) {
      if (part.inlineData) {
        imageBase64 = part.inlineData.data;
        break;
      }
    }

    if (!imageBase64) {
      return res.status(500).json({
        status: "error",
        message: "Image data not found in Gemini response",
      });
    }

    tokens -= 1;

    return res.status(200).json({
      status: "success",
      content: imageBase64,
      tokensRemaining: tokens,
      contentType: "image",
    });
  } catch (error) {
    console.error("Error generating image:", error);
    return res.status(500).json({
      status: "error",
      content: "Failed to generate image with Gemini",
    });
  }
};
