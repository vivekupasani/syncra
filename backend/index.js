require("dotenv").config();
const express = require("express");
const app = express();
const port = 8080;
const aiRoute = require("./routes/aiRoute");
const cors = require("cors");

app.get("/", (req, res) => {
  res.send(
    'Hello, World! Redirect to <a href="https://syncra.onrender.com/">syncra.onrender.com</a>'
  );
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

app.use("/api/ai", aiRoute);

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
