/**
  Copyright (C) 2012-2025 by Autodesk, Inc.
  All rights reserved.

  Fagor Lathe post processor configuration.

  $Revision: 44191 10f6400eaf1c75a27c852ee82b57479e7a9134c0 $
  $Date: 2025-08-21 13:23:15 $

  FORKID {43EDD3C3-577F-4C12-8F11-315E68ADEACC}
*/

description = "FAGOR Turning";
vendor = "FAGOR";
vendorUrl = "http://www.fagorautomation.com";
legal = "Copyright (C) 2012-2025 by Autodesk, Inc.";
certificationLevel = 2;
minimumRevision = 45702;

longDescription = "Generic turning post for FAGOR 8037/8055 T models. Use Turret 0 for Positional Turret, Turret 101 for QCTP on X- Post, Turret 102 for QCTP on X+ Post, Turret 103 for Gang Tooling on X- Post, Turret 104 for Gang Tooling on X+ Tool Post.";

extension = "pit";
programNameIsInteger = true;
setCodePage("ascii");

capabilities = CAPABILITY_TURNING;
tolerance = spatial(0.002, MM);

minimumChordLength = spatial(0.25, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(180);
allowHelicalMoves = true;
allowedCircularPlanes = undefined; // allow any circular motion

// user-defined properties
properties = {
  writeMachine: {
    title      : "Write machine",
    description: "Output the machine settings in the header of the code.",
    group      : "formats",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  writeTools: {
    title      : "Write tool list",
    description: "Output a tool list in the header of the code.",
    group      : "formats",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  safePositionMethod: {
    title      : "Safe Retracts",
    description: "Select your desired retract option.",
    group      : "homePositions",
    type       : "enum",
    values     : [
      {title:"G74", id:"G74"},
      {title:"G53", id:"G53"}
    ],
    value: "G53",
    scope: "post"
  },
  safePositionStyle: {
    title      : "Safe retract style",
    description: "Select your desired order for the axes to retract.",
    group      : "homePositions",
    type       : "enum",
    values     : [
      {title:"Only X", id:"X"},
      {title:"Only Z", id:"Z"},
      {title:"Both X then Z", id:"XZ"},
      {title:"Both Z then X", id:"ZX"},
      {title:"Both same line", id:"singleLineXZ"}
    ],
    value: "XZ",
    scope: "post"
  },
  approachStyle: {
    title      : "Approach style",
    description: "Select your desired order for the axes to approach.",
    type       : "enum",
    group      : "preferences",
    values     : [
      {title:"First Z then X", id:"ZX"},
      {title:"Both XZ in same line", id:"singleLineXZ"}
    ],
    value: "singleLineXZ",
    scope: "post"
  },
  showSequenceNumbers: {
    title      : "Use sequence numbers",
    description: "'Yes' outputs sequence numbers on each block, 'Only on tool change' outputs sequence numbers on tool change blocks only, and 'No' disables the output of sequence numbers.",
    group      : "formats",
    type       : "enum",
    values     : [
      {title:"Yes", id:"true"},
      {title:"No", id:"false"},
      {title:"Only on tool change", id:"toolChange"}
    ],
    value: "true",
    scope: "post"
  },
  sequenceNumberStart: {
    title      : "Start sequence number",
    description: "The number at which to start the sequence numbers.",
    group      : "formats",
    type       : "integer",
    value      : 10,
    scope      : "post"
  },
  sequenceNumberIncrement: {
    title      : "Sequence number increment",
    description: "The amount by which the sequence number is incremented by in each block.",
    group      : "formats",
    type       : "integer",
    value      : 1,
    scope      : "post"
  },
  optionalStop: {
    title      : "Optional stop",
    description: "Outputs optional stop code during when necessary in the code.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  separateWordsWithSpace: {
    title      : "Separate words with space",
    description: "Adds spaces between words if 'yes' is selected.",
    group      : "formats",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  useRadius: {
    title      : "Radius arcs",
    description: "If yes is selected, arcs are outputted using radius values rather than IJK.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  maximumSpindleSpeed: {
    title      : "Max spindle speed",
    description: "Defines the maximum spindle speed allowed by your machines.",
    group      : "configuration",
    type       : "integer",
    range      : [0, 999999999],
    value      : 6000,
    scope      : "post"
  },
  homePositionX: {
    title      : "G53 home position X",
    description: "G53 X-axis home position.",
    group      : "homePositions",
    type       : "number",
    value      : 5,
    scope      : "post"
  },
  homePositionZ: {
    title      : "G53 home position Z",
    description: "G53 Z-axis home position.",
    group      : "homePositions",
    type       : "number",
    value      : 20,
    scope      : "post"
  },
  useCycles: {
    title      : "Use cycles",
    description: "Specifies if canned drilling cycles should be used.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  useParametricFeed: {
    title      : "Parametric feed",
    description: "Specifies the feed value that should be output using a Q value.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  showNotes: {
    title      : "Show notes",
    description: "Writes operation notes as comments in the outputted code.",
    group      : "formats",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  debugThreading: {
    title      : "Debug threading",
    description: "Outputs thread-cycle debug comments for diagnosing G86 routing.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  
  subSpindleGrabOpenMainChuckCode: {
    title      : "Sub-spindle grab - open main chuck M-code",
    description: "M-code to open the main spindle chuck during grab (e.g., 11)",
    group      : "preferences",
    type       : "integer",
    value      : 11,
    scope      : "post"
  },
  
  subSpindleGrabCloseSubChuckCode: {
    title      : "Sub-spindle grab - close sub chuck M-code",
    description: "M-code to close the sub spindle chuck during grab (e.g., 10)",
    group      : "preferences",
    type       : "integer",
    value      : 10,
    scope      : "post"
  },
  
  subSpindleGrabBarPullTool: {
    title      : "Sub-spindle grab/bar-pull tool number",
    description: "Tool number to use for spindle grab and bar-pull operations (typically 99)",
    group      : "preferences",
    type       : "integer",
    value      : 99,
    scope      : "post"
  },
  
  machineVendor: {
    title      : "Machine vendor",
    description: "Machine vendor/company name",
    group      : "configuration",
    type       : "string",
    value      : "Tactical Keychains LLC",
    scope      : "post"
  },
  
  machineModel: {
    title      : "Machine model",
    description: "Machine model name",
    group      : "configuration",
    type       : "string",
    value      : "ZV-27",
    scope      : "post"
  },
  
  machineDescription: {
    title      : "Machine description",
    description: "Machine control/DNC description",
    group      : "configuration",
    type       : "string",
    value      : "FAGOR 8055i-TC",
    scope      : "post"
  }
  
  // DEVELOPER NOTE: Sub-spindle bar-pull implementation
  // This post supports Fusion 360's secondary-spindle operations:
  //   - "secondary-spindle-grab": Positions bar puller tool and moves to chuck grip position
  //   - "secondary-spindle-pull": Unclamps main chuck, pulls stock, clamps sub chuck
  //   - "secondary-spindle-return": Legacy cycle type (for older Fusion versions)
  // 
  // Properties above control M-codes and tool number:
  //   - subSpindleGrabOpenMainChuckCode: M-code to unclamp main chuck (default M11)
  //   - subSpindleGrabCloseSubChuckCode: M-code to clamp sub chuck (default M10)
  //   - subSpindleGrabBarPullTool: Tool number for bar puller (default T99)
  //
  // Cycle parameters read from Fusion:
  //   - cycle.stopSpindle: 0/1 to control spindle during operation
  //   - cycle.feedPosition: Z position before pulling
  //   - cycle.chuckPosition: Z position where chuck grips stock
  //   - cycle.pullingDistance: How far to pull stock
  //   - cycle.pullPositionWorkCS: [X,Y,Z] final position after pull
  //   - cycle.feedrate: Feed rate for motions
  //   - cycle.dwell: Dwell time in seconds (converted to centiseconds for G4 K)
};

// wcs definiton
wcsDefinitions = {
  useZeroOffset: false,
  wcs          : [
    {name:"Standard", format:"G", range:[54, 57]},
    {name:"Extended", format:"G159 N", range:[7, 20]}
  ]
};

var singleLineCoolant = false; // specifies to output multiple coolant codes in one line rather than in separate lines
// samples:
// {id: COOLANT_THROUGH_TOOL, on: 88, off: 89}
// {id: COOLANT_THROUGH_TOOL, on: [8, 88], off: [9, 89]}
// {id: COOLANT_THROUGH_TOOL, on: "M88 P3 (myComment)", off: "M89"}
var coolants = [
  {id:COOLANT_FLOOD, on:8},
  {id:COOLANT_MIST},
  {id:COOLANT_THROUGH_TOOL},
  {id:COOLANT_AIR},
  {id:COOLANT_AIR_THROUGH_TOOL},
  {id:COOLANT_SUCTION},
  {id:COOLANT_FLOOD_MIST},
  {id:COOLANT_FLOOD_THROUGH_TOOL},
  {id:COOLANT_OFF, off:9}
];

var permittedCommentChars = " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,=_-";

var gFormat = createFormat({prefix:"G", decimals:0});
var mFormat = createFormat({prefix:"M", decimals:0});
var dFormat = createFormat({prefix:"D", decimals:0});
var oFormat = createFormat({prefix:"O", decimals:0, width:6, zeropad:true});

var spatialFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true});
var xFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true, scale:2}); // diameter mode
var yFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true});
var zFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true});
var rFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true}); // radius
var feedFormat = createFormat({decimals:(unit == MM ? 4 : 5), forceDecimal:true});
var iFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true, scale:1});
var pitchFormat = createFormat({decimals:5, forceDecimal:true});
var toolFormat = createFormat({decimals:0});
var rpmFormat = createFormat({decimals:0});
var kFormat = createFormat({decimals:0}); // centiseconds // range 1-9999

var xOutput; // xOutput is defined in setDirectionX()
var yOutput = createVariable({prefix:"Y"}, yFormat);
var zOutput = createVariable({onchange:function() {retracted[Z] = false;}, prefix:"Z"}, zFormat);
var feedOutput = createVariable({prefix:"F"}, feedFormat);
var pitchOutput = createVariable({prefix:"L", force:true}, pitchFormat);
var sOutput = createVariable({prefix:"S", force:true}, rpmFormat);

// circular output
var kOutput = createReferenceVariable({prefix:"K", force:true}, spatialFormat);
var iOutput; // iOutput is defined in setDirectionX()

var gMotionModal = createModal({}, gFormat); // modal group 1 // G0-G3, ...
var gPlaneModal = createModal({onchange:function () {gMotionModal.reset();}}, gFormat); // modal group 2 // G17-19
var gAbsIncModal = createModal({}, gFormat); // modal group 3 // G90-91 // only for B and C mode
var gFeedModeModal = createModal({}, gFormat); // modal group 5 // G98-99 / G94-95
var gSpindleModeModal = createModal({}, gFormat); // modal group 5 // G96-97
var gSpindleSelectModal = createModal({}, gFormat); // modal group G28-G29
var gUnitModal = createModal({}, gFormat); // modal group 6 // G20-21
var gCycleModal = createModal({force:true}, gFormat); // modal group 9 // G81, ...

