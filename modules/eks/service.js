const express = require("express");
const app = express();
const port = 5000;

app.use(express.static("public"));

// Root endpoint
app.get("/", (req, res) => {
  res.send("Welcome to the backend server!");
});

// API endpoint
app.get("/api/message", (req, res) => {
  res.json({ message: "Hello from the Backend!" });
});

// Health check endpoint
app.get("/api/health", (req, res) => {
  res.status(200).send("OK"); // Respond with a 200 status and a simple message
});

// Listen on all interfaces
app.listen(port, "0.0.0.0", () => {
  console.log(`Server running at http://0.0.0.0:${port}`);
});
