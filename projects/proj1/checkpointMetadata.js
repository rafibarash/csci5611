import * as imgURL from "./checkpoint_01_bouncing_ball.png";

const Metadata = {
  title: "Checkpoint #1 - 3D Bouncing Ball",
  group: ["Rafi Barash (baras015@umn.edu)"],
  description: `This is the checkpoint for project #1. Very rough simulation of a ball bouncing around in 3D. 
  The ball's movements are computed using Eulerian Numerical Integration.
  Whenever the mouse hits the ball with some velocity, the ball will move according to the direction and magnitude of the hit.`,
  code:
    "https://github.com/rafibarash/csci5611-portfolio/tree/master/src/projects/proj1/BouncingBall_3D",
  videoLink: "https://www.youtube.com/embed/FP6W6uRTXOc",
  featureList: [
    "0:06 - Ball changes direction off wall collision",
    "0:12 - Ball changes direction from mouse hit",
  ],
  imageList: [{ url: imgURL, alt: "Bouncing Ball" }],
  tools: [{ title: "Processing", url: "https://processing.org/" }],
  otherResources: null,
};

export default Metadata;