// fixed settings
var firstFeedParameter = 500;
var gotSecondarySpindle = true;
var gotTailStock = false;

var XAXIS = 0;
var ZAXIS = 1;
var BOTH = 2;

var WARNING_WORK_OFFSET = 0;

var QCTP = 0;
var TURRET = 1;
var GANG = 2;

var FRONT = -1;
var REAR = 1;

// collected state
var sequenceNumber;
var currentWorkOffset;
var optionalSection = false;
var forceSpindleSpeed = false;
var tapping = false;
var activeMovements; // do not use by default
var currentFeedId;
var previousSpindle = SPINDLE_PRIMARY;
var toolingData;
var previousToolingData;
var firstPosition = false;
// DEVELOPER NOTE: Bar-pull state tracking variables
// Bar-pull operations consist of TWO separate Fusion cycles that execute sequentially:
//   1. "secondary-spindle-grab" - Position tool and grip stock
//   2. "secondary-spindle-pull" - Unclamp, pull, clamp
// The barPullSequenceActive flag tracks BOTH cycles to suppress unwanted spindle starts
// between the grab and pull operations. Set TRUE in grab cycle, cleared in onClose().
var isSubSpindleGrab = false;
var isSubSpindleBarPull = false;
var subSpindleOperationActive = false;
var shouldStopSpindleForBarPull = false;
var barPullSequenceActive = false;
var retracted = new Array(false, false, false); // specifies that the tool has been retracted to the safe plane
var fpmCode = 94;
var fprCode = 95;

function getCode(code) {
  switch (code) {
  // case "PART_CATCHER_ON":
  // return mFormat.format(SPECIFY YOUR CODE HERE);
  // case "PART_CATCHER_OFF":
  // return mFormat.format(SPECIFY YOUR CODE HERE);
  // case "TAILSTOCK_ON":
  // return mFormat.format(SPECIFY YOUR CODE HERE);
  // case "TAILSTOCK_OFF":
  // return mFormat.format(SPECIFY YOUR CODE HERE);
  // case "ENGAGE_C_AXIS":
  // machineState.cAxisIsEngaged = true;
  // return cAxisEngageModal.format(UNSUPPORTED);
  // case "DISENGAGE_C_AXIS":
  // machineState.cAxisIsEngaged = false;
  // return cAxisEngageModal.format(UNSUPPORTED);
  // case "POLAR_INTERPOLATION_ON":
  // return gPolarModal.format(UNSUPPORTED);
  // case "POLAR_INTERPOLATION_OFF":
  // return gPolarModal.format(UNSUPPORTED);
  // case "STOP_LIVE_TOOL":
  // machineState.liveToolIsActive = false;
  // return mFormat.format(UNSUPPORTED);
  // case "STOP_MAIN_SPINDLE":
  // machineState.mainSpindleIsActive = false;
  // return mFormat.format(UNSUPPORTED);
  // case "STOP_SUB_SPINDLE":
  // machineState.subSpindleIsActive = false;
  // return mFormat.format(UNSUPPORTED);
  // case "START_LIVE_TOOL_CW":
  // machineState.liveToolIsActive = true;
  // return mFormat.format(UNSUPPORTED);
  // case "START_LIVE_TOOL_CCW":
  // machineState.liveToolIsActive = true;
  // return mFormat.format(UNSUPPORTED);
  case "START_MAIN_SPINDLE_CW":
    // machineState.mainSpindleIsActive = true;
    return mFormat.format(3);
  case "START_MAIN_SPINDLE_CCW":
    // machineState.mainSpindleIsActive = true;
    return mFormat.format(4);
  // case "START_SUB_SPINDLE_CW":
    // machineState.subSpindleIsActive = true;
    // return mFormat.format(UNSUPPORTED);
  // case "START_SUB_SPINDLE_CCW":
    // machineState.subSpindleIsActive = true;
    // return mFormat.format(UNSUPPORTED);
  // case "MAIN_SPINDLE_BRAKE_ON":
    // machineState.mainSpindleBrakeIsActive = true;
    // return cAxisBrakeModal.format(UNSUPPORTED);
  // case "MAIN_SPINDLE_BRAKE_OFF":
    // machineState.mainSpindleBrakeIsActive = false;
    // return cAxisBrakeModal.format(UNSUPPORTED);
  // case "SUB_SPINDLE_BRAKE_ON":
    // machineState.subSpindleBrakeIsActive = true;
    // return cAxisBrakeModal.format(UNSUPPORTED);
  // case "SUB_SPINDLE_BRAKE_OFF":
    // machineState.subSpindleBrakeIsActive = false;
    // return cAxisBrakeModal.format(UNSUPPORTED);
  case "FEED_MODE_UNIT_REV":
    return gFeedModeModal.format(fprCode);
  case "FEED_MODE_UNIT_MIN":
    return gFeedModeModal.format(fpmCode);
  case "CONSTANT_SURFACE_SPEED_ON":
    return gSpindleModeModal.format(96);
  case "CONSTANT_SURFACE_SPEED_OFF":
    return gSpindleModeModal.format(97);
  // case "MAINSPINDLE_AIR_BLAST_ON":
    // return mFormat.format(UNSUPPORTED);
  // case "MAINSPINDLE_AIR_BLAST_OFF":
    // return mFormat.format(UNSUPPORTED);
  // case "SUBSPINDLE_AIR_BLAST_ON":
    // return mFormat.format(UNSUPPORTED);
  // case "SUBSPINDLE_AIR_BLAST_OFF":
    // return mFormat.format(UNSUPPORTED);
  // case "CLAMP_PRIMARY_CHUCK":
    // return mFormat.format(UNSUPPORTED);
  // case "UNCLAMP_PRIMARY_CHUCK":
    // return mFormat.format(UNSUPPORTED);
  // case "CLAMP_SECONDARY_CHUCK":
    // return mFormat.format(UNSUPPORTED);
  // case "UNCLAMP_SECONDARY_CHUCK":
    // return mFormat.format(UNSUPPORTED);
  // case "SPINDLE_SYNCHRONIZATION_ON":
    // machineState.spindleSynchronizationIsActive = true;
    // return gSynchronizedSpindleModal.format(UNSUPPORTED);
  // case "SPINDLE_SYNCHRONIZATION_OFF":
    // machineState.spindleSynchronizationIsActive = false;
    // return gSynchronizedSpindleModal.format(UNSUPPORTED);
  // case "START_CHIP_TRANSPORT":
    // return mFormat.format(UNSUPPORTED);
  // case "STOP_CHIP_TRANSPORT":
    // return mFormat.format(UNSUPPORTED);
  // case "OPEN_DOOR":
    // return mFormat.format(UNSUPPORTED);
  // case "CLOSE_DOOR":
    // return mFormat.format(UNSUPPORTED);
  default:
    error(localize("Command " + code + " is not defined."));
    return 0;
  }
}

function isSpindleSpeedDifferent() {
  if (isFirstSection()) {
    return true;
  }
  if (getPreviousSection().getTool().clockwise != tool.clockwise) {
    return true;
  }
  if (tool.getSpindleMode() == SPINDLE_CONSTANT_SURFACE_SPEED) {
    if ((getPreviousSection().getTool().getSpindleMode() != SPINDLE_CONSTANT_SURFACE_SPEED) ||
        rpmFormat.areDifferent(getPreviousSection().getTool().surfaceSpeed, tool.surfaceSpeed)) {
      return true;
    }
  } else {
    if ((getPreviousSection().getTool().getSpindleMode() != SPINDLE_CONSTANT_SPINDLE_SPEED) ||
        rpmFormat.areDifferent(getPreviousSection().getTool().spindleRPM, spindleSpeed)) {
      return true;
    }
  }
  return false;
}

/**
  Writes the specified block.
*/
function writeBlock() {
  if (getProperty("showSequenceNumbers") == "true") {
    if (optionalSection) {
      var text = formatWords(arguments);
      if (text) {
        writeWords("/", "N" + sequenceNumber, text);
      }
    } else {
      writeWords2("N" + sequenceNumber, arguments);
    }
    sequenceNumber += getProperty("sequenceNumberIncrement");
  } else {
    if (optionalSection) {
      writeWords2("/", arguments);
    } else {
      writeWords(arguments);
    }
  }
}

/**
  Writes the specified optional block.
*/
function writeOptionalBlock() {
  if (getProperty("showSequenceNumbers") == "true") {
    var words = formatWords(arguments);
    if (words) {
      writeWords("/", "N" + sequenceNumber, words);
      sequenceNumber += getProperty("sequenceNumberIncrement");
    }
  } else {
    writeWords2("/", arguments);
  }
}

function formatComment(text) {
  return ";" + filterText(String(text).toUpperCase(), permittedCommentChars).replace(/[()]/g, "");
}

/**
  Writes the specified block - used for tool changes only.
*/
function writeToolBlock() {
  var show = getProperty("showSequenceNumbers");
  setProperty("showSequenceNumbers", (show == "true" || show == "toolChange") ? "true" : "false");
  writeBlock(arguments);
  setProperty("showSequenceNumbers", show);
}

/**
  Output a comment.
*/
function writeComment(text) {
  writeln(formatComment(text));
}

