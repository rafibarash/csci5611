// import * as foldingClothImg from "./foldingCloth.png";
// import * as stableClothImg from "./stableCloth.png";

const Metadata = {
  title: "Project #2 - Fluid Simulation",
  group: ["Tien Dinh (dinh0080@umn.edu)", "Rafi Barash (baras015@umn.edu)"],
  description: `
      This is our fluid simulation for project #2. In this simulation, you can see 
      `,
  code:
    "https://github.com/rafibarash/csci5611/tree/master/projects/proj2/FluidSimulationMain",
  videoLink: "https://www.youtube.com/watch?v=hquSqXGp8yg",
  featureList: [
    "2D Eulerian Fluid Simulation",
    "Mouse-based user interaction",
    "The simulation can be paused with the 'v' button",
    "200x200 grid benchmarking at 30+ FPS",
  ],
  imageList: [
    // {
    //   url: foldingClothImg,
    //   alt: "Folded cloth, picture taken at beginning of simulation",
    // },
    // {
    //   url: stableClothImg,
    //   alt:
    //     "More stable cloth, picture taken later in simulation from result of dampening",
    // },
  ],
  tools: [{ title: "Processing", url: "https://processing.org/" }],
  otherResources: [
    {
      title: "Real-Time Fluid Dynamics for Games",
      url: "https://pdfs.semanticscholar.org/847f/819a4ea14bd789aca8bc88e85e906cfc657c.pdf",
      description: `
      Our implementation relies heavily on Stam's implementation, the only
      different is his implementation is in C++, and our is in Processing.
      `,
    },
    {
      title: "Fluid Simulation for Dummies",
      url: "https://www.mikeash.com/pyblog/fluid-simulation-for-dummies.html",
      description: `
      We also look at Ash's implementation of Stam's paper, but in 3D.
      `,
    },
  ],
};

export default Metadata;
