const express = require("express");
const app = express();
const port = 5000;

app.use(express.static("public"));

app.get("/api/message", (req, res) => {
  res.json({ message: "Hello from the Backend!" });
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