function onOpen() {
  if (getProperty("debugThreading")) {
    writeComment("THREADDBG ENABLED");
  }

  if (getProperty("useRadius")) {
    maximumCircularSweep = toRad(90); // avoid potential center calculation errors for CNC
  }

  yOutput.disable();

  if (!getProperty("separateWordsWithSpace")) {
    setWordSeparator("");
  }

  sequenceNumber = getProperty("sequenceNumberStart");
  writeln("%" + programComment.slice(0, 20).replace(/[,]/g, " ") + ",MX,"); // max 20 chars

  if (programName) {
    var programId;
    try {
      programId = getAsInt(programName);
    } catch (e) {
      error(localize("Program name must be a number."));
      return;
    }
    if ((programId < 1) || (programId > 999999)) {
      error(localize("Program number is out of range."));
      return;
    }
    writeln(oFormat.format(programId));
  } else {
    error(localize("Program name has not been specified."));
    return;
  }

  // Output formatted machine configuration header
  writeln(";(---------------- MACHINE INFO -------------------)");
  if (getProperty("machineVendor")) {
    writeln(";(Vendor: " + getProperty("machineVendor") + ")");
  }
  if (getProperty("machineModel")) {
    writeln(";(Model: " + getProperty("machineModel") + ")");
  }
  if (getProperty("machineDescription")) {
    writeln(";(DNC: " + getProperty("machineDescription") + ")");
  }

  if ((getNumberOfSections() > 0) && (getSection(0).workOffset == 0)) {
    for (var i = 0; i < getNumberOfSections(); ++i) {
      if (getSection(i).workOffset > 0) {
        error(localize("Using multiple work offsets is not possible if the initial work offset is 0."));
        return;
      }
    }
  }
  // Output formatted tool table header
  writeln(";(----------------- TOOL TABLE --------------------)");
  var zRanges = {};
  if (is3D()) {
    var numberOfSections = getNumberOfSections();
    for (var i = 0; i < numberOfSections; ++i) {
      var section = getSection(i);
      var zRange = section.getGlobalZRange();
      var tool = section.getTool();
      if (zRanges[tool.number]) {
        zRanges[tool.number].expandToRange(zRange);
      } else {
        zRanges[tool.number] = zRange;
      }
    }
  }

  var tools = getToolTable();
  if (tools.getNumberOfTools() > 0) {
    for (var i = 0; i < tools.getNumberOfTools(); ++i) {
      var tool = tools.getTool(i);
      var compensationOffset = tool.isTurningTool() ? tool.compensationOffset : tool.lengthOffset;
      var comment = "T" + toolFormat.format(tool.number * 100 + compensationOffset % 100) + " " +
        (tool.diameter != 0 ? "D=" + spatialFormat.format(tool.diameter) + " " : "") +
        (tool.isTurningTool() ? localize("NR") + "=" + spatialFormat.format(tool.noseRadius) : localize("CR") + "=" + spatialFormat.format(tool.cornerRadius)) +
        (tool.taperAngle > 0 && (tool.taperAngle < Math.PI) ? " " + localize("TAPER") + "=" + taperFormat.format(tool.taperAngle) + localize("deg") : "") +
        (zRanges[tool.number] ? " - " + localize("ZMIN") + "=" + spatialFormat.format(zRanges[tool.number].getMinimum()) : "") +
         " - " + localize(getToolTypeName(tool.type));
      writeComment(comment);
    }
  }

  // Output program start header
  writeln(";(---------------- BEGIN PROGRAM ------------------)");

  // absolute coordinates and feed per min
  writeBlock(gAbsIncModal.format(90), getCode("FEED_MODE_UNIT_REV"), gPlaneModal.format(18));

  switch (unit) {
  case IN:
    writeBlock(gUnitModal.format(70));
    break;
  case MM:
    writeBlock(gUnitModal.format(71));
    break;
  }

  writeBlock(gFormat.format(151)); // Program X-axis in diameter mode

  writeBlock(gFormat.format(92), sOutput.format(getProperty("maximumSpindleSpeed")));

  onCommand(COMMAND_START_CHIP_TRANSPORT);
}

function onComment(message) {
  writeComment(message);
}

/** Force output of X, Y, and Z. */
function forceXYZ() {
  xOutput.reset();
  yOutput.reset();
  zOutput.reset();
}

function forceFeed() {
  currentFeedId = undefined;
  feedOutput.reset();
}

/** Force output of X, Y, Z, and F on next output. */
function forceAny() {
  forceXYZ();
  forceFeed();
}

function forceModals() {
  if (arguments.length == 0) { // reset all modal variables listed below
    if (typeof gMotionModal != "undefined") {
      gMotionModal.reset();
    }
    if (typeof gPlaneModal != "undefined") {
      gPlaneModal.reset();
    }
    if (typeof gAbsIncModal != "undefined") {
      gAbsIncModal.reset();
    }
    if (typeof gFeedModeModal != "undefined") {
      gFeedModeModal.reset();
    }
  } else {
    for (var i in arguments) {
      arguments[i].reset(); // only reset the modal variable passed to this function
    }
  }
}

function FeedContext(id, description, feed) {
  this.id = id;
  this.description = description;
  this.feed = feed;
}

function getFeed(f) {
  if (activeMovements) {
    var feedContext = activeMovements[movement];
    if (feedContext != undefined) {
      if (!feedFormat.areDifferent(feedContext.feed, f)) {
        if (feedContext.id == currentFeedId) {
          return ""; // nothing has changed
        }
        forceFeed();
        currentFeedId = feedContext.id;
        return "FP" + (firstFeedParameter + feedContext.id);
      }
    }
    currentFeedId = undefined; // force Q feed next time
  }
  if (gFeedModeModal.getCurrent() == fprCode) {
    f = (feedFormat.format(f) <= 0) ? (Math.pow(10, feedFormat.getNumberOfDecimals() * -1)) : f;
  }
  return feedOutput.format(f); // use feed value
}

