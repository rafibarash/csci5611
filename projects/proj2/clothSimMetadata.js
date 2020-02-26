// import * as foldingClothImg from "./foldingCloth.png";
// import * as stableClothImg from "./stableCloth.png";

const Metadata = {
  title: "Project #2 - Cloth Simulation",
  group: ["Tien Dinh (dinh0080@umn.edu)", "Rafi Barash (baras015@umn.edu)"],
  description: `
      This is our cloth simulation for project #2. In this simulation, you can see a cloth, through our 3D user controlled camera,
      free falling from its initial starting position, and colliding with a sphere before falling to the floor. The cloth 
      is simulated in 3D, and feels the effect of drag before having a 1-way collision with the sphere, eventually 
      coming to a stop due to friction with the cloth as well as the floor. The cloth is simulated as a 20x20 cloth
      at 30 FPS. We are currently using 1st order Eulerian integration to update the cloth state. As you can see, the cloth
      is textured, although for some reason when the cloth stretches, the texture does not stretch with it.
      `,
  code:
    "https://github.com/rafibarash/csci5611/tree/master/projects/proj2/ClothSphereInteraction",
  videoLink: "",
  featureList: [
    // Will need to update the times in the video for these features, just putting them in for now
    "0:00 - Realtime rendered cloth starting in initial position",
    "0:02 - Gravity pushes down on cloth",
    "0:03 - Drag causing cloth to fall more slowly",
    "0:05 - Cloth collides with sphere and spreads around it",
    "0:10 - Friction causes cloth to slow down when moving around the sphere and come to a stop on the floor",
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
      title: "Rotation (Spring) Lecture Slides (from class)",
      url: "https://canvas.umn.edu/courses/158159/modules/items/3572277",
      description: `
      We used these lecture slides to first understand the physics behind how a 
      spring works.
      `,
    },
    {
      title: "Cloth Simulation Reference Slides",
      url: "https://www.cs.umd.edu/class/fall2019/cmsc828X/LEC/Wei_Cloth.pdf",
      description: `
      We used these lecture slides to better understand the physics behind springs, and 
      to create our first attempt at a cloth simulation.
      `,
    },
    {
      title: "Sample Camera Code (from class)",
      url: "https://canvas.umn.edu/courses/158159/modules/items/3578341",
      description: `
      We used the sample camera given to us on canvas for our camera library... Realizing now that
      we did not show our camera functionality in the check-in video... oops
      `,
    },
    {
      title: "Triple Spring Code (from class)",
      url: "https://canvas.umn.edu/courses/158159/modules/items/3577748",
      description: `
      We used the triple spring code given to us on canvas to better understand how we can apply spring
      physics in Processing.
      `,
    },
    {
      title: "Nature of Code Chapter 5 - Physics Libraries",
      url: "https://natureofcode.com/book/chapter-5-physics-libraries/",
      description: `
      We used this resource to imagine how we could create our cloth/spring
      system in an object oriented fashion, loosely basing our Spring and Point classes
      off how we imagined the Verlet Physics library would implement it's classes. This inspired
      our final implementation of the cloth simulation checkpoint.
      `,
    },
  ],
};

export default Metadata;
