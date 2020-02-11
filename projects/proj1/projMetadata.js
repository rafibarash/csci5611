// import * as treeImgURL from "./proj_tree_burning.png";
import * as treeSmokeImgURL from "./proj_tree_smoking.png";
import * as treeSmokeDistantImgURL from "./proj_tree_smoking_distant.png";
import * as waterFullyEvaporatingTreeImg from "./proj_water_evaporating_fire1.png";
import * as waterPartiallyEvaporatingTreeImg from "./proj_water_evaporating_fire2.png";

const Metadata = {
  title: "Project #1 - Particle System",
  group: ["Rafi Barash (baras015@umn.edu)"],
  description: `
      This is my particle simulation for project #1. In this simulation, you can see a tree burning in the
      bottom right, as well as a continously controlled hose (via the mouse) that spits out water. The fire particles continuously check for
      collisions with the water particles, and evaporate upon collision. The water particles are rendered as
      vertices to speed up the animation, while the fire particles are translucent and use a textured image. As you can see at the top 
      of the video, the second performance benchmark of 5,000 particles simulated and rendered at over 30 FPS was hit. I
      also implemented a 3D user controlled camera with the ability for translation in x, y, and z. I worked on adding rotation, but 
      struggle with rotating around the center of the animation rather than the left edge of the screen. Also, the fire particles
      were only implemented in 2D, as I was unable to figure out how to add texture to a 3D sphere.
      `,
  code:
    "https://github.com/rafibarash/csci5611-portfolio/tree/master/src/projects/proj1/PSystemEngine",
  videoLink: "https://www.youtube.com/embed/KCLLm187Hok",
  featureList: [
    "0:00 - Fire particles coming out of tree",
    "0:00 - Fire particles rendered translucent and with texture",
    "0:00 - Water particles continously coming out of cursor",
    "0:06 - Water low to ground, low bounce",
    "0:08 - Water high to ground, higher bounce",
    "0:15 - Water particles colliding with fire and causing fire particles to evaporate",
    "0:32 - Attempt to show my awful 3D user controlled camera, really struggled with that rotation",
    "THROUGHOUT - Performance Benchmark #2 hit: 5,000 particles simulated and rendered at over 30 FPS",
  ],
  imageList: [
    { url: treeSmokeDistantImgURL, alt: "Distant view of tree smoking" },
    { url: treeSmokeImgURL, alt: "Close up view of tree smoking from fire" },
    {
      url: waterPartiallyEvaporatingTreeImg,
      alt: "Water partially evaporating fire from tree",
    },
    {
      url: waterFullyEvaporatingTreeImg,
      alt: "Water fully evaporating fire from tree",
    },
  ],
  tools: [{ title: "Processing", url: "https://processing.org/" }],
  otherResources: [
    {
      title: "Particle System Lecture Slides",
      url: "https://canvas.umn.edu/courses/158159/modules/items/3546021",
      description: `I first understood the basics of a particle system off these lecture slides,
       and based my initial particle system off this.`,
    },
    {
      title: "Nature of Code - Particle Systems Tutorial",
      url: "https://natureofcode.com/book/chapter-4-particle-systems/",
      description: `I used many parts of this tutorial to better understand how a particle system works, and improve my particle system code. 
      In particular, I used this tutorial to create abstract Particle and ParticleSystem classes, that serve as the basis for my Water and Fire classes.
      This tutorial was also helpful in understanding how to use Gaussian Distribution to make a Fire look more realistic.`,
    },
  ],
};

export default Metadata;