function initializeActiveFeeds() {
  activeMovements = new Array();
  var movements = currentSection.getMovements();
  var feedPerRev = currentSection.feedMode == FEED_PER_REVOLUTION;

  var id = 0;
  var activeFeeds = new Array();
  if (hasParameter("operation:tool_feedCutting")) {
    if (movements & ((1 << MOVEMENT_CUTTING) | (1 << MOVEMENT_LINK_TRANSITION) | (1 << MOVEMENT_EXTENDED))) {
      var feedContext = new FeedContext(id, localize("Cutting"), feedPerRev ? getParameter("operation:tool_feedCuttingRel") : getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_CUTTING] = feedContext;
      if (!hasParameter("operation:tool_feedTransition")) {
        activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
      }
      activeMovements[MOVEMENT_EXTENDED] = feedContext;
    }
    ++id;
    if (movements & (1 << MOVEMENT_PREDRILL)) {
      feedContext = new FeedContext(id, localize("Predrilling"), feedPerRev ? getParameter("operation:tool_feedCuttingRel") : getParameter("operation:tool_feedCutting"));
      activeMovements[MOVEMENT_PREDRILL] = feedContext;
      activeFeeds.push(feedContext);
    }
    ++id;
  }

  if (hasParameter("operation:finishFeedrate")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var finishFeedrateRel;
      if (hasParameter("operation:finishFeedrateRel")) {
        finishFeedrateRel = getParameter("operation:finishFeedrateRel");
      } else if (hasParameter("operation:finishFeedratePerRevolution")) {
        finishFeedrateRel = getParameter("operation:finishFeedratePerRevolution");
      }
      var feedContext = new FeedContext(id, localize("Finish"), feedPerRev ? finishFeedrateRel : getParameter("operation:finishFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), feedPerRev ? getParameter("operation:tool_feedCuttingRel") : getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedEntry")) {
    if (movements & (1 << MOVEMENT_LEAD_IN)) {
      var feedContext = new FeedContext(id, localize("Entry"), feedPerRev ? getParameter("operation:tool_feedEntryRel") : getParameter("operation:tool_feedEntry"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_IN] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LEAD_OUT)) {
      var feedContext = new FeedContext(id, localize("Exit"), feedPerRev ? getParameter("operation:tool_feedExitRel") : getParameter("operation:tool_feedExit"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_OUT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:noEngagementFeedrate")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), feedPerRev ? getParameter("operation:noEngagementFeedrateRel") : getParameter("operation:noEngagementFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting") &&
             hasParameter("operation:tool_feedEntry") &&
             hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(
        id,
        localize("Direct"),
        Math.max(
          feedPerRev ? getParameter("operation:tool_feedCuttingRel") : getParameter("operation:tool_feedCutting"),
          feedPerRev ? getParameter("operation:tool_feedEntryRel") : getParameter("operation:tool_feedEntry"),
          feedPerRev ? getParameter("operation:tool_feedExitRel") : getParameter("operation:tool_feedExit")
        )
      );
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:reducedFeedrate")) {
    if (movements & (1 << MOVEMENT_REDUCED)) {
      var feedContext = new FeedContext(id, localize("Reduced"), feedPerRev ? getParameter("operation:reducedFeedrateRel") : getParameter("operation:reducedFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_REDUCED] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedRamp")) {
    if (movements & ((1 << MOVEMENT_RAMP) | (1 << MOVEMENT_RAMP_HELIX) | (1 << MOVEMENT_RAMP_PROFILE) | (1 << MOVEMENT_RAMP_ZIG_ZAG))) {
      var feedContext = new FeedContext(id, localize("Ramping"), feedPerRev ? getParameter("operation:tool_feedRampRel") : getParameter("operation:tool_feedRamp"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_RAMP] = feedContext;
      activeMovements[MOVEMENT_RAMP_HELIX] = feedContext;
      activeMovements[MOVEMENT_RAMP_PROFILE] = feedContext;
      activeMovements[MOVEMENT_RAMP_ZIG_ZAG] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedPlunge")) {
    if (movements & (1 << MOVEMENT_PLUNGE)) {
      var feedContext = new FeedContext(id, localize("Plunge"), feedPerRev ? getParameter("operation:tool_feedPlungeRel") : getParameter("operation:tool_feedPlunge"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_PLUNGE] = feedContext;
    }
    ++id;
  }
  if (true) { // high feed
    if (movements & (1 << MOVEMENT_HIGH_FEED)) {
      var feedContext = new FeedContext(id, localize("High Feed"), this.highFeedrate);
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_HIGH_FEED] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedTransition")) {
    if (movements & (1 << MOVEMENT_LINK_TRANSITION)) {
      var feedContext = new FeedContext(id, localize("Transition"), getParameter("operation:tool_feedTransition"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
    }
    ++id;
  }

  for (var i = 0; i < activeFeeds.length; ++i) {
    var feedContext = activeFeeds[i];
    writeBlock("(P" + (firstFeedParameter + feedContext.id) + "=" + feedFormat.format(feedContext.feed) + ")", formatComment(feedContext.description));
  }
}

function getSpindle() {
  if (getNumberOfSections() == 0) {
    return SPINDLE_PRIMARY;
  }
  if (getCurrentSectionId() < 0) {
    return getSection(getNumberOfSections() - 1).spindle == 0;
  }
  if (currentSection.getType() == TYPE_TURNING) {
    return currentSection.spindle;
  } else {
    if (isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1))) {
      return SPINDLE_PRIMARY;
    } else if (isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, -1))) {
      if (!gotSecondarySpindle) {
        error(localize("Secondary spindle is not available."));
      }
      return SPINDLE_SECONDARY;
    } else {
      return SPINDLE_PRIMARY;
    }
  }
}

function handleSubSpindleOperation() {
  // Output M-codes and pauses for spindle grab and bar-pull
  if (isSubSpindleGrab || isSubSpindleBarPull) {
    var opComment = isSubSpindleGrab ? "Sub-Spindle Grab" : "Bar-Pull";
    
    subSpindleOperationActive = true;
    writeComment(opComment + " Operation");
    
    var openMainChuckCode = getProperty("subSpindleGrabOpenMainChuckCode");
    
    // Read pause times from operation parameters (Fusion Spindle Grab/Bar Pull cycles)
    var pauseBeforeOpen = 50;  // default centiseconds
    var pauseAfterOpen = 30;   // default centiseconds
    
    // Try to read from operation parameters
    try {
      if (hasParameter("operation:spindleOpenDelay")) {
        var delay = getParameter("operation:spindleOpenDelay");
        pauseBeforeOpen = Math.round(delay * 100); // convert seconds to centiseconds
      }
    } catch (e) {}
    
    try {
      if (hasParameter("operation:dwellSpindleOpen")) {
        var delay = getParameter("operation:dwellSpindleOpen");
        pauseAfterOpen = Math.round(delay * 100);
      }
    } catch (e) {}
    
    // Pause then open main spindle chuck
    if (openMainChuckCode > 0 && pauseBeforeOpen > 0) {
      writeBlock(gFormat.format(4), "K" + kFormat.format(pauseBeforeOpen), mFormat.format(openMainChuckCode));
    } else if (openMainChuckCode > 0) {
      writeBlock(mFormat.format(openMainChuckCode));
    }
    
    // Pause after opening
    if (pauseAfterOpen > 0) {
      writeBlock(gFormat.format(4), "K" + kFormat.format(pauseAfterOpen));
    }
  }
}

function handleSubSpindleOperationEnd() {
  // Close sub-spindle chuck after bar-pull or grab completion
  if (subSpindleOperationActive && (isSubSpindleGrab || isSubSpindleBarPull)) {
    var closeSubChuckCode = getProperty("subSpindleGrabCloseSubChuckCode");
    
    // Read pause times from operation parameters
    var pauseBeforeClose = 50; // default centiseconds
    var pauseAfterClose = 50;  // default centiseconds
    
    try {
      if (hasParameter("operation:spindleCloseDelay")) {
        var delay = getParameter("operation:spindleCloseDelay");
        pauseBeforeClose = Math.round(delay * 100);
      }
    } catch (e) {}
    
    try {
      if (hasParameter("operation:dwellSpindleClose")) {
        var delay = getParameter("operation:dwellSpindleClose");
        pauseAfterClose = Math.round(delay * 100);
      }
    } catch (e) {}
    
    // Pause then close sub spindle chuck
    if (closeSubChuckCode > 0 && pauseBeforeClose > 0) {
      writeBlock(gFormat.format(4), "K" + kFormat.format(pauseBeforeClose), mFormat.format(closeSubChuckCode));
    } else if (closeSubChuckCode > 0) {
      writeBlock(mFormat.format(closeSubChuckCode));
    }
    
    // Final pause after closing
    if (pauseAfterClose > 0) {
      writeBlock(gFormat.format(4), "K" + kFormat.format(pauseAfterClose));
    }
    
    subSpindleOperationActive = false;
  }
}

// DEVELOPER NOTE: Bar-pull cycle handler
// This function outputs the complete bar-pull sequence based on Fusion's cycle types.
// Called from onCycle() when cycleType matches bar-pull operation.
//
// Cycle flow:
//   1. "secondary-spindle-grab": 
//      - Sets barPullSequenceActive flag to suppress spindle starts
//      - Outputs T99 tool call (or user-configured tool number)
//      - Stops spindle if cycle.stopSpindle=1
//      - Positions X0, moves to feedPosition, then chuckPosition
//
//   2. "secondary-spindle-pull":
//      - Stops spindle if cycle.stopSpindle=1  
//      - Outputs M11 (unclamp main) with dwell
//      - Pulls stock to calculated pullPosition
//      - Outputs M10 (clamp sub) with dwell
//      - Retracts Z to safe position
//      - Flag remains TRUE until onClose() to prevent spindle restarts
function handleBarPullCycle(cycleTypeValue) {
  switch (cycleTypeValue) {
  case "secondary-spindle-grab":
    // Position bar puller tool and move to chuck grip position
    barPullSequenceActive = true;  // Start tracking sequence - prevents spindle starts until onClose()
    
    // Output formatted section header for bar-pull operation
    var barPullerTool = getProperty("subSpindleGrabBarPullTool");
    writeln(";(-------------------------------------------------)");
    writeln(";(T=" + toolFormat.format(barPullerTool) + " Bar Puller)");
    if (hasParameter("operation-comment")) {
      writeln(";(Operation: " + getParameter("operation-comment") + ")");
    }
    writeln(";(-------------------------------------------------)");
    
    // Check if spindle should be stopped from cycle parameter
    var stopSpindle = false;
    if (cycle.stopSpindle != undefined) {
      stopSpindle = (cycle.stopSpindle != 0);
    }
    
    onCommand(COMMAND_COOLANT_OFF);
    writeRetract(Z);
    
    // Output T99 D99 bar puller tool
    writeBlock("T" + toolFormat.format(barPullerTool), 
      "D" + toolFormat.format(barPullerTool),
      formatComment("TOOL" + barPullerTool + " BARPULLER"));
    
    // Stop spindle only if cycle requests it
    if (stopSpindle) {
      onCommand(COMMAND_STOP_SPINDLE);
    }
    
    // Position X to 0
    gMotionModal.reset();
    writeBlock(gMotionModal.format(0), "X0");
    
    // Move to feed position (ready to pull)
    if (cycle.feedPosition != undefined) {
      writeBlock(gMotionModal.format(0), "Z" + zFormat.format(cycle.feedPosition));
    }
    
    // Move to chuck position at feed rate
    if (cycle.chuckPosition != undefined && cycle.feedrate != undefined) {
      var feedValue = getFeed(cycle.feedrate);
      writeBlock(gMotionModal.format(1), "Z" + zFormat.format(cycle.chuckPosition), feedValue);
    }
    break;
    
  case "secondary-spindle-return":
    // Legacy cycle type for older Fusion 360 versions
    // Modern Fusion uses "secondary-spindle-pull" instead
    
    var openMainChuckCode = getProperty("subSpindleGrabOpenMainChuckCode");
    var closeSubChuckCode = getProperty("subSpindleGrabCloseSubChuckCode");
    
    // Output dwell time (if available, convert to centiseconds)
    var dwellTime = 50;  // default centiseconds
    if (cycle.dwell != undefined && cycle.dwell > 0) {
      dwellTime = Math.round(cycle.dwell * 100);
    }
    
    // Unclamp main chuck and dwell
    if (openMainChuckCode > 0) {
      writeBlock(mFormat.format(openMainChuckCode), formatComment("UNCLAMP MAIN CHUCK"));
    }
    if (dwellTime > 0) {
      writeBlock(gFormat.format(4), "K" + kFormat.format(dwellTime));
    }
    
    // Bar pull motion (Z moves to feed position)
    gMotionModal.reset();
    if (cycle.feedPosition != undefined && cycle.feedrate != undefined) {
      var feedValue = getFeed(cycle.feedrate);
      writeBlock(gMotionModal.format(1), "Z" + zFormat.format(cycle.feedPosition), feedValue, formatComment("BAR PULL"));
    }
    
    // Clamp sub chuck and dwell
    if (closeSubChuckCode > 0) {
      writeBlock(mFormat.format(closeSubChuckCode), formatComment("CLAMP SUB CHUCK"));
    }
    if (dwellTime > 0) {
      writeBlock(gFormat.format(4), "K" + kFormat.format(dwellTime));
    }
    
    // If feedPosition is negative, return to Z0
    if (cycle.feedPosition != undefined && cycle.feedPosition < 0) {
      writeBlock(gMotionModal.format(1), "Z0", getFeed(cycle.feedrate));
    }
    
    // Retract Z
    writeRetract(Z);
    break;
    
  case "secondary-spindle-pull":
    // Execute bar pull: unclamp main chuck, pull stock, clamp sub chuck
    
    // Check if spindle should be stopped from cycle parameter
    var stopSpindlePull = false;
    if (cycle.stopSpindle != undefined) {
      stopSpindlePull = (cycle.stopSpindle != 0);
    }
    
    // Stop spindle only if cycle requests it
    if (stopSpindlePull) {
      onCommand(COMMAND_STOP_SPINDLE);
    }
    
    var openMainChuckCode = getProperty("subSpindleGrabOpenMainChuckCode");
    var closeSubChuckCode = getProperty("subSpindleGrabCloseSubChuckCode");
    
    // Output dwell time (if available, convert to centiseconds)
    var dwellTime = 50;  // default centiseconds
    if (cycle.dwell != undefined && cycle.dwell > 0) {
      dwellTime = Math.round(cycle.dwell * 100);
    }
    
    // Unclamp main chuck
    if (openMainChuckCode > 0) {
      writeBlock(mFormat.format(openMainChuckCode), formatComment("UNCLAMP MAIN CHUCK"));
    }
    
    // Dwell after unclamping
    if (dwellTime > 0) {
      writeBlock(gFormat.format(4), "K" + kFormat.format(dwellTime));
    }
    
    // Bar pull motion - determine pull position from cycle properties
    var pullPosition = 0;
    if (cycle.pullPosition != undefined) {
      // pullPosition is the final Z position after pulling
      pullPosition = cycle.pullPosition;
    } else if (cycle.pullPositionWorkCS != undefined && Array.isArray(cycle.pullPositionWorkCS)) {
      // pullPositionWorkCS is [X, Y, Z] - use Z value
      pullPosition = cycle.pullPositionWorkCS[2];
    } else if (cycle.pullingDistance != undefined && cycle.chuckPosition != undefined) {
      // Calculate from chuck position + pulling distance
      pullPosition = cycle.chuckPosition + cycle.pullingDistance;
    }
    
    // Output bar pull motion
    gMotionModal.reset();
    if (cycle.feedrate != undefined) {
      var feedValue = getFeed(cycle.feedrate);
      writeBlock(gMotionModal.format(1), "Z" + zFormat.format(pullPosition), feedValue, formatComment("BAR PULL"));
    }
    
    // Clamp sub chuck
    if (closeSubChuckCode > 0) {
      writeBlock(mFormat.format(closeSubChuckCode), formatComment("CLAMP SUB CHUCK"));
    }
    
    // Dwell after clamping
    if (dwellTime > 0) {
      writeBlock(gFormat.format(4), "K" + kFormat.format(dwellTime));
    }
    
    // Retract Z
    writeRetract(Z);
    break;
  }
}

function ToolingData(_tool) {
  switch (_tool.turret) {
  // Positional Turret
  case 0:
    this.tooling = TURRET;
    this.toolPost = REAR;
    break;
  // QCTP X-
  case 101:
    this.tooling = QCTP;
    this.toolPost = FRONT;
    break;
  // QCTP X+
  case 102:
    this.tooling = QCTP;
    this.toolPost = REAR;
    break;
  // Gang Tooling X-
  case 103:
    this.tooling = GANG;
    this.toolPost = FRONT;
    break;
  // Gang Tooling X+
  case 104:
    this.tooling = GANG;
    this.toolPost = REAR;
    break;
  default:
    error(localize("Turret number must be 0 (main turret), 101 (QCTP X-), 102 (QCTP X+, 103 (gang tooling X-), or 104 (gang tooling X+)."));
    break;
  }
  this.number = _tool.number;
  this.comment = _tool.comment;
  this.toolLength = _tool.bodyLength;
  // HSMWorks returns 0 in tool.bodyLength
  if ((tool.bodyLength == 0) && hasParameter("operation:tool_bodyLength")) {
    this.toolLength = getParameter("operation:tool_bodyLength");
  }
}

function setDirectionX() {
  xFormat.setScale(toolingData.toolPost == FRONT ? Math.abs(xFormat.getScale()) * -1 : Math.abs(xFormat.getScale()));
  iFormat.setScale(toolingData.toolPost == FRONT ? Math.abs(iFormat.getScale()) * -1 : Math.abs(iFormat.getScale()));
  xOutput = createVariable({onchange:function() {retracted[X] = false;}, prefix:"X"}, xFormat);
  iOutput = createReferenceVariable({prefix:"I"}, iFormat);
}

function onSection() {
  threadingCycleDone = false;
  suppressThreadCyclePointMotion = false;
  isSubSpindleGrab = false;
  isSubSpindleBarPull = false;
  subSpindleOperationActive = false;

  if (currentSection.getType() != TYPE_TURNING) {
    if (!hasParameter("operation-strategy") || (getParameter("operation-strategy") != "drill")) {
      if (currentSection.getType() == TYPE_MILLING) {
        error(localize("Milling toolpath is not supported."));
      } else {
        error(localize("Non-turning toolpath is not supported."));
      }
      return;
    }
  }

  var forceSectionRestart = optionalSection && !currentSection.isOptional();
  optionalSection = currentSection.isOptional();

  var turning = (currentSection.getType() == TYPE_TURNING);

  var insertToolCall = forceSectionRestart || isFirstSection() ||
    currentSection.getForceToolChange && currentSection.getForceToolChange() ||
    (tool.number != getPreviousSection().getTool().number) ||
    (tool.compensationOffset != getPreviousSection().getTool().compensationOffset) ||
    (tool.diameterOffset != getPreviousSection().getTool().diameterOffset) ||
    (tool.lengthOffset != getPreviousSection().getTool().lengthOffset);

  var newSpindle = isFirstSection() ||
    (getPreviousSection().spindle != currentSection.spindle);
  var newWorkOffset = isFirstSection() || forceSectionRestart ||
    (getPreviousSection().workOffset != currentSection.workOffset); // work offset changes

  // determine which tooling holder is used
  if (!isFirstSection()) {
    previousToolingData = toolingData;
  }
  toolingData = new ToolingData(tool);
  toolingData.operationComment = "";
  if (hasParameter("operation-comment")) {
    toolingData.operationComment = getParameter("operation-comment");
  }
  toolingData.toolChange = insertToolCall;
  if (isFirstSection()) {
    previousToolingData = toolingData;
  }

  tapping = hasParameter("operation:cycleType") &&
    ((getParameter("operation:cycleType") == "tapping") ||
     (getParameter("operation:cycleType") == "right-tapping") ||
     (getParameter("operation:cycleType") == "left-tapping") ||
     (getParameter("operation:cycleType") == "tapping-with-chip-breaking"));

  // Reset sub-spindle state flags
  // Note: Bar-pull cycle detection happens in onCycle(), not here.
  // The operation:cycleType parameter is not available during onSection() for bar-pull operations.
  isSubSpindleGrab = false;
  isSubSpindleBarPull = false;
  shouldStopSpindleForBarPull = false;

  setDirectionX();

  if (insertToolCall || newSpindle || newWorkOffset) {
    // retract to safe plane
    if (!isFirstSection() && insertToolCall) {
      onCommand(COMMAND_COOLANT_OFF);
    }
    writeRetract();
    forceXYZ();
  }

  // Output formatted section header for tool changes and operations
  if (insertToolCall) {
    writeln(";(-------------------------------------------------)");
    // Special handling for bar-pull operations (T99)
    if (tool.number == getProperty("subSpindleGrabBarPullTool")) {
      writeln(";(T=" + toolFormat.format(tool.number) + " " + (tool.description ? tool.description : "Bar Puller") + ")");
    } else {
      var toolLine = tool.number + (tool.description ? (" " + tool.description) : "");
      writeln(";(T=" + toolLine + ")");
    }
  } else {
    writeln(";(-------------------------------------------------)");
  }

  if (hasParameter("operation-comment")) {
    var comment = getParameter("operation-comment");
    writeln(";(Operation: " + comment + ")");
    writeln(";(-------------------------------------------------)");
  }

  if (getProperty("showNotes") && hasParameter("notes")) {
    var notes = getParameter("notes");
    if (notes) {
      var lines = String(notes).split("\n");
      var r1 = new RegExp("^[\\s]+", "g");
      var r2 = new RegExp("[\\s]+$", "g");
      for (line in lines) {
        var comment = lines[line].replace(r1, "").replace(r2, "");
        if (comment) {
          writeComment(comment);
        }
      }
    }
  }

  if (insertToolCall) {
    forceModals();
    // onCommand(COMMAND_COOLANT_OFF);

    if (!isFirstSection() && getProperty("optionalStop")) {
      onCommand(COMMAND_OPTIONAL_STOP);
    }

    if (tool.number > 99) {
      warning(localize("Tool number exceeds maximum value."));
    }

    if ((toolingData.tooling == QCTP) || tool.getManualToolChange()) {
      var comment = formatComment(localize("CHANGE TO T") + tool.number + " " + localize("ON") + " " +
        localize((toolingData.toolPost == REAR) ? "REAR TOOL POST" : "FRONT TOOL POST"));
      writeBlock(mFormat.format(0), comment);
    }

    var compensationOffset = tool.isTurningTool() ? tool.compensationOffset : tool.lengthOffset;
    if (compensationOffset > 99) {
      error(localize("Compensation offset is out of range."));
      return;
    }
    writeToolBlock("T" + toolFormat.format(tool.number), dFormat.format(compensationOffset));
    if (tool.comment) {
      writeComment(tool.comment);
    }
    
    // Handle sub-spindle grab and bar-pull operations
    handleSubSpindleOperation();
  }

  // Select spindle
  if (gotSecondarySpindle) {
    var spindle = getSpindle();
    if (spindle == SPINDLE_PRIMARY) {
      if (previousSpindle == SPINDLE_SECONDARY) {
        writeBlock(gFormat.format(29), "Z");
      }
      writeBlock(gSpindleSelectModal.format(29));
    } else {
      if (previousSpindle == SPINDLE_PRIMARY) {
        writeBlock(gFormat.format(28), "ZW");
      }
      writeBlock(gSpindleSelectModal.format(28));
    }
    previousSpindle = spindle;
  }

  // wcs
  if (insertToolCall) { // force work offset when changing tool
    currentWorkOffset = undefined;
  }

  if (currentSection.workOffset != currentWorkOffset) {
    writeBlock(currentSection.wcs);
    currentWorkOffset = currentSection.workOffset;
  }

  // set coolant after we have positioned at Z
  setCoolant(tool.coolant);

  forceAny();
  gMotionModal.reset();

  // Output modal commands here
  writeBlock(gAbsIncModal.format(90), getCode(currentSection.feedMode == FEED_PER_REVOLUTION ? "FEED_MODE_UNIT_REV" : "FEED_MODE_UNIT_MIN"), gPlaneModal.format(18));

  if (gotTailStock) {
    writeBlock(getCode(currentSection.tailstock ? "TAILSTOCK_ON" : "TAILSTOCK_OFF"));
  }
  // writeBlock(mFormat.format(clampPrimaryChuck ? x : x));
  // writeBlock(mFormat.format(clampSecondaryChuck ? x : x));

  var initialPosition = getFramePosition(currentSection.getInitialPosition());
  var spindleChanged = forceSpindleSpeed || newSpindle || isSpindleSpeedDifferent();
  if (insertToolCall || spindleChanged) {
    forceSpindleSpeed = false;
    // Suppress spindle start during bar-pull sequence (between grab and pull cycles)
    if (!barPullSequenceActive) {
      startSpindle(false, true, initialPosition);
    }
  }

  setRotation(currentSection.workPlane);

  if (insertToolCall || tool.getSpindleMode() == SPINDLE_CONSTANT_SURFACE_SPEED) {
    gMotionModal.reset();

    if (getProperty("approachStyle") == "ZX") {
      writeBlock(gAbsIncModal.format(90), gMotionModal.format(0), zOutput.format(initialPosition.z));
      writeBlock(gAbsIncModal.format(90), gMotionModal.format(0), xOutput.format(initialPosition.x), yOutput.format(initialPosition.y));
    } else {
      writeBlock(gAbsIncModal.format(90), gMotionModal.format(0), xOutput.format(initialPosition.x), yOutput.format(initialPosition.y), zOutput.format(initialPosition.z));
    }
    gMotionModal.reset();
  }

  // enable SFM spindle speed
  if (tool.getSpindleMode() == SPINDLE_CONSTANT_SURFACE_SPEED) {
    // Suppress SFM spindle start during bar-pull sequence
    if (!barPullSequenceActive) {
      startSpindle(false, false);
    }
  }

  if (currentSection.partCatcher) {
    engagePartCatcher(true);
  }

  if (getProperty("useParametricFeed") &&
      hasParameter("operation-strategy") &&
      (getParameter("operation-strategy") != "drill") && // legacy
      !(currentSection.hasAnyCycle && currentSection.hasAnyCycle())) {
    if (!insertToolCall &&
        activeMovements &&
        (getCurrentSectionId() > 0) &&
        ((getPreviousSection().getPatternId() == currentSection.getPatternId()) && (currentSection.getPatternId() != 0))) {
      // use the current feeds
    } else {
      initializeActiveFeeds();
    }
  } else {
    activeMovements = undefined;
  }
}

function onDwell(seconds) {
  if (seconds > 999999.99) {
    warning(localize("Dwelling time is out of range."));
  }
  centiseconds = clamp(1, seconds * 100, 99999999);
  writeBlock(gFormat.format(4), "K" + kFormat.format(centiseconds));
}

var pendingRadiusCompensation = -1;

function onRadiusCompensation() {
  pendingRadiusCompensation = radiusCompensation;
}

var resetFeed = false;

function onRapid(_x, _y, _z) {
  if (firstPosition) {
    initialCyclePosition = new Vector(_x, _y, _z);
    firstPosition = false;
    return;
  }
  if (suppressThreadCyclePointMotion) {
    return;
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      pendingRadiusCompensation = -1;
      switch (radiusCompensation) {
      case RADIUS_COMPENSATION_LEFT:
        writeBlock(gMotionModal.format(0), gFormat.format(41), x, y, z);
        break;
      case RADIUS_COMPENSATION_RIGHT:
        writeBlock(gMotionModal.format(0), gFormat.format(42), x, y, z);
        break;
      default:
        writeBlock(gMotionModal.format(0), gFormat.format(40), x, y, z);
      }
    } else {
      writeBlock(gMotionModal.format(0), x, y, z);
    }
    forceFeed();
  }
}

function onLinear(_x, _y, _z, feed) {
  if (firstPosition) {
    initialCyclePosition = new Vector(_x, _y, _z);
    firstPosition = false;
    return;
  }
  if (suppressThreadCyclePointMotion) {
    return;
  }
  if (isSpeedFeedSynchronizationActive()) {
    resetFeed = true;
    var threadPitch = getParameter("operation:threadPitch");
    var threadsPerInch = 1.0 / threadPitch; // per mm for metric
    writeBlock(gMotionModal.format(33), xOutput.format(_x), yOutput.format(_y), zOutput.format(_z), pitchOutput.format(1 / threadsPerInch));
    return;
  }
  if (resetFeed) {
    resetFeed = false;
    forceFeed();
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var f = getFeed(feed);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      pendingRadiusCompensation = -1;
      writeBlock(gPlaneModal.format(18));
      switch (radiusCompensation) {
      case RADIUS_COMPENSATION_LEFT:
        writeBlock(gMotionModal.format(1), gFormat.format(41), x, y, z, f);
        break;
      case RADIUS_COMPENSATION_RIGHT:
        writeBlock(gMotionModal.format(1), gFormat.format(42), x, y, z, f);
        break;
      default:
        writeBlock(gMotionModal.format(1), gFormat.format(40), x, y, z, f);
      }
    } else {
      writeBlock(gMotionModal.format(1), x, y, z, f);
    }
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gMotionModal.format(1), f);
    }
  }
}

function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
  if (isSpeedFeedSynchronizationActive()) {
    error(localize("Speed-feed synchronization is not supported for circular moves."));
    return;
  }

  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for a circular move."));
    return;
  }

  var start = getCurrentPosition();
  var directionCode = (toolingData.toolPost == REAR) ? (clockwise ? 2 : 3) : (clockwise ? 3 : 2);

  if (isFullCircle()) {
    if (getProperty("useRadius") || isHelical()) { // radius mode does not support full arcs
      linearize(tolerance);
      return;
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(17), gMotionModal.format(directionCode), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(18), gMotionModal.format(directionCode), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(19), gMotionModal.format(directionCode), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else if (!getProperty("useRadius")) {
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(17), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(18), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(19), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else { // use radius mode
    var r = getCircularRadius();
    if (toDeg(getCircularSweep()) > (180 + 1e-9)) {
      r = -r; // allow up to <360 deg arcs
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gPlaneModal.format(17), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gPlaneModal.format(18), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gPlaneModal.format(19), gMotionModal.format(directionCode), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  }
}

function onCycle() {
  suppressThreadCyclePointMotion = false;

  // DEVELOPER NOTE: Bar-pull cycle detection
  // Fusion 360 uses these cycleType values for secondary spindle operations:
  //   - "secondary-spindle-grab": Position and grip stock in sub chuck
  //   - "secondary-spindle-pull": Unclamp, pull stock, clamp
  //   - "secondary-spindle-return": Legacy cycle (older Fusion versions)
  // These must be detected here in onCycle() because operation:cycleType parameter
  // is not available during onSection() for bar-pull operations.
  if (cycleType == "secondary-spindle-grab" || 
      cycleType == "secondary-spindle-pull" ||
      cycleType == "secondary-spindle-return") {
    handleBarPullCycle(cycleType);
    return;
  }
}

var saveShowSequenceNumbers;
var pathBlockNumber = {start:0, end:0};
var initialCyclePosition = 0;
var threadingCycleDone = false;
var suppressThreadCyclePointMotion = false;

function onCyclePath() {
  saveShowSequenceNumbers = getProperty("showSequenceNumbers");

  // buffer all paths and stop feeds being output
  feedOutput.disable();
  setProperty("showSequenceNumbers", "false");
  firstPosition = true;
  redirectToBuffer();
  gMotionModal.reset();
  if ((hasParameter("operation:grooving") && getParameter("operation:grooving").toUpperCase() != "OFF")) {
    forceXYZ();
  }
}

function onCyclePathEnd() {
  setProperty("showSequenceNumbers", saveShowSequenceNumbers); // reset property to initial state
  feedOutput.enable();
  var cyclePath = String(getRedirectionBuffer()).split(EOL); // get cycle path from buffer
  closeRedirection();
  for (line in cyclePath) { // remove empty elements
    if (cyclePath[line] == "") {
      cyclePath.splice(line);
    }
  }

  var verticalPasses;
  if (cycle.profileRoughingCycle == 0) {
    verticalPasses = false;
  } else if (cycle.profileRoughingCycle == 1) {
    verticalPasses = true;
  } else {
    error(localize("Unsupported passes type."));
    return;
  }
  // output cycle data
  switch (cycleType) {
  case "turning-canned-rough":
    writeBlock(
      gFormat.format(verticalPasses ? 69 : 68),
      "P0=K" + xFormat.format(initialCyclePosition.x),
      "P1=K" + zFormat.format(initialCyclePosition.z),
      "P5=K" + spatialFormat.format(cycle.depthOfCut),
      "P7=K" + spatialFormat.format(cycle.xStockToLeave),
      "P8=K" + spatialFormat.format(cycle.zStockToLeave),
      "P9=K" + feedFormat.format(cycle.cutfeedrate),
      "P10=K1",
      "P13=K" + (getStartEndSequenceNumber(cyclePath, true)),
      "P14=K" + (getStartEndSequenceNumber(cyclePath, false))
    );
    break;
  default:
    error(localize("Unsupported turning canned cycle."));
  }

  for (var i = 0; i < cyclePath.length; ++i) {
    if (i == 0 || i == (cyclePath.length - 1)) { // write sequence number on first and last line of the cycle path
      setProperty("showSequenceNumbers", "true");
      if ((i == 0 && pathBlockNumber.start != sequenceNumber) || (i == (cyclePath.length - 1) && pathBlockNumber.end != sequenceNumber)) {
        error(localize("Mismatch of start/end block number in turning canned cycle."));
        return;
      }
    }
    writeBlock(cyclePath[i]); // output cycle path
    setProperty("showSequenceNumbers", saveShowSequenceNumbers); // reset property to initial state
  }
}

function getStartEndSequenceNumber(cyclePath, start) {
  if (start) {
    pathBlockNumber.start = sequenceNumber + conditional(saveShowSequenceNumbers == "true", getProperty("sequenceNumberIncrement"));
    return pathBlockNumber.start;
  } else {
    pathBlockNumber.end = sequenceNumber + getProperty("sequenceNumberIncrement") + conditional(saveShowSequenceNumbers == "true", (cyclePath.length - 1) * getProperty("sequenceNumberIncrement"));
    return pathBlockNumber.end;
  }
}

function getCommonCycle(x, y, z, depth) {
  forceXYZ(); // force xyz on first drill hole of any cycle
  return [xOutput.format(x), yOutput.format(y),
    zOutput.format(z + depth), // top of hole
    "I" + zFormat.format(depth)];
}

function onCyclePoint(x, y, z) {
  if (!getProperty("useCycles")) {
    if (tapping) {
      error(localize("Tapping cycles cannot be expanded."));
      return;
    }
    expandCyclePoint(x, y, z);
    return;
  }

  // Thread turning cycle is supported using G86.

  var dwell = (cycle.dwell == 0) ? 0 : clamp(1, cycle.dwell * 100, 99999); // in centiseconds
  var F = (gFeedModeModal.getCurrent() == 99) ? cycle.feedrate / spindleSpeed : cycle.feedrate;

  // Fusion can emit different cycleType names for internal/external turning threads.
  // Normalize all turning thread variants to the same G86 handler.
  var normalizedCycleType = cycleType;
  if ((currentSection.getType() == TYPE_TURNING) && (typeof cycleType == "string")) {
    var cycleTypeLower = cycleType.toLowerCase();
    if ((cycleTypeLower.indexOf("thread") >= 0) && (cycleTypeLower.indexOf("turn") >= 0)) {
      normalizedCycleType = "thread-turning";
    }
  }
  if (getProperty("debugThreading")) {
    var opCycleType = "";
    try { opCycleType = getParameter("operation:cycleType"); } catch (e) {}
    if (typeof opCycleType == "undefined" || opCycleType === null) {
      opCycleType = "";
    }
    writeComment("THREADDBG CY=" + cycleType + " OP=" + opCycleType + " NORM=" + normalizedCycleType + " TYP=" + currentSection.getType());
  }

  if (true) {
    switch (normalizedCycleType) {
    case "drilling":
    case "counter-boring":
      writeBlock(feedOutput.format(F));
      writeBlock(
        gCycleModal.format(83),
        getCommonCycle(x, y, z, cycle.depth),
        "B" + zFormat.format(cycle.depth),
        "D" + zFormat.format(cycle.retract - cycle.stock), // delta from top of stock to retract
        conditional(dwell > 0, "K" + kFormat.format(dwell))
      );
      break;
    case "chip-breaking":
    case "deep-drilling":
      var stepRetract = (cycleType == "chip-breaking") ? cycle.chipBreakDistance : 0;
      var step = (cycle.incrementalDepth > 0) ? cycle.incrementalDepth : cycle.depth;
      writeBlock(feedOutput.format(F));
      writeBlock(
        gCycleModal.format(83),
        getCommonCycle(x, y, z, cycle.depth),
        "B" + zFormat.format(step),
        "D" + zFormat.format(cycle.retract - cycle.stock), // delta from top of stock to retract
        conditional(dwell > 0, "K" + kFormat.format(dwell)),
        conditional(stepRetract > 0, "H" + zFormat.format(stepRetract)),
        conditional(cycle.minimumIncrementalDepth > 0, "L" + zFormat.format(cycle.minimumIncrementalDepth)),
        conditional(cycle.incrementalDepthReduction > 0, "R" + zFormat.format(cycle.incrementalDepthReduction))
      );
      break;
    case "right-tapping":
    case "left-tapping":
    case "tapping":
      F = tool.getTappingFeedrate();
      writeBlock(feedOutput.format(F));
      writeBlock(
        gCycleModal.format(83),
        getCommonCycle(x, y, z, cycle.depth),
        "B" + zFormat.format(0), // B0 is tapping mode
        "D" + zFormat.format(cycle.retract - cycle.stock), // delta from top of stock to retract
        conditional(dwell > 0, "K" + kFormat.format(dwell))
      );
      break;
    case "thread-turning":
      if (threadingCycleDone) {
        cycleExpanded = true;
        suppressThreadCyclePointMotion = true;
        return;
      }
      if (!threadingCycleDone) {
        if (getProperty("debugThreading")) {
          writeComment("THREADDBG ENTER G86");
        }
        function getCycleNumeric(cycleObj, names) {
          for (var idx = 0; idx < names.length; idx++) {
            var name = names[idx];
            var value = cycleObj[name];
            if (isFinite(value)) {
              return Number(value);
            }
          }
          for (var key in cycleObj) {
            for (var n = 0; n < names.length; n++) {
              if (key.toLowerCase() == names[n].toLowerCase()) {
                var matchedValue = cycleObj[key];
                if (isFinite(matchedValue)) {
                  return Number(matchedValue);
                }
              }
            }
          }
          return undefined;
        }

        // Read Fusion cycle fields from the actual cycle object
        var threadPitch = getCycleNumeric(cycle, ["PITCH"]);
        if (!isFinite(threadPitch)) {
          try { threadPitch = getParameter("operation:threadPitch"); } catch (e) {}
        }
        var passDepth = getCycleNumeric(cycle, ["FIRSTPASSDEPTH", "firstPassDepth", "incrementalDepth", "INCREMENTALDEPTH"]);
        if (!isFinite(passDepth) || passDepth <= 0) {
          try { passDepth = getParameter("operation:firstPassDepth"); } catch (e) {}
        }
        if (!isFinite(passDepth) || passDepth <= 0) {
          try { passDepth = getParameter("operation:threadFirstPassDepth"); } catch (e) {}
        }
        if (!isFinite(passDepth) || passDepth <= 0) {
          try { passDepth = getParameter("operation:incrementalDepth"); } catch (e) {}
        }
        if (!isFinite(passDepth) || passDepth <= 0) {
          passDepth = 0.005;
        }
        passDepth = Math.abs(passDepth);
        var incrementalZ = getCycleNumeric(cycle, ["INCREMENTALZ", "incrementalZ"]);
        var threadLength = Math.abs(isFinite(incrementalZ) ? incrementalZ : 0);
        var threadAngle = getCycleNumeric(cycle, ["INFEEDANGLE", "infeedAngle", "THREADANGLE", "threadAngle"]);
        if (!isFinite(threadAngle)) {
          try { threadAngle = getParameter("operation:infeedAngle"); } catch (e) {}
        }
        if (!isFinite(threadAngle)) {
          try { threadAngle = getParameter("operation:threadInfeedAngle"); } catch (e) {}
        }
        if (!isFinite(threadAngle)) {
          try { threadAngle = getParameter("operation:threadAngle"); } catch (e) {}
        }
        if (!isFinite(threadAngle)) {
          threadAngle = 30;
        }
        function getParamBoolean(names) {
          for (var b = 0; b < names.length; b++) {
            var raw;
            try { raw = getParameter(names[b]); } catch (e) {}
            if (typeof raw == "undefined" || raw === null) {
              continue;
            }
            if (typeof raw == "boolean") {
              return raw;
            }
            if (typeof raw == "number") {
              return raw != 0;
            }
            var s = String(raw).toLowerCase();
            if (s == "true" || s == "yes" || s == "on" || s == "1") {
              return true;
            }
            if (s == "false" || s == "no" || s == "off" || s == "0") {
              return false;
            }
          }
          return undefined;
        }

        var cycleThreadStarts = getCycleNumeric(cycle, ["V", "THREADSTARTS", "NUMBEROFSTARTS", "numberOfStarts"]);
        var numberOfThreadStarts = cycleThreadStarts;
        if (!isFinite(numberOfThreadStarts)) {
          try { numberOfThreadStarts = getParameter("operation:numberOfStarts"); } catch (e) {}
        }
        if (!isFinite(numberOfThreadStarts)) {
          try { numberOfThreadStarts = getParameter("operation:threadStarts"); } catch (e) {}
        }
        if (!isFinite(numberOfThreadStarts)) {
          try { numberOfThreadStarts = getParameter("operation:numberOfThreads"); } catch (e) {}
        }
        if (!isFinite(numberOfThreadStarts)) {
          numberOfThreadStarts = 1;
        }
        numberOfThreadStarts = Math.max(1, Math.floor(Math.abs(numberOfThreadStarts)));

        var multipleThreadStartsEnabled = getParamBoolean([
          "operation:doMultipleThreads",
          "operation:multipleThreads",
          "operation:multipleStarts",
          "operation:threadMultipleStarts",
          "operation:threadMultipleThreads",
          "operation:threadingMultipleThreads",
          "operation:doMultipleStarts"
        ]);
        if (typeof multipleThreadStartsEnabled == "undefined") {
          var cycleMultiStarts = getCycleNumeric(cycle, ["DOMULTIPLETHREADS", "MULTIPLETHREADS", "MULTIPLESTARTS", "multiStarts"]);
          multipleThreadStartsEnabled = isFinite(cycleMultiStarts) ? (Number(cycleMultiStarts) > 0) : false;
        }
        var finishingPass = cycle.STOCK || 0;
        var threadType = "external";
        try { threadType = getParameter("operation:threadType"); } catch (e) {}
        var safetyDistance = getCycleNumeric(cycle, ["CLEARANCE", "clearance"]);
        if (!isFinite(safetyDistance)) {
          safetyDistance = 1;
        }

        // Compute threadDepth from operation parameter (radial)
        var threadDepth = 0;
        try { threadDepth = getParameter("operation:threadDepth"); } catch (e) {}
        if (!isFinite(threadDepth)) {
          threadDepth = passDepth; // fallback: use first pass depth as total if not from operation
        }
        
        // Determine if thread is external or internal (Fusion may return full description like "ANSI UNIFIED SCREW THREADS")
        var isExternal = (threadType.indexOf("external") >= 0 || threadType.indexOf("EXTERNAL") >= 0 || threadType == "external");
        if (!isExternal && threadType.indexOf("internal") < 0 && threadType.indexOf("INTERNAL") < 0) {
          // Default to external if type is unclear (most common case)
          isExternal = true;
        }
        
        // Coordinates from Fusion cycle point
        var startX = x; // X is provided by Fusion for the cycle start (radius)
        var endZ = z; // Z provided at cycle point is thread end in this post flow
        
        // Calculate actual thread start Z from end Z and incremental length
        // INCREMENTALZ is negative on OD threading (e.g. -0.6), so start = end - incrementalZ
        var threadStartZ = isFinite(incrementalZ) ? (endZ - incrementalZ) : endZ;
        
        // Compute initial pass X and final X
        // For flat threads (no taper): X and Q are the same stock diameter
        var initialPassX = startX; // Stock diameter position
        var finalX = startX; // Final X (same as initial for flat thread)

        // D value in radius: compute from retract minus initial X, with robust unit handling
        var retractX = getCycleNumeric(cycle, ["RETRACT", "retract"]);
        var clearanceX = getCycleNumeric(cycle, ["CLEARANCE", "clearance"]);
        var dValue = undefined;
        if (isFinite(retractX) && isFinite(initialPassX)) {
          // Some Fusion fields can be diameter while this post computes in radius.
          // Evaluate both interpretations and choose the smaller radial delta.
          var deltaAssumeRadius = Math.abs(retractX - initialPassX);
          var deltaAssumeDiameter = Math.abs((retractX / 2) - initialPassX);
          dValue = Math.min(deltaAssumeRadius, deltaAssumeDiameter);
          // If explicit clearance exists and is positive, use it when close to computed delta.
          if (isFinite(clearanceX) && clearanceX > 0) {
            var clearanceRadius = Math.min(Math.abs(clearanceX), Math.abs(clearanceX / 2));
            if (!isFinite(dValue) || Math.abs(clearanceRadius - dValue) < 0.02) {
              dValue = clearanceRadius;
            }
          }
        } else if (isFinite(clearanceX) && clearanceX > 0) {
          dValue = Math.min(Math.abs(clearanceX), Math.abs(clearanceX / 2));
        } else if (isFinite(safetyDistance)) {
          dValue = Math.abs(safetyDistance);
        }

        // Thread length R from Fusion INCREMENTALZ (always positive)
        var length = Math.abs(isFinite(incrementalZ) ? incrementalZ : threadLength);

        if (getProperty("debugThreading")) {
          writeComment(
            "THREADDBG PARM PITCH=" + threadPitch +
            " DEPTH=" + threadDepth +
            " PASS=" + passDepth +
            " INCZ=" + incrementalZ +
            " LEN=" + length +
            " STARTS=" + numberOfThreadStarts +
            " MULTI=" + (multipleThreadStartsEnabled ? 1 : 0) +
            " TYPE=" + threadType +
            " EXT=" + (isExternal ? 1 : 0)
          );
        }

        // validate required numeric parameters to avoid NaN formatting
        var missingParams = [];
        if (!isFinite(threadPitch)) missingParams.push("cycle.PITCH");
        if (!isFinite(threadDepth)) missingParams.push("operation:threadDepth");
        if (!isFinite(passDepth)) missingParams.push("cycle.FIRSTPASSDEPTH");
        if (!isFinite(length)) missingParams.push("cycle.INCREMENTALZ");
        if (!isFinite(finishingPass)) missingParams.push("cycle.STOCK");
        if (missingParams.length > 0) {
          if (getProperty("debugThreading")) {
            writeComment("THREADDBG MISSING " + missingParams.join(","));
          }
          error("Missing threading parameters: " + missingParams.join(", "));
          return;
        }

        // Match thread X-related parameters to current tool post side (FRONT/REAR)
        var xSideSign = (toolingData && (toolingData.toolPost == FRONT)) ? -1 : 1;

        writeBlock(
          gCycleModal.format(86),
          xOutput.format(initialPassX), // X: initial cutting X (first pass)
          "Z" + zFormat.format(threadStartZ), // Z: thread start Z (always output, non-modal)
          "Q" + spatialFormat.format((finalX * 2) * xSideSign), // Q: final X (end of thread in X, diameter), signed for FRONT/REAR
          "R" + zFormat.format(length), // R: total thread length
          "I" + spatialFormat.format((isExternal ? threadDepth : -threadDepth) * xSideSign), // I: thread depth in radius (+external, -internal), signed for FRONT/REAR
          "B" + spatialFormat.format(passDepth), // B: per-pass depth (radius)
          "C" + spatialFormat.format(threadPitch), // C: pitch
          conditional(isFinite(threadAngle), "A" + spatialFormat.format(threadAngle)), // A: angle
          conditional(isFinite(dValue), "D" + spatialFormat.format(dValue)), // D: retractX - initialX in radius
          "L" + spatialFormat.format(finishingPass), // L: finishing pass
          "J" + spatialFormat.format(0),
          conditional(multipleThreadStartsEnabled && (numberOfThreadStarts > 1), "V" + numberOfThreadStarts)
        );
        cycleExpanded = true;
        threadingCycleDone = true;
        suppressThreadCyclePointMotion = true;
        return;
      }
      break;
    default:
      if (tapping) {
        error(localize("Tapping cycles cannot be expanded."));
        return;
      }
      expandCyclePoint(x, y, z);
      break;
    }
  }
}

function onCycleEnd() {
  // G80 is not used
  suppressThreadCyclePointMotion = false;
}

var currentCoolantMode = COOLANT_OFF;
var coolantOff = undefined;
var forceCoolant = false;

function setCoolant(coolant) {
  var coolantCodes = getCoolantCodes(coolant);
  if (Array.isArray(coolantCodes)) {
    if (singleLineCoolant) {
      writeBlock(coolantCodes.join(getWordSeparator()));
    } else {
      for (var c in coolantCodes) {
        writeBlock(coolantCodes[c]);
      }
    }
    return undefined;
  }
  return coolantCodes;
}

function getCoolantCodes(coolant) {
  var multipleCoolantBlocks = new Array(); // create a formatted array to be passed into the outputted line
  if (!coolants) {
    error(localize("Coolants have not been defined."));
  }
  if (tool.type == TOOL_PROBE) { // avoid coolant output for probing
    coolant = COOLANT_OFF;
  }
  if (coolant == currentCoolantMode && (!forceCoolant || coolant == COOLANT_OFF)) {
    return undefined; // coolant is already active
  }
  if ((coolant != COOLANT_OFF) && (currentCoolantMode != COOLANT_OFF) && (coolantOff != undefined) && !forceCoolant) {
    if (Array.isArray(coolantOff)) {
      for (var i in coolantOff) {
        multipleCoolantBlocks.push(coolantOff[i]);
      }
    } else {
      multipleCoolantBlocks.push(coolantOff);
    }
  }

  forceCoolant = false;

  var m;
  var coolantCodes = {};
  for (var c in coolants) { // find required coolant codes into the coolants array
    if (coolants[c].id == coolant) {
      coolantCodes.on = coolants[c].on;
      if (coolants[c].off != undefined) {
        coolantCodes.off = coolants[c].off;
        break;
      } else {
        for (var i in coolants) {
          if (coolants[i].id == COOLANT_OFF) {
            coolantCodes.off = coolants[i].off;
            break;
          }
        }
      }
    }
  }
  if (coolant == COOLANT_OFF) {
    m = !coolantOff ? coolantCodes.off : coolantOff; // use the default coolant off command when an 'off' value is not specified
  } else {
    coolantOff = coolantCodes.off;
    m = coolantCodes.on;
  }

  if (!m) {
    onUnsupportedCoolant(coolant);
    m = 9;
  } else {
    if (Array.isArray(m)) {
      for (var i in m) {
        multipleCoolantBlocks.push(m[i]);
      }
    } else {
      multipleCoolantBlocks.push(m);
    }
    currentCoolantMode = coolant;
    for (var i in multipleCoolantBlocks) {
      if (typeof multipleCoolantBlocks[i] == "number") {
        multipleCoolantBlocks[i] = mFormat.format(multipleCoolantBlocks[i]);
      }
    }
    return multipleCoolantBlocks; // return the single formatted coolant value
  }
  return undefined;
}

function onSpindleSpeed(spindleSpeed) {
  if (rpmFormat.areDifferent(spindleSpeed, sOutput.getCurrent())) {
    writeBlock(sOutput.format(spindleSpeed));
  }
}

function startSpindle(tappingMode, forceRPMMode, initialPosition) {
  var spindleDir;
  var _spindleSpeed;
  var spindleMode;
  var maxSpeed = "";
  gSpindleModeModal.reset();

  if ((getSpindle() == SPINDLE_SECONDARY) && !gotSecondarySpindle) {
    error(localize("Secondary spindle is not available."));
    return;
  }

  if (false /*tappingMode*/) {
    spindleDir = getCode("RIGID_TAPPING");
  } else {
    if (getSpindle() == SPINDLE_SECONDARY) {
      spindleDir = tool.clockwise ? getCode("START_SUB_SPINDLE_CW") : getCode("START_SUB_SPINDLE_CCW");
    } else {
      spindleDir = tool.clockwise ? getCode("START_MAIN_SPINDLE_CW") : getCode("START_MAIN_SPINDLE_CCW");
    }
  }

  var maximumSpindleSpeed = (tool.maximumSpindleSpeed > 0) ? Math.min(tool.maximumSpindleSpeed, getProperty("maximumSpindleSpeed")) : getProperty("maximumSpindleSpeed");
  if (tool.getSpindleMode() == SPINDLE_CONSTANT_SURFACE_SPEED) {
    _spindleSpeed = tool.surfaceSpeed * ((unit == MM) ? 1 / 1000.0 : 1 / 12.0);
    if (forceRPMMode) { // RPM mode is forced until move to initial position
      if (xFormat.getResultingValue(initialPosition.x) == 0) {
        _spindleSpeed = maximumSpindleSpeed;
      } else {
        _spindleSpeed = Math.min((_spindleSpeed * ((unit == MM) ? 1000.0 : 12.0) / (Math.PI * Math.abs(initialPosition.x * 2))), maximumSpindleSpeed);
      }
      spindleMode = getCode("CONSTANT_SURFACE_SPEED_OFF");
    } else {
      writeBlock(gFormat.format(92), sOutput.format(maximumSpindleSpeed));
      spindleMode = getCode("CONSTANT_SURFACE_SPEED_ON");
    }
  } else {
    _spindleSpeed = spindleSpeed;
    spindleMode = getCode("CONSTANT_SURFACE_SPEED_OFF");
  }
  if (getSpindle(true) == SPINDLE_SECONDARY) {
    writeBlock(
      spindleMode,
      sOutput.format(_spindleSpeed),
      spindleDir
    );
  } else {
    writeBlock(
      spindleMode,
      sOutput.format(_spindleSpeed),
      spindleDir
    );
  }
  // wait for spindle here if required
}

function onCommand(command) {
  switch (command) {
  case COMMAND_COOLANT_OFF:
    setCoolant(COOLANT_OFF);
    return;
  case COMMAND_COOLANT_ON:
    setCoolant(COOLANT_FLOOD);
    return;
  case COMMAND_LOCK_MULTI_AXIS:
    return;
  case COMMAND_UNLOCK_MULTI_AXIS:
    return;
  case COMMAND_START_CHIP_TRANSPORT:
    return;
  case COMMAND_STOP_CHIP_TRANSPORT:
    return;
  case COMMAND_BREAK_CONTROL:
    return;
  case COMMAND_TOOL_MEASURE:
    return;
  case COMMAND_ACTIVATE_SPEED_FEED_SYNCHRONIZATION:
    return;
  case COMMAND_DEACTIVATE_SPEED_FEED_SYNCHRONIZATION:
    return;

  case COMMAND_STOP:
    writeBlock(mFormat.format(0));
    forceSpindleSpeed = true;
    forceCoolant = true;
    return;
  case COMMAND_OPTIONAL_STOP:
    writeBlock(mFormat.format(1));
    forceSpindleSpeed = true;
    forceCoolant = true;
    break;
  case COMMAND_END:
    writeBlock(mFormat.format(2));
    break;
  case COMMAND_SPINDLE_CLOCKWISE:
    switch (currentSection.spindle) {
    case SPINDLE_PRIMARY:
      writeBlock(mFormat.format(3));
      break;
    case SPINDLE_SECONDARY:
      writeBlock(mFormat.format(143));
      break;
    }
    break;
  case COMMAND_SPINDLE_COUNTERCLOCKWISE:
    switch (currentSection.spindle) {
    case SPINDLE_PRIMARY:
      writeBlock(mFormat.format(4));
      break;
    case SPINDLE_SECONDARY:
      writeBlock(mFormat.format(144));
      break;
    }
    break;
  case COMMAND_START_SPINDLE:
    onCommand(tool.clockwise ? COMMAND_SPINDLE_CLOCKWISE : COMMAND_SPINDLE_COUNTERCLOCKWISE);
    return;
  case COMMAND_STOP_SPINDLE:
    switch (currentSection.spindle) {
    case SPINDLE_PRIMARY:
      writeBlock(mFormat.format(5));
      break;
    case SPINDLE_SECONDARY:
      writeBlock(mFormat.format(145));
      break;
    }
    break;
  case COMMAND_ORIENTATE_SPINDLE:
    if (getSpindle() == 0) {
      writeBlock(mFormat.format(19)); // use P or R to set angle (optional)
    } else {
      writeBlock(mFormat.format(119));
    }
    break;
  //case COMMAND_CLAMP: // TAG: add support for clamping
  //case COMMAND_UNCLAMP: // TAG: add support for clamping
  default:
    onUnsupportedCommand(command);
  }
}

function engagePartCatcher(engage) {
  if (engage) {
    // catch part here
    writeBlock(getCode("PART_CATCHER_ON"), formatComment(localize("PART CATCHER ON")));
  } else {
    onCommand(COMMAND_COOLANT_OFF);
    writeRetract();
    writeBlock(getCode("PART_CATCHER_OFF"), formatComment(localize("PART CATCHER OFF")));
    forceXYZ();
  }
}

function onSectionEnd() {
  // Handle sub-spindle operation completion (close chuck, final pauses)
  handleSubSpindleOperationEnd();

  // cancel SFM mode to preserve spindle speed
  if (tool.getSpindleMode() == SPINDLE_CONSTANT_SURFACE_SPEED) {
    // Suppress spindle restart during bar-pull sequence (after grab or pull cycle completes)
    if (!barPullSequenceActive) {
      startSpindle(false, true, getFramePosition(currentSection.getFinalPosition()));
    }
  }

  if (currentSection.partCatcher) {
    engagePartCatcher(false);
  }

  forceAny();
}

/** Output block to do safe retract and/or move to home position. */
var XZ = 4;
function writeRetract() {
  var words = []; // store all retracted axes in an array
  var singleLineRetract = false;
  var retractAxes = []; // axes to retract
  var method = getProperty("safePositionMethod");

  // define home positions
  if (method != "G74") {
    var _xHome = machineConfiguration.hasHomePositionX() ? machineConfiguration.getHomePositionX() : getProperty("homePositionX");
    var _yHome = machineConfiguration.hasHomePositionY() ? machineConfiguration.getHomePositionY() : toPreciseUnit(0, MM);
    var _zHome = machineConfiguration.getRetractPlane() != 0 ? machineConfiguration.getRetractPlane() : getProperty("homePositionZ");
  }

  if (arguments.length > 0) {
    for (var i in arguments) {
      retractAxes.push(arguments[i]);
      singleLineRetract = arguments[i] == XZ ? true : singleLineRetract;
    }
  } else {
    switch (getProperty("safePositionStyle")) {
    case "X":
      retractAxes.push(X);
      break;
    case "Z":
      retractAxes.push(Z);
      break;
    case "XZ":
      retractAxes.push(X, Z);
      break;
    case "ZX":
      retractAxes.push(Z, X);
      break;
    case "singleLineXZ":
      singleLineRetract = true;
      retractAxes.push(X, Z);
      break;
    }
  }

  // format home positions
  for (var i = 0; i < retractAxes.length; ++i) {
    switch (retractAxes[i]) {
    case X:
      words.push((method == "G74" ? "X" : "X" + xFormat.format(_xHome)));
      retracted[X] = true;
      xOutput.reset();
      break;
    case Y:
      if (yOutput.isEnabled()) {
        words.push((method == "G74" ? "Y" : "Y" + yFormat.format(_yHome)));
        yOutput.reset();
      }
      break;
    case Z:
      words.push((method == "G74" ? "Z" : "Z" + zFormat.format(_zHome)));
      retracted[Z] = true;
      zOutput.reset();
      break;
    case XZ:
      words.push((method == "G74" ? "X" : "X" + xFormat.format(_xHome)));
      words.push((method == "G74" ? "Z" : "Z" + zFormat.format(_zHome)));
      retracted[X] = true;
      retracted[Z] = true;
      xOutput.reset();
      zOutput.reset();
      break;
    default:
      error(localize("Unsupported axis specified for writeRetract()."));
      return;
    }
  }
  for (var i = 0; i < words.length; ++i) {
    switch (method) {
    case "G74":
      gAbsIncModal.reset();
      writeBlock(gFormat.format(74), singleLineRetract ? words : words[i]);
      break;
    case "G53":
      gMotionModal.reset();
      writeBlock(gFormat.format(53), gMotionModal.format(0), singleLineRetract ? words : words[i]);
      break;
    default:
      error(localize("Unsupported safe position method."));
      return;
    }
    if (singleLineRetract) {
      break;
    }
  }
  singleLineRetract = false; // singleLineRetract reset
}

function onClose() {
  // writeln("");

  optionalSection = false;

  // Clear bar-pull flag at program end
  // Flag persists through both grab and pull cycles to suppress unwanted spindle starts
  barPullSequenceActive = false;

  onCommand(COMMAND_COOLANT_OFF);

  forceXYZ();
  writeRetract();// change this to writeRetract(XZ) to force retract in XZ at the end of the program as a default

  onImpliedCommand(COMMAND_END);
  onImpliedCommand(COMMAND_STOP_SPINDLE);
  writeBlock(mFormat.format(30)); // stop program, spindle stop, coolant off
  writeln("%");
}

function setProperty(property, value) {
  properties[property].current = value;
}
