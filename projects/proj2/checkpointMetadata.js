import * as foldingClothImg from "./foldingCloth.png";
import * as stableClothImg from "./stableCloth.png";

const Metadata = {
  title: "Checkpoint #2 - Cloth Simulation",
  group: ["Tien Dinh (dinh0080@umn.edu)", "Rafi Barash (baras015@umn.edu)"],
  description: `
      This is our check in for project #2. In this simulation, you can see a cloth
      with vertical and horizontal threads anchored at the top left and top right 
      moving around freely after starting from an initial grid position. The 
      only external force on the cloth is gravity. Over time, the cloth stabilizes
      due to dampening.
      `,
  code:
    "https://github.com/rafibarash/csci5611/tree/master/projects/proj2/ClothThreadCheckpoint",
  videoLink: "https://www.youtube.com/embed/AqcS69Nigo0",
  featureList: [
    "0:04 - Gravity causing cloth to deviate from starting position",
    "0:12 - Cloth stabilizes due to dampening effect",
  ],
  imageList: [
    {
      url: foldingClothImg,
      alt: "Folded cloth, picture taken at beginning of simulation",
    },
    {
      url: stableClothImg,
      alt:
        "More stable cloth, picture taken later in simulation from result of dampening",
    },
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
