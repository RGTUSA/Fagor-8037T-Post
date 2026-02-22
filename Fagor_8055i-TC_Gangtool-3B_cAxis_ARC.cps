/**
  Copyright (C) 2012-2013 by Autodesk, Inc.
  All rights reserved.

  Fagor Lathe post processor configuration.

  $Revision: 37333 $
  $Date: 2016-05-19 03:32:20 +0000 (ti, 24 sep 2015) $
  
  FORKID {88B77760-269E-4d46-8588-30814E7FE9A1}
*/

vendor = "Tactical Keychains LLC";
vendorUrl = "Tacticalkeychains.com";
legal = "Copyright (C) 2016 TacticalKeychains LLC colab with Urban Survival Gear, LLC";
certificationLevel = 2;
minimumRevision = 24000;

extension = "pit";
programNameIsInteger = true;
setCodePage("ascii");

capabilities = CAPABILITY_MILLING | CAPABILITY_TURNING;
tolerance = spatial(0.002, MM);

minimumChordLength = spatial(0.01, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(120);
allowHelicalMoves = true;
allowedCircularPlanes = undefined; // allow any circular motion
allowSpiralMoves = false;
highFeedrate = (unit == IN) ? 100 : 1000;

// USER DEFINED PROPERTIES -----------------------------------------------------------------------------------------------------

properties = {
  writeMachine : false, // write machine
  preloadTool : false, // preloads next tool on tool change if any
  showSequenceNumbers : false, // show sequence numbers
  sequenceNumberStart : 10, // first sequence number
  sequenceNumberIncrement : 1, // increment for sequence numbers
  optionalStop : false, // optional stop
  o8 : false, // specifies 8-digit program number
  separateWordsWithSpace : true, // specifies that the words should be separated with a white space
  useRadius : true, // specifies that arcs should be output using the radius (R word) instead of the I, J, and K words.
  maximumSpindleSpeed : 4500, // specifies the maximum spindle speed
  gotPartCatcher: true, // specifies if the machine has a part catcher
  barPullerTool : 1, // identifies bar puller tool number
  type : "A", // specifies the type A, B, C
  useParametricFeed : false, // specifies that feed should be output using Q values
  showNotes : false, // specifies that operation notes should be output.
  DNC : "FAGOR 8055i-TC", // DNC type
  vendor : "Tactical Keychains LLC", // vendor name
  model : "ZV-27", // model name
  LiveToolM51: true, //if true then M51 and M50 will be used
};

// VARIABLE DEFINITIONS =========================================================================================================

var permittedCommentChars = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.[]*&%#@!|/:;=_-";

// AXIS MOTION ------------------------------------------------------------------------------------------------------------------

var gFormat = createFormat({prefix: "G", decimals: 1});
var mFormat = createFormat({prefix: "M", decimals: 1});
var kFormat = createFormat({prefix: "K", decimals: 0});
var dFormat = createFormat({prefix: "D", decimals: 0});

var spatialFormat = createFormat({decimals: (unit == MM ? 3 : 4), forceDecimal: true});
var xFormat = createFormat({decimals: (unit == MM ? 3 : 4), forceDecimal: true, scale: 2}); // diameter mode
var yFormat = createFormat({decimals: (unit == MM ? 3 : 4), forceDecimal: true});
var zFormat = createFormat({decimals: (unit == MM ? 3 : 4), forceDecimal: true});
var rFormat = createFormat({decimals: (unit == MM ? 3 : 4), forceDecimal: true});            // radius
var abcFormat = createFormat({decimals:3, forceDecimal:true, scale:DEG});

// THREADING FORMAT- ----------------------------------------------------------------------------------------------------------

// var cFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true});       // thread pitch
var cFormat = createFormat({decimals:3, forceDecimal:true, scale:DEG, cyclicLimit:Math.PI*2});
var iThreadFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true}); // thread offset for drive line
var jThreadFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true}); // thread initial thread depth
var xThreadFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true}); // major diameter
var kThreadFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true}); // thread depth
var rThreadFormat = createFormat({decimals:3, forceDecimal:true, zeropad:true});
var qThreadFormat = createFormat({decimals:3, forceDecimal:true, zeropad:true});
var bThreadFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true});
var dThreadFormat = createFormat({decimals:3, forceDecimal:true, zeropad:true});
var zThreadFormat = createFormat({decimals:3, forceDecimal:true, zeropad:true});
var cThreadFormat = createFormat({decimals:3, forceDecimal:true, zeropad:true});
var lThreadFormat = createFormat({decimals:4});
var aThreadFormat = createFormat({decimals:0});

// TOOL FORMAT ------------------------------------------------------------------------------------------------------------------

var feedFormat = createFormat({decimals: (unit == MM ? 4 : 5), forceDecimal: true});
var toolFormat = createFormat({decimals: 0, width: 2, zeropad: true});
var rpmFormat = createFormat({decimals: 0});
var taperFormat = createFormat({decimals: 1, scale: DEG});

// TIME / INFO FORMAT -----------------------------------------------------------------------------------------------------------

var timeFormat = createFormat({width:2, zeropad:true, decimals:0});
var secFormat = createFormat({decimals: 3, forceDecimal: true}); // seconds - range 0.001-99999.999
var milliFormat = createFormat({decimals: 0});                   // milliseconds // range 1-9999
var infoFormat = createFormat({decimals:4});

// OUTPUT VARIABLES -------------------------------------------------------------------------------------------------------------

var xOutput = createVariable({prefix: "X"}, xFormat);
var yOutput = createVariable({prefix: "Y"}, yFormat);
var zOutput = createVariable({prefix: "Z"}, zFormat);
var aOutput = createVariable({prefix:"A"}, abcFormat);
var bOutput = createVariable({prefix:"B"}, abcFormat);
var cOutput = createVariable({prefix:"C"}, cFormat);
var feedOutput = createVariable({prefix: "F"}, feedFormat);
var sOutput = createVariable({prefix: "S", force: true}, rpmFormat);
var dOutput = createVariable({}, dFormat);
var cOutput = createVariable({prefix:"C"}, cFormat);

// THREADING OUTPUT VARIABLES ---------------------------------------------------------------------------------------------------

var xThreadOutput = createVariable({prefix:"X", force:true}, xThreadFormat);
var zThreadOutput = createVariable({prefix:"Z", force:true}, zThreadFormat);
var rThreadOutput = createVariable({prefix:"R", force:true}, rThreadFormat);
var qThreadOutput = createVariable({prefix:"Q", force:true}, qThreadFormat);
var iThreadOutput = createVariable({prefix:"I", force:true}, iThreadFormat);
var bThreadOutput = createVariable({prefix:"B", force:true}, bThreadFormat);
var dThreadOutput = createVariable({prefix:"D", force:true}, dThreadFormat);
var lThreadOutput = createVariable({prefix:"L", force:true}, lThreadFormat);
var cThreadOutput = createVariable({prefix:"C", force:true}, cThreadFormat);
var jThreadOutput = createVariable({prefix:"J", force:true}, jThreadFormat);
var aThreadOutput = createVariable({prefix:"A", force:true}, aThreadFormat);

// CIRCULAR OUTPUT VARIABLES ----------------------------------------------------------------------------------------------------

var kOutput = createReferenceVariable({prefix: "K"}, xFormat);
var iOutput = createReferenceVariable({prefix: "I"}, xFormat); // no scaling

var g92ROutput = createVariable({prefix: "R"}, zFormat); // no scaling

// G-CODE FORMAT ----------------------------------------------------------------------------------------------------------------

var gMotionModal = createModal({}, gFormat);      // modal group 1 // G0-G3, ...
var gPlaneModal = createModal({onchange: function() {gMotionModal.reset();}}, gFormat); // modal group 2 // G17-19
var gAbsIncModal = createModal({}, gFormat);      // modal group 3 // G90-91 // only for B and C mode
var gFeedModeModal = createModal({}, gFormat);    // modal group 5 // G98-99 / G94-95
var gSpindleModeModal = createModal({}, gFormat); // modal group 5 // G96-97
var gUnitModal = createModal({}, gFormat);        // modal group 6 // G20-21
var gCycleModal = createModal({}, gFormat);       // modal group 9 // G81, ...
var gRetractModal = createModal({}, gFormat);     // modal group 10 // G98-99

// FIXED SETTINGS ---------------------------------------------------------------------------------------------------------------
var firstFeedParameter = 500;

var gotYAxis = false; // Y-axis not supported into this post, don´t turn it on!
var yAxisMinimum = toPreciseUnit(gotYAxis ? -50.8 : 0, MM); // specifies the minimum range for the Y-axis
var yAxisMaximum = toPreciseUnit(gotYAxis ? 50.8 : 0, MM); // specifies the maximum range for the Y-axis
var xAxisMinimum = toPreciseUnit(0, MM); // specifies the maximum range for the X-axis (RADIUS MODE VALUE)

var gotLiveTooling = true; // specifies if the machine is able to do live tooling
var gotCAxis = true;
var gotSecondarySpindle = false;
var gotTailStock = true;
var gotBarFeeder = true;
var gotPartCatcher = false;

var WARNING_WORK_OFFSET = 0;

// collected state
var sequenceNumber;
var currentWorkOffset;
var optionalSection = false;
var forceSpindleSpeed = false;
var activeMovements; // do not use by default
var currentFeedId;
var alreadyInThreadingCycle = false;


/** Returns the modulus. */
function getModulus(x, y) {
  return Math.sqrt(x * x + y * y);
}

/** Returns the required number of segments for linearization of the corresponding arc segment. */
function getNumberOfSegments(radius, sweep, error) {
  if (radius > error) {
    var stepAngle = 2 * Math.acos(1 - error/radius);
    return Math.max(Math.ceil(sweep/stepAngle), 1);
  }
  return 1;
}

/**
  Returns the C rotation for the given X and Y coordinates.
*/
function getC(x, y) {
  return Math.atan2(y, x);
}

/**
  Returns the C rotation for the given X and Y coordinates in the desired rotary direction.
*/
function getCClosest(x, y, _c, clockwise) {
  if (_c == Number.POSITIVE_INFINITY) {
    _c = 0; // undefined
  }
  var c = getC(x, y);
  if (clockwise != undefined) {
    if (clockwise) {
      while (c < _c) {
        c += Math.PI * 2;
      }
    } else {
      while (c > _c) {
        c -= Math.PI * 2;
      }
    }
  } else {
    min = _c - Math.PI;
    max = _c + Math.PI;
    while (c < min) {
      c += Math.PI * 2;
    }
    while (c > max) {
      c -= Math.PI * 2;
    }
  }
  return c;
}

/**
  Returns the desired tolerance for the given section.
*/
function getTolerance() {
  var t = tolerance;
  if (hasParameter("operation:tolerance")) {
    if (t > 0) {
      t = Math.min(t, getParameter("operation:tolerance"));
    } else {
      t = getParameter("operation:tolerance");
    }
  }
  return t;
}


// WRITE FUNCTIONS ==============================================================================================================

/**
  Writes the specified block.
*/
function writeBlock() {
  if (properties.showSequenceNumbers) {
    if (optionalSection) {
      var text = formatWords(arguments);
      if (text) {
        writeWords("/", "N" + sequenceNumber, text);
      }
    } else {
      writeWords2("N" + sequenceNumber, arguments);
    }
    sequenceNumber += properties.sequenceNumberIncrement;
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
  if (properties.showSequenceNumbers) {
    var words = formatWords(arguments);
    if (words) {
      writeWords("/", "N" + sequenceNumber, words);
      sequenceNumber += properties.sequenceNumberIncrement;
    }
  } else {
    writeWords2("/", arguments);
  }
}

function formatComment(text) {
  return ";(" + filterText(String(text).toUpperCase(), permittedCommentChars).replace(/[\(\)]/g, "") + ")";
}

/**
  Output a comment.
*/
function writeComment(text) {
    writeln(formatComment(text));
}

// PROGRAM SECTIONS ==========================================================================================================
var machineConfigurationZ;
var machineConfigurationXC;
var machineConfigurationXB;

function onOpen() {

  if (true) {
    machineConfigurationZ = new MachineConfiguration();

    if (gotCAxis) {
      var cAxis = createAxis({coordinate: 2, table: true, axis: [0, 0, 1], cyclic: true, preference: 0}); // C axis is modal between primary and secondary spindle
      machineConfigurationXC = new MachineConfiguration(cAxis);
      machineConfigurationXC.setSpindleAxis(new Vector(1, 0, 0));
    }
  }

  if (!gotYAxis) {
    yOutput.disable();
  }
  aOutput.disable();
  if (!machineConfigurationXB) {
    bOutput.disable();
  }
  if (!machineConfigurationXC) {
    cOutput.disable();
  }

  if (!properties.separateWordsWithSpace) {
    setWordSeparator("");
  }

  sequenceNumber = properties.sequenceNumberStart;
  //var PN1 = programName;
  writeln("%" + (programComment) + ",MX,"); // max 20 chars

  var oFormat = createFormat({width : (properties.o8 ? 8 : 4), zeropad : true, decimals : 0});
  //if (programComment) {
  //    writeln(";(" + programComment + ")");
  //}

  // GET TIME -------------------------------------------------------------------------------------------------------------------

  //generated :    2016-05-21   00:00
  var now = new Date();
  writeln(subst(
      ";(Generated : %1-%2-%3   %4:%5)",
      now.getFullYear(),
      timeFormat.format(now.getMonth() + 1),
      timeFormat.format(now.getDate()),
      timeFormat.format(now.getHours()),
      timeFormat.format(now.getMinutes())));

  // MACHINE INFO ---------------------------------------------------------------------------------------------------------------

  var vendor = properties.vendor;
  var model = properties.model;
  var DNC = properties.DNC;

  writeln(";(---------------- MACHINE INFO -------------------)");
  writeln(localize(";(Vendor") + ": " + vendor + ")");
  writeln(localize(";(Model") + ": " + model + ")");
  writeln(localize(";(DNC") + ": " + DNC + ")");

  // TOOL TABLE CALLOUT ----------------------------------------------------------------------------------------------------------

  writeln(";(----------------- TOOL TABLE --------------------)");

  writeToolInfo();

  // PROGRAM START ---------------------------------------------------------------------------------------------------------------

  writeln(";(---------------- BEGIN PROGRAM ------------------)");

  writeBlock(writeBlock(gUnitModal.format(70)), gAbsIncModal.format(90), gPlaneModal.format(18)); // HARD CODE INCHES, ABSOLUTE, WORK IN ZX PLANE

  //    switch (unit) {
  //        case IN:
  //            writeBlock(gUnitModal.format(70));
  //            break;
  //        case MM:
  //            writeBlock(gUnitModal.format(71));
  //            break;
  //    }

  // Max RPM ------------------------------------------------------------------------------------------

  writeBlock(gFormat.format(92), sOutput.format(properties.maximumSpindleSpeed));

  //    onCommand(COMMAND_START_CHIP_TRANSPORT);
}

// TOOL TABLE - FORMATS HEADER TO DISPLAY MIN Z AND CYCLETIME ------------------------------------------------------------------

function entryFixup(entry, minZ, ct) {
  ct += 0.5;
  var d = new Date(1899, 11, 31, 0, 0, ct, 0);
  var zCol = 26;
  var ctCol = 39;

  if (entry.length < zCol) {
    for (var i = entry.length; i < zCol; ++i) {
      entry += " ";
    }
  }
  entry += "Z: " + zFormat.format(minZ);
  if (entry.length < ctCol) {
    for (var i = entry.length; i < ctCol; ++i) {
      entry += " ";
    }
  }
  entry += "CT: " +
  timeFormat.format(d.getHours()) + ":" +
  timeFormat.format(d.getMinutes()) + ":" +
  timeFormat.format(d.getSeconds()) + ")";
  return entry;
}

// TOOL TABLE - RETURNS TOOL INFO IN ARRAY -------------------------------------------------------------------------------------

function writeToolInfo() {
  var result = [];
  var lastToolIndex;
  var _maxZ = 1000000;
  var minimumZ;
  var cycleTime;
  var tn_;
  var numberOfSections = getNumberOfSections();

  for (var i = 0; i < numberOfSections; ++i) {
    var section = getSection(i);

    // the next tool is up...
    if (section.getTool().number != tn_) {
      // fix up the last tool entry...on the first iteration tn_ will be empty
      if (tn_) {
        result[lastToolIndex] = entryFixup(result[lastToolIndex], minimumZ, cycleTime);
      }
      cycleTime = 0;
      minimumZ = _maxZ;
      tn_ = section.getTool().number;
      lastToolIndex = result.length;
      result.push(";(T=" + tn_ + " " + section.getTool().description);
    }

    if (is3D()) {
      minimumZ = Math.min(minimumZ, section.getGlobalZRange().getMinimum());
    }
    cycleTime += section.getCycleTime();
  }
  if (result.length > 0) {
    result[lastToolIndex] = entryFixup(result[lastToolIndex], minimumZ, cycleTime);
  }
  for (var i = 0; i < result.length; ++i) {
    writeln(result[i]);
  }
}

// FUNCTION DEFINITIONS ---------------------------------------------------------------------------------------------------------

function onComment(message) {
    writeComment(message);
}

/** Force output of X, Y, and Z. */
function forceXYZ() {
    xOutput.reset();
    yOutput.reset();
    zOutput.reset();
}

/** Force output of A, B, and C. */
function forceABC() {
  aOutput.reset();
  bOutput.reset();
  cOutput.reset();
}

function forceFeed() {
  currentFeedId = undefined;
  feedOutput.reset();
}

/** Force output of X, Y, Z, A, B, C, and F on next output. */
function forceAny() {
  forceXYZ();
  forceABC();
  forceFeed();
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
        return "F#" + (firstFeedParameter + feedContext.id);
      }
    }
    currentFeedId = undefined; // force Q feed next time
  }
  return feedOutput.format(f); // use feed value
}

function initializeActiveFeeds() {
    activeMovements = new Array();
    var movements = currentSection.getMovements();

    var id = 0;
    var activeFeeds = new Array();
    if (hasParameter("operation:tool_feedCutting")) {
        if (movements & ((1 << MOVEMENT_CUTTING) | (1 << MOVEMENT_LINK_TRANSITION) | (1 << MOVEMENT_EXTENDED))) {
            var feedContext = new FeedContext(id, localize("Cutting"), getParameter("operation:tool_feedCutting"));
            activeFeeds.push(feedContext);
            activeMovements[MOVEMENT_CUTTING] = feedContext;
            activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
            activeMovements[MOVEMENT_EXTENDED] = feedContext;
        }
        ++id;
        if (movements & (1 << MOVEMENT_PREDRILL)) {
            feedContext = new FeedContext(id, localize("Predrilling"), getParameter("operation:tool_feedCutting"));
            activeMovements[MOVEMENT_PREDRILL] = feedContext;
            activeFeeds.push(feedContext);
        }
        ++id;
    }

    if (hasParameter("operation:finishFeedrate")) {
        if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
            var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:finishFeedrate"));
            activeFeeds.push(feedContext);
            activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
        }
        ++id;
    } else if (hasParameter("operation:tool_feedCutting")) {
        if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
            var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:tool_feedCutting"));
            activeFeeds.push(feedContext);
            activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
        }
        ++id;
    }

    if (hasParameter("operation:tool_feedEntry")) {
        if (movements & (1 << MOVEMENT_LEAD_IN)) {
            var feedContext = new FeedContext(id, localize("Entry"), getParameter("operation:tool_feedEntry"));
            activeFeeds.push(feedContext);
            activeMovements[MOVEMENT_LEAD_IN] = feedContext;
        }
        ++id;
    }

    if (hasParameter("operation:tool_feedExit")) {
        if (movements & (1 << MOVEMENT_LEAD_OUT)) {
            var feedContext = new FeedContext(id, localize("Exit"), getParameter("operation:tool_feedExit"));
            activeFeeds.push(feedContext);
            activeMovements[MOVEMENT_LEAD_OUT] = feedContext;
        }
        ++id;
    }

    if (hasParameter("operation:noEngagementFeedrate")) {
        if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
            var feedContext = new FeedContext(id, localize("Direct"), getParameter("operation:noEngagementFeedrate"));
            activeFeeds.push(feedContext);
            activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
        }
        ++id;
    } else if (hasParameter("operation:tool_feedCutting") &&
        hasParameter("operation:tool_feedEntry") &&
        hasParameter("operation:tool_feedExit")) {
        if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
            var feedContext = new FeedContext(id, localize("Direct"), Math.max(getParameter("operation:tool_feedCutting"), getParameter("operation:tool_feedEntry"), getParameter("operation:tool_feedExit")));
            activeFeeds.push(feedContext);
            activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
        }
        ++id;
    }

  if (hasParameter("operation:reducedFeedrate")) {
    if (movements & (1 << MOVEMENT_REDUCED)) {
      var feedContext = new FeedContext(id, localize("Reduced"), getParameter("operation:reducedFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_REDUCED] = feedContext;
    }
    ++id;
  }

    if (hasParameter("operation:tool_feedRamp")) {
        if (movements & ((1 << MOVEMENT_RAMP) | (1 << MOVEMENT_RAMP_HELIX) | (1 << MOVEMENT_RAMP_PROFILE) | (1 << MOVEMENT_RAMP_ZIG_ZAG))) {
            var feedContext = new FeedContext(id, localize("Ramping"), getParameter("operation:tool_feedRamp"));
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
            var feedContext = new FeedContext(id, localize("Plunge"), getParameter("operation:tool_feedPlunge"));
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

    for (var i = 0; i < activeFeeds.length; ++i) {
        var feedContext = activeFeeds[i];
        writeBlock("#" + (firstFeedParameter + feedContext.id) + "=" + feedFormat.format(feedContext.feed), formatComment(feedContext.description));
    }
}

var currentWorkPlaneABC = undefined;

function forceWorkPlane() {
  currentWorkPlaneABC = undefined;
}

function setWorkPlane(abc) {
  // milling only

  if (!machineConfiguration.isMultiAxisConfiguration()) {
    return; // ignore
  }

  if (!((currentWorkPlaneABC == undefined) ||
        abcFormat.areDifferent(abc.x, currentWorkPlaneABC.x) ||
        abcFormat.areDifferent(abc.y, currentWorkPlaneABC.y) ||
        abcFormat.areDifferent(abc.z, currentWorkPlaneABC.z))) {
    return; // no change
  }

  onCommand(COMMAND_UNLOCK_MULTI_AXIS);

  writeBlock(
    gMotionModal.format(0),
    conditional(machineConfiguration.isMachineCoordinate(0), "A" + abcFormat.format(abc.x)),
    conditional(machineConfiguration.isMachineCoordinate(1), "B" + abcFormat.format(abc.y)),
    conditional(machineConfiguration.isMachineCoordinate(2), "C" + abcFormat.format(abc.z))
  );
  
  onCommand(COMMAND_LOCK_MULTI_AXIS);

  currentWorkPlaneABC = abc;
}

var useXZCMode = false;
var usePolarMode = false;

var closestABC = false; // choose closest machine angles
var currentMachineABC;

function getWorkPlaneMachineABC(workPlane) {
  var W = workPlane; // map to global frame

  var abc = machineConfiguration.getABC(W);
  if (closestABC) {
    if (currentMachineABC) {
      abc = machineConfiguration.remapToABC(abc, currentMachineABC);
    } else {
      abc = machineConfiguration.getPreferredABC(abc);
    }
  } else {
    abc = machineConfiguration.getPreferredABC(abc);
  }
  
  try {
    abc = machineConfiguration.remapABC(abc);
    currentMachineABC = abc;
  } catch (e) {
    error(
      localize("Machine angles not supported") + ":"
      + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
      + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
      + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
    );
  }
  
  var direction = machineConfiguration.getDirection(abc);
  if (!isSameDirection(direction, W.forward)) {
    error(localize("Orientation not supported."));
  }
  
  if (!machineConfiguration.isABCSupported(abc)) {
    error(
      localize("Work plane is not supported") + ":"
      + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
      + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
      + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
    );
  }

  var tcp = useXZCMode;
  if (tcp) {
    setRotation(W); // TCP mode
  } else {
    var O = machineConfiguration.getOrientation(abc);
    var R = machineConfiguration.getRemainingOrientation(abc, W);
    setRotation(R);
  }
  
  return abc;
}

function getLiveToolingMode(section) {
  if (section.getType() != TYPE_MILLING) {
    return -1;
  }
  var forward = section.workPlane.forward;
  if (isSameDirection(forward, new Vector(0, 0, 1))) {
    // writeln("(Milling from Z+ G17)");
    return 0;
  } else if (isSameDirection(forward, new Vector(0, 0, -1))) {
    return 1;
  } else if (Vector.dot(forward, new Vector(0, 0, 1)) < 1e-7) {
    // writeln("(Milling from X+ G19)");
    return 2;
  } else {
    error(localize("Orientation is not supported by CNC machine."));
    return -1;
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

function getAxialCenterDrilling(section) {
  if (section.hasParameter("operation-strategy") && (section.getParameter("operation-strategy") == "drill") &&
     (section.getNumberOfCyclePoints() == 1) &&
     !xFormat.isSignificant(getFramePosition(section.getInitialPosition()).x) &&
     !yFormat.isSignificant(getFramePosition(section.getInitialPosition()).y) &&
     (section.getType() == TYPE_MILLING) &&
     (getLiveToolingMode(section) == 0) &&
     (spatialFormat.format(section.getFinalPosition().x) == 0)) { // catch drill issue for old versions
    return true;
  } else {
    return false;
  }
}

function onSection() {
  


  var forceToolAndRetract = optionalSection && !currentSection.isOptional();
  optionalSection = currentSection.isOptional();

  var turning = (currentSection.getType() == TYPE_TURNING);

  var insertToolCall = forceToolAndRetract || isFirstSection() ||
    currentSection.getForceToolChange && currentSection.getForceToolChange() ||
    (tool.number != getPreviousSection().getTool().number) ||
    (tool.compensationOffset != getPreviousSection().getTool().compensationOffset) ||
    (tool.diameterOffset != getPreviousSection().getTool().diameterOffset);

  var retracted = false; // specifies that the tool has been retracted to the safe plane
  var newSpindle = isFirstSection() ||
    (getPreviousSection().spindle != currentSection.spindle);
  var newWorkOffset = isFirstSection() ||
    (getPreviousSection().workOffset != currentSection.workOffset); // work offset changes
  var newWorkPlane = isFirstSection() ||
    !isSameDirection(getPreviousSection().getGlobalFinalToolAxis(), currentSection.getGlobalInitialToolAxis());
  var axialCenterDrilling = getAxialCenterDrilling(currentSection);

	if (insertToolCall || newSpindle || newWorkOffset || newWorkPlane) {
    retracted = true; // AT TOOL CHANGE OR SPINDLE CHANGE OR OFFSET CHANGE
    writeBlock(gFormat.format(53), gMotionModal.format(0), zOutput.format(0)); // RETRACT TABLE TO HOME IN AT RAPID RATE
    forceXYZ();
    writeBlock(gFormat.format(40)); // THEN CANCEL RAD OFFSET + RESET TO CURRENT WORK OFFSET G54, G55, G56......
    writeBlock(gFormat.format(53 + currentSection.workOffset)); // THEN CANCEL RAD OFFSET + RESET TO CURRENT WORK OFFSET G54, G55, G56......
	}

  if (currentSection.getType() == TYPE_MILLING) { // handle multi-axis toolpath
    if (!gotLiveTooling) {
      error(localize("Live tooling is not supported by the CNC machine."));
      return;
    }

    var config;
    if (!currentSection.isMultiAxis() && isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1))) {
      config = machineConfigurationZ;
    } else if (!currentSection.isMultiAxis() && isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, -1))) {
      error(localize("Milling from Z- is not supported by the CNC machine."));
      return;
    } else {
      switch (currentSection.spindle) {
      case SPINDLE_PRIMARY:
        config = machineConfigurationXC;
        bOutput.disable();
        cOutput.enable();
        break;
      case SPINDLE_SECONDARY:
        config = machineConfigurationXC; // yes - C is intended
        bOutput.disable();
        cOutput.enable();
        break;
      default:
        error(localize("Unsupported spindle."));
        return;
      }
    }
    
    if (!config) {
      error(localize("The requested orientation is not supported by the CNC machine."));
      return;
    }
    setMachineConfiguration(config);
    currentSection.optimizeMachineAnglesByMachine(config, 1); // map tip mode
  }

  /** Polar mode. */
  if (currentSection.getGlobalRange) {
    if ((currentSection.getType() == TYPE_MILLING) &&
        (hasParameter("operation:strategy") && (getParameter("operation:strategy") != "drill")) &&
        !currentSection.isMultiAxis() && (getLiveToolingMode(currentSection) == 0)) {
      if (doesToolpathFitInXYRange(abc)) {
        if (!currentSection.isPatterned()) {
          usePolarMode = false; // use the Y-axis
        } else {
          usePolarMode = true; // needed if there is no Y-Axis
        }
      } else {
        usePolarMode = true; // toolpath does not fit into XY range
      }
    } else {
      usePolarMode = false;
    }
  } else {
    if (revision < 40000) {
      warning(localize("Please update to the latest release to allow XY linear interpolation instead of polar interpolation."));
    }
    usePolarMode = true; // for older versions without the getGlobalRange() function
  }

  /** XZC mode. */
  if (currentSection.getType() == TYPE_MILLING) {
    if (getLiveToolingMode(currentSection) == 0) { // G17 plane
      useXZCMode = hasParameter("operation-strategy") && (getParameter("operation-strategy") == "drill");
    } else if (getLiveToolingMode(currentSection) == 2) { // G19 plane
      useXZCMode = (hasParameter("operation-strategy") && getParameter("operation-strategy") != "drill" && !doesToolpathFitInXYRange(machineConfiguration.getABC(currentSection.workPlane)));
    } else {
      error(localize("Direction is not supported for XZC Mode"));
      return;
    }
  } else {
    useXZCMode = false; // turning
  }

  if (useXZCMode && usePolarMode) {
    error(localize("Internal postprocessor error. Please contact your support."));
    return;
  }
  
  if (gotCAxis) {
    if (axialCenterDrilling) {
      useXZCMode = false;
      cOutput.disable();
    } else {
      cOutput.enable();
    }
  }
  
  if (false) { // DEBUG
    writeComment("Polar mode = " + usePolarMode);
    writeComment("Live tool mode " + getLiveToolingMode(currentSection));
    writeComment("XZC mode = " + useXZCMode);
    writeComment("axial center drilling = " + axialCenterDrilling);
    // writeComment("Stock transfer = " + stockTransfer);
    // writeComment("Tapping = " + tapping);
  }
	
// TOOL CALL-OUT PRIOR TO EACH TOOL CHANGE ----------------------------------------------------------------

    if (insertToolCall) {
      writeln(";(-------------------------------------------------)");
      if (currentSection.getParameter("operation-strategy") == "turningStockTransfer") {
        writeln(";(T=" + toolFormat.format(properties.barPullerTool) + " Bar Puller)");
      } else {
        var toolLine = tool.number + " " + tool.description;
        writeln(";(T=" + toolLine + ")");
      }
    } else {
      writeln(";(-------------------------------------------------)");
    }
    
    if (hasParameter("operation-comment")) {
      var comment = getParameter("operation-comment");
      writeln(";(" + "Operation: " + comment + ")");
      writeln(";(-------------------------------------------------)");
      if (properties.showNotes && hasParameter("notes")) {
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
    }
    
    if (insertToolCall) {
      forceWorkPlane();
      retracted = true;
      // onCommand(COMMAND_COOLANT_OFF);

      if (!isFirstSection() && properties.optionalStop) {
        onCommand(COMMAND_OPTIONAL_STOP);
      }
      if (tool.number > 99) {
        warning(localize("Tool number exceeds maximum value."));
      }

      var compensationOffset = tool.isTurningTool() ? tool.compensationOffset : tool.lengthOffset;
      if (compensationOffset > 99) {
        error(localize("Compensation offset is out of range."));
        return;
      }
      if (currentSection.getParameter("operation-strategy") == "turningStockTransfer") {
        writeBlock("T" + toolFormat.format(properties.barPullerTool) + " D" + toolFormat.format(properties.barPullerTool), mFormat.format(6));
      } else {
        writeBlock("T" + toolFormat.format(tool.number) + " D" + toolFormat.format(compensationOffset), mFormat.format(6));
      }

      if (properties.preloadTool) {
        var nextTool = getNextTool(tool.number);
        if (nextTool) {
          var compensationOffset = nextTool.isTurningTool() ? nextTool.compensationOffset : nextTool.lengthOffset;
          if (compensationOffset > 99) {
            error(localize("Compensation offset is out of range."));
            return;
          }
          writeBlock("T" + toolFormat.format(nextTool.number * 100 + compensationOffset));
        } else {
          // preload first tool
          var section = getSection(0);
          var firstTool = section.getTool().number;
          if (tool.number != firstTool.number) {
            var compensationOffset = firstTool.isTurningTool() ? firstTool.compensationOffset : firstTool.lengthOffset;
            if (compensationOffset > 99) {
              error(localize("Compensation offset is out of range."));
              return;
            }
            writeBlock("T" + toolFormat.format(firstTool.number * 100 + compensationOffset));
          }
        }
      }
    }

    // wcs
    if (insertToolCall) { // force work offset when changing tool
      currentWorkOffset = undefined;
    }
    var workOffset = currentSection.workOffset;
    if (workOffset == 0) {
      warningOnce(localize("Work offset has not been specified. Using G54 as WCS."), WARNING_WORK_OFFSET);
      workOffset = 1;
    }
    if (workOffset > 0) {
      if (workOffset > 6) {
        error(localize("Work offset out of range."));
        return;
      } else {
        if (workOffset != currentWorkOffset) {
          forceWorkPlane();
          writeBlock(gFormat.format(53 + workOffset)); // G54->G59
          currentWorkOffset = workOffset;
        }
      }
    }
    
  // set coolant after we have positioned at Z
    setCoolant(tool.coolant);

    forceAny();
    gMotionModal.reset();

    gFeedModeModal.reset();
    if (currentSection.feedMode == FEED_PER_REVOLUTION) {
      writeBlock(gFeedModeModal.format(95));
    } else {
      writeBlock(gFeedModeModal.format(94));
    }

// SPINDLE DIRECTION CODE ----------------------------------------------------------------------------
    var useConstantSurfaceSpeed = currentSection.getTool().getSpindleMode() == SPINDLE_CONSTANT_SURFACE_SPEED;
    if (currentSection.getParameter("operation-strategy") == "turningStockTransfer") {
      writeBlock(gFeedModeModal.format(94));
      writeBlock(mFormat.format(5)); //spindle off
    } else {
      if (turning) {
        if (gotTailStock) {
          //writeBlock(mFormat.format(currentSection.tailstock ? getCode("TAILSTOCK_ON") : getCode("TAILSTOCK_OFF")));
        }
        gSpindleModeModal.reset();
        sOutput.reset();
        if (useConstantSurfaceSpeed) {
          var maximumSpindleSpeed = (tool.maximumSpindleSpeed > 0) ? Math.min(tool.maximumSpindleSpeed, properties.maximumSpindleSpeed) : properties.maximumSpindleSpeed;
          writeBlock(gFormat.format(92), sOutput.format(maximumSpindleSpeed));
        }
        if (currentSection.getParameter("operation:threadingHand") == "left") { // FOR LEFTHAND THREADS
          writeBlock(gSpindleModeModal.format(97), sOutput.format(tool.spindleRPM), mFormat.format(4));
        } else {
          writeBlock(
            gSpindleModeModal.format(useConstantSurfaceSpeed ? 96 : 97),
            sOutput.format(useConstantSurfaceSpeed ? tool.surfaceSpeed * ((unit == MM) ? 1 / 1000.0 : 1 / 12.0) : tool.spindleRPM),
            mFormat.format(tool.clockwise ? 3 : 4));
        }
        sOutput.reset();
        // wait for spindle here if required
      } else {
		  if (properties.LiveToolM51 == true){
			  writeBlock(mFormat.format(51));
		  } else {
			writeBlock(gSpindleModeModal.format(97), mFormat.format(45), "S" + (tool.clockwise ? "+" : "-") + tool.spindleRPM);
      }
    }
	}
	var StockRad = hasGlobalParameter("stock-upper-x") ? getGlobalParameter("stock-upper-x") : "";
	var TrueStock = StockRad/25.4;
	
    var abc;
    if (currentSection.getType() == TYPE_TURNING) {
      // add support for tool indexing
      writeBlock(gPlaneModal.format(18));
      setRotation(currentSection.workPlane);
    } else if (!currentSection.isMultiAxis() && isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1))) {
		//useXZCMode == true;
      if (useXZCMode) {
        writeBlock(gFormat.format(15));
      } else {
        writeBlock(gPlaneModal.format(17));
      }
      if (gotCAxis) {
        if (!usePolarMode && !useXZCMode) {
          onCommand(COMMAND_UNLOCK_MULTI_AXIS);
		  writeBlock(gFormat.format(18), "ZC");
          writeBlock(mFormat.format(19), "S" + abcFormat.format(0)); // unwind c-axis
        }
      }
      writeComment("Machining from Z+ G17");
      setRotation(currentSection.workPlane);
    } else if (!currentSection.isMultiAxis() && isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, -1))) {
      writeBlock(gPlaneModal.format(17));
      writeComment("Machining from Z- G17");
      setRotation(currentSection.workPlane);
    } else if (machineConfigurationXC || machineConfigurationXB || machineConfiguration.isMultiAxisConfiguration()) { // use 5-axis indexing for multi-axis mode
      writeBlock(gFormat.format(15), "R" + yFormat.format(TrueStock));
	  writeBlock(gFormat.format(18), "ZC");
      if (useXZCMode) {
        //writeBlock(gFormat.format(15));
      }
      //writeComment("Machining from X+ G19");
      // park sub spindle so there is room for milling from X+

      if (currentSection.isMultiAxis()) {
        forceWorkPlane();
        cancelTransformation();
        onCommand(COMMAND_UNLOCK_MULTI_AXIS);
        writeBlock(gFormat.format(15));
      } else {
        abc = getWorkPlaneMachineABC(currentSection.workPlane);
        setWorkPlane(abc);
      }
    } else { // pure 3D
      var remaining = currentSection.workPlane;
      if (!isSameDirection(remaining.forward, new Vector(0, 0, 1))) {
        error(localize("Tool orientation is not supported by the CNC machine."));
        return;
      }
      setRotation(remaining);
	  //useXZCMode==false;
    }
    forceAny();
    if (abc !== undefined) {
      cOutput.format(abc.z); // make C current - we do not want to output here
    }
    gMotionModal.reset();


  
    var initialPosition = getFramePosition(currentSection.getInitialPosition());
/*
    if (!retracted) {
    // TAG: need to retract along X or Z
      if (getCurrentPosition().z < initialPosition.z) {
        writeBlock(gMotionModal.format(0), zOutput.format(initialPosition.z));
      }
    }
*/
  if (usePolarMode) {
    setPolarMode(true); // enable polar interpolation mode
  }
    
    if (insertToolCall || retracted) {
      gPlaneModal.reset();
      gMotionModal.reset();
      if (useXZCMode) {
        // writeBlock(gPlaneModal.format(17));
        writeBlock(gMotionModal.format(0), zOutput.format(initialPosition.z));
        writeBlock(
          gMotionModal.format(0),
          xOutput.format(getModulus(initialPosition.x, initialPosition.y)),
          conditional(gotYAxis, yOutput.format(0)),
          cOutput.format(getC(initialPosition.x, initialPosition.y))
        );
      } else {
        if (properties.type == "A") {
          if ((getParameter("operation:strategy") == "turningPart")) {
            writeBlock(gMotionModal.format(0), xOutput.format(-initialPosition.x));
            writeBlock(
              gMotionModal.format(0), zOutput.format(initialPosition.z));
          } else {
            writeBlock(gMotionModal.format(0), xOutput.format(initialPosition.x), yOutput.format(initialPosition.y));
            writeBlock(gMotionModal.format(0), zOutput.format(initialPosition.z));
          }
        } else {
          writeBlock(gMotionModal.format(0), zOutput.format(initialPosition.z));
          writeBlock(gAbsIncModal.format(90), gMotionModal.format(0), xOutput.format(-initialPosition.x), yOutput.format(initialPosition.y));
        }
      }
    }
    
    if (properties.gotPartCatcher) {
      engagePartCatcher(true);
    }

    if (properties.useParametricFeed &&
      hasParameter("operation-strategy") &&
      (getParameter("operation-strategy") != "drill")) {
      if (!insertToolCall &&
        activeMovements &&
        (getCurrentSectionId() > 0) &&
        (getPreviousSection().getPatternId() == currentSection.getPatternId())) {
        // use the current feeds
      } else {
        initializeActiveFeeds();
      }
    } else {
      activeMovements = undefined;
    }
}

/** Returns true if the toolpath fits within the machine XY limits for the given C orientation. */
function doesToolpathFitInXYRange(abc) {
  var c = 0;
  if (abc) {
    c = abc.z;
  }

  var dx = new Vector(Math.cos(c), Math.sin(c), 0);
  var dy = new Vector(Math.cos(c + Math.PI/2), Math.sin(c + Math.PI/2), 0);
  
  var xRange = currentSection.getGlobalRange(dx);
  var yRange = currentSection.getGlobalRange(dy);

  if (false) { // DEBUG
    writeComment("toolpath X min: " + xFormat.format(xRange[0]) + ", " + "Limit " + xFormat.format(xAxisMinimum));
    writeComment("X-min within range: " + (xFormat.getResultingValue(xRange[0]) >= xFormat.getResultingValue(xAxisMinimum)));
    writeComment("toolpath Y min: " + spatialFormat.getResultingValue(yRange[0]) + ", " + "Limit " + yAxisMinimum);
    writeComment("Y-min within range: " + (spatialFormat.getResultingValue(yRange[0]) >= yAxisMinimum));
    writeComment("toolpath Y max: " + (spatialFormat.getResultingValue(yRange[1]) + ", " + "Limit " + yAxisMaximum));
    writeComment("Y-max within range: " + (spatialFormat.getResultingValue(yRange[1]) <= yAxisMaximum));
  }

  if (getLiveToolingMode(currentSection) == 2) { // G19 plane
    if ((spatialFormat.getResultingValue(yRange[0]) >= yAxisMinimum) &&
        (spatialFormat.getResultingValue(yRange[1]) <= yAxisMaximum)) {
      return true; // toolpath does fit in XY range
    } else {
      return false; // toolpath does not fit in XY range
    }
  } else { // G17 plane
    if ((xFormat.getResultingValue(xRange[0]) >= xFormat.getResultingValue(xAxisMinimum)) &&
        (spatialFormat.getResultingValue(yRange[0]) >= yAxisMinimum) &&
        (spatialFormat.getResultingValue(yRange[1]) <= yAxisMaximum)) {
      return true; // toolpath does fit in XY range
    } else {
      return false; // toolpath does not fit in XY range
    }
  }
}

function setPolarMode(activate) {
  if (activate) {
    xFormat.setScale(1); // radius mode
    xOutput = createVariable({prefix:"X"}, xFormat);
    writeBlock(gFormat.format(15));  // command for polar interpolation
    writeBlock(gFormat.format(16) + " XC");
    yOutput = createVariable({prefix:"C"}, yFormat); // use Y coordinates in G112 as C
    yOutput.enable(); // required for G112, no matter if gotYAxis is true or false
  } else {
    xFormat.setScale(2); // diameter mode
    xOutput = createVariable({prefix:"X"}, xFormat);
    yOutput = createVariable({prefix:"Y"}, yFormat);
    cOutput.reset();
    if (!gotYAxis) {
      yOutput.disable();
    }
  }
  forceXYZ();
}

function onDwell(seconds) {
  if (seconds > 99999.999) {
    warning(localize("Dwelling time is out of range."));
  }
  milliseconds = clamp(1, seconds * 1000, 99999999);
  writeBlock(gFormat.format(4), "K" + milliFormat.format(milliseconds));
}

var pendingRadiusCompensation = -1;

function onRadiusCompensation() {
  pendingRadiusCompensation = radiusCompensation;
}

var resetFeed = false;

function onRapid(_x, _y, _z) {
  if (useXZCMode) {
    var start = getCurrentPosition();
    var dxy = getModulus(_x - start.x, _y - start.y);
    if (true || (dxy < getTolerance())) {
      var x = xOutput.format(getModulus(_x, _y));
      var c = cOutput.format(getCClosest(_x, _y, cOutput.getCurrent()));
      var z = zOutput.format(_z);
      if (pendingRadiusCompensation >= 0) {
        error(localize("Radius compensation mode is not supported for XZC Mode."));
        return;
      }
      if (x || c || z) {
        writeBlock(gMotionModal.format(0), x, c, z);
      }
      forceFeed();
      return;
    }
  
    onLinear(_x, _y, _z, highFeedrate);
    return;
  }
  
    if ((getParameter("operation:strategy") == "turningPart")) {
      var x = xOutput.format(-_x);
    } else {
      var x = xOutput.format(_x);
    }
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
  if (useXZCMode) {
    if (pendingRadiusCompensation >= 0) {
      error(localize("Radius compensation mode is not supported for XZC Mode."));
      return;
    }

    var start = getCurrentPosition();
    var startRadius = getModulus(start.x, start.y);
    var endRadius = getModulus(_x, _y);
    var radius = Math.min(startRadius, endRadius);
    if (false && !xFormat.areDifferent(startRadius, endRadius)) { // TAG: need to check DX/DY also
      var x = xOutput.format(endRadius);
      var z = zOutput.format(_z);
      if (xFormat.isSignificant(endRadius)) {
        var c = cOutput.format(getCClosest(_x, _y, cOutput.getCurrent()));
        writeBlock(gMotionModal.format(1), x, c, z, getFeed(feed));
      } else {
        writeBlock(gMotionModal.format(1), x, z, getFeed(feed)); // keep C
      }
      return;
    }
    if ((radius < 0.1) &&
        hasParameter("operation-strategy") &&
        (getParameter("operation-strategy") != "drill")) { // TAG: how should we handle small radii
      error(localize("Cannot machine radius 0."));
      return;
    }

    var c = getCClosest(_x, _y, cOutput.getCurrent());
    var sweep = Math.abs(c - cOutput.getCurrent());
    if (sweep >= (Math.PI - 1e-6)) {
      error(localize("Cannot machine 180deg sweep."));
      return;
    }
  
    var numberOfSegments = getNumberOfSegments(radius, sweep, getTolerance());
    // writeComment("onLinear(): C-sweep:" + abcFormat.format(sweep) + " #segments:" + numberOfSegments);
    var factor = 1.0/numberOfSegments;
    for (var i = 1; i <= numberOfSegments; ++i) {
      var u = i * factor;
      var ux = u * _x + (1 - u) * start.x;
      var uy = u * _y + (1 - u) * start.y;
      var uz = u * _z + (1 - u) * start.z;
      var x = xOutput.format(getModulus(ux, uy));
      var c = cOutput.format(getCClosest(ux, uy, cOutput.getCurrent()));
      var z = zOutput.format(uz);
      writeBlock(gMotionModal.format(1), x, c, z, getFeed(feed));
    }
    return;
  }

  if ((getParameter("operation:strategy") == "turningPart")) {
    var x = xOutput.format(-_x);
  } else {
    var x = xOutput.format(_x);
  }
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

function onRapid5D(_x, _y, _z, _a, _b, _c) {
  if (!currentSection.isOptimizedForMachine()) {
    error(localize("Multi-axis motion is not supported for XZC mode."));
    return;
  }
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation mode cannot be changed at rapid traversal."));
    return;
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = aOutput.format(_a);
  var b = bOutput.format(_b);
  var c = cOutput.format(_c);
  if (true) {
    // axes are not synchronized
    writeBlock(gMotionModal.format(1), x, y, z, a, b, c, getFeed(highFeedrate));
  } else {
    writeBlock(gMotionModal.format(0), x, y, z, a, b, c);
    forceFeed();
  }
}

function onLinear5D(_x, _y, _z, _a, _b, _c, feed) {
  if (!currentSection.isOptimizedForMachine()) {
    error(localize("Multi-axis motion is not supported for XZC mode."));
    return;
  }
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for 5-axis move."));
    return;
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = aOutput.format(_a);
  var b = bOutput.format(_b);
  var c = cOutput.format(_c);
  var f = getFeed(feed);

  if (x || y || z || a || b || c) {
    writeBlock(gMotionModal.format(1), x, y, z, a, b, c, f);
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gMotionModal.format(1), f);
    }
  }
}

function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
/* 	//var useXZCMode = true;
  if (!useXZCMode) {
    // TAG: var numberOfSegments = toDeg(getCircularSweep())/120;

    switch (getCircularPlane()) {
    case PLANE_XY:
      if (!isSpiral()) {
        var c = getCClosest(x, y, cOutput.getCurrent());
        if (!cFormat.areDifferent(c, cOutput.getCurrent())) {
          validate(getCircularSweep() < Math.PI, localize("Circular sweep exceeds limit."));
          var start = getCurrentPosition();
          writeBlock(gPlaneModal.format(18), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(getModulus(x, y)), cOutput.format(c), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
          return;
        }
      }
      break;
    case PLANE_ZX:
      //var d2 = center.x * center.x + center.y * center.y;
      var c = getCClosest(x, y, cOutput.getCurrent());
        if (!cFormat.areDifferent(c, cOutput.getCurrent())) {
          validate(getCircularSweep() < Math.PI, localize("Circular sweep exceeds limit."));
          var start = getCurrentPosition();
          writeBlock(gPlaneModal.format(18), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(getModulus(x, y)), cOutput.format(c), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
          return;
        }
      
      break;
	  case PLANE_YZ:
      if (!isSpiral()) {
        var c = getCClosest(x, y, cOutput.getCurrent());
        if (!cFormat.areDifferent(c, cOutput.getCurrent())) {
          validate(getCircularSweep() < Math.PI, localize("Circular sweep exceeds limit."));
          var start = getCurrentPosition();
          writeBlock(gMotionModal.format(clockwise ? 2 : 3), xOutput.format(getModulus(x, y)), cOutput.format(c), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
          return;
        }
      } else if (isFullCircle()){
		   var c = getCClosest(x, y, cOutput.getCurrent());
        if (!cFormat.areDifferent(c, cOutput.getCurrent())) {
          validate(getCircularSweep() < Math.PI, localize("Circular sweep exceeds limit."));
          var start = getCurrentPosition();
          writeBlock(gMotionModal.format(clockwise ? 2 : 3), xOutput.format(getModulus(x, y)), cOutput.format(c), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
          return;
        }
	  }
      break;
    }
    
    linearize(getTolerance());
    return;
  } */

  if (isSpeedFeedSynchronizationActive()) {
    error(localize("Speed-feed synchronization is not supported for circular moves."));
    return;
  }
  
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for a circular move."));
    return;
  }

  var start = getCurrentPosition();

  if (isFullCircle()) {
    if (properties.useRadius || isHelical()) { // radius mode does not support full arcs
      linearize(tolerance);
      return;
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gPlaneModal.format(17), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
      break;
    case PLANE_ZX:
       if (usePolarMode) {
        linearize(tolerance);
        return;
      }
      writeBlock(gPlaneModal.format(18), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    case PLANE_YZ:
      if (usePolarMode) {
        linearize(tolerance);
        return;
      }
      writeBlock(gMotionModal.format(clockwise ? 2 : 3), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else if (!properties.useRadius) {
    if (isHelical() && ((getCircularSweep() < toRad(30)) || (getHelicalPitch() > 10))) { // avoid G112 issue
      linearize(tolerance);
      return;
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      if (!xFormat.isSignificant(start.x) && usePolarMode) {
        writeBlock(gMotionModal.format(1), xOutput.format((unit == IN) ? 0.0001 : 0.001), getFeed(feed)); // move X to non zero to avoid G112 issues
      }
      writeBlock(gPlaneModal.format(17), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
      break;
    case PLANE_ZX:
      if (usePolarMode) {
        linearize(tolerance);
        return;
      }
      writeBlock(gPlaneModal.format(18), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    case PLANE_YZ:
      if (usePolarMode) {
        linearize(tolerance);
        return;
      }
      writeBlock(gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else { // use radius mode
    if (isHelical() && ((getCircularSweep() < toRad(30)) || (getHelicalPitch() > 10))) {
      linearize(tolerance);
      return;
    }
    var r = getCircularRadius();
    if (toDeg(getCircularSweep()) > (180 + 1e-9)) {
      r = -r; // allow up to <360 deg arcs
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      if ((spatialFormat.format(start.x) == 0) && usePolarMode) {
        writeBlock(gMotionModal.format(1), xOutput.format((unit == IN) ? 0.0001 : 0.001), getFeed(feed)); // move X to non zero to avoid G112 issues
      }
      writeBlock(gPlaneModal.format(17), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_ZX:
      if (usePolarMode) {
        linearize(tolerance);
        return;
      }
      writeBlock(gPlaneModal.format(18), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_YZ:
      if (usePolarMode) {
        linearize(tolerance);
        return;
      }
      writeBlock(gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  }
}

function onCycle() {
  switch (cycleType) {
  case "stock-transfer":
    var transferAdjusted = (cycle.eject + cycle.transferZ);
    // will use this for bar puller
    writeBlock(mFormat.format(5), mFormat.format(9));
    writeBlock(gMotionModal.format(1), zOutput.format(cycle.transferZ), feedOutput.format(350));
    writeBlock(gFormat.format(4), kFormat.format(50), mFormat.format(11));
    writeBlock(gMotionModal.format(1), zOutput.format(transferAdjusted), feedOutput.format(200));
    writeBlock(gFormat.format(4), kFormat.format(50), mFormat.format(10)); // OPEN AND  WAIT HALF SEC BEFORE MOVING
    writeBlock(gFormat.format(4), kFormat.format(50));
    return;
  }
}


function getCommonCycle(x, y, z, r) {
  // forceXYZ(); // force xyz on first drill hole of any cycle
  if (useXZCMode) {
    cOutput.reset();
    return [xOutput.format(getModulus(x, y)), cOutput.format(getCClosest(x, y, cOutput.getCurrent())),
      zOutput.format(z),
      (r !== undefined) ? ("R" + spatialFormat.format((gPlaneModal.getCurrent() == 19) ? r*2 : r)) : ""];
  } else {
    return [xOutput.format(x), yOutput.format(y),
      zOutput.format(z),
      (r !== undefined) ? ("R" + spatialFormat.format((gPlaneModal.getCurrent() == 19) ? r*2 : r)) : ""];
  }
}

function onCyclePoint(x, y, z) {
  if (isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1)) ||
      isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, -1))) {
    // writeBlock(gPlaneModal.format(17)); // XY plane
  } else if (Vector.dot(currentSection.workPlane.forward, new Vector(0, 0, 1)) < 1e-7) {
    // writeBlock(gPlaneModal.format(19)); // YZ plane
  } else {
    expandCyclePoint(x, y, z);
    return;
  }

  // THREADING PROGRAM ============================================================================

  switch (cycleType) {
  case "thread-turning":
    if (alreadyInThreadingCycle) {
      return;
    }
    alreadyInThreadingCycle = true;

    // INITIAL POSITION -----------------------------------------------------------------

    var pos = currentSection.getFirstPosition();
    if (pos) {
      writeln(xOutput.format(pos.x));
      writeln(zOutput.format(pos.z));
    }
    // EXTERNAL / INTERNAL THREAD LOGIC -------------------------------------------------

    var external;
    if (getParameter("operation:machineInside") == 0) {
      external = true;
    } else {
      external = false;
    }
    var threadHeight = external ? getParameter("operation:surfaceZHigh") : getParameter("operation:surfaceZHigh");
    var threadDepth = external ? getParameter("operation:threadDepth") : -getParameter("operation:threadDepth");
    var dVal = external ? getParameter("operation:retractHeightOffset") : getParameter("operation:retractHeightOffset");

    // LEFT RIGHT THREAD LOGIC (SEE SPINDLE DIRECTION CODE FOR M4 COMMAND)---------------

    // SET UP
    // RIGHT HAND (RH) THREAD WILL CUT ON +X SIDE OF STOCK WITH SPINDLE IN M3 ROTATION
    // LEFT HAND (LT) THREAD WILL CUT ON -X SIDE OF STOCK WITH SPINDLE IN M4 ROTATION
    // BOTH RT AND LT TOOLS WILL TRAVEL IN -Z DIRECTION

    if (currentSection.getParameter("operation:threadingHand") == "right") {
      var tTravel = (-Math.abs(z) - getParameter("operation:stockOffsetFront")); // RH THREAD TRAVEL
    } else {
      var tTravel = -Math.abs(cycle.incrementalZ); // LH THREAD TRAVEL (HAND INPUT **MAKE SURE FRONTSIDE OFFSET IS 0**)
    }

    if (currentSection.getParameter("operation:threadingHand") == "left") { // FLIP TOOLS TO CUT NEGATIVE SIDE OF STOCK LH TO RH / RH TO LH
      var threadmajordia = -Math.abs(threadHeight * 2); // -X SIDE (LH)
    } else {
      var threadmajordia = threadHeight * 2; // +X SIDE (RH)
    }

    // VARIABLE CALCS -------------------------------------------------------------------

    var r = -cycle.incrementalX; // positive if taper goes down - delta radius
    var threadsPerInch = 1.0 / cycle.pitch; // per mm for metric
    var c = 1 / threadsPerInch;
    var numPasses = getParameter("operation:numberOfStepdowns");
    var bVal = -Math.abs(threadDepth / numPasses);
    var zVal = getParameter("operation:stockOffsetFront");
    var jVal = (0);

    if (properties.debugOutput) {
      writeln("p= " + p);
      writeln("driveline= " + driveLine);
      writeln("threadHeight= " + threadHeight);
      writeln("threadDepth= " + threadDepth);
    }

    // OUTPUT BLOCK ---------------------------------------------------------------------

    writeBlock(gMotionModal.format(86),
      xThreadOutput.format(threadmajordia), //MAJOR DIA OF THREAD
      zThreadOutput.format(zVal), //START POINT OF Z-AXIS
      qThreadOutput.format(threadHeight * 2), //HARD CODED MAJOR DIA AT END OF THREAD
      rThreadOutput.format(tTravel), //THREAD LENGTH
      iThreadOutput.format(threadDepth), //TOTAL DEPTH
      bThreadOutput.format(bVal), //FIRST PASS DEPTH
      dThreadOutput.format(dVal), //SAFETY DISTANCE FOR X
      lThreadOutput.format(0.0001), //HARD CODED FOR ONE SPRING PASS
      cThreadOutput.format(c), //PITCH
      jThreadOutput.format(jVal), //END POINT EXTENSION OF Z-AXIS **HAND INPUT**
      aThreadOutput.format(29)); //HARD CODED TOOL ANGLE
    return;
  }

  // END THREADING PROGRAM =========================================================================

  if (true || isFirstCyclePoint()) {
    /*
    switch (gPlaneModal.getCurrent()) {
    case 17:
      writeBlock(gMotionModal.format(0), zOutput.format(cycle.clearance));
      break;
    case 18:
      writeBlock(gMotionModal.format(0), yOutput.format(cycle.clearance));
      break;
    case 19:
      writeBlock(gMotionModal.format(0), xOutput.format(cycle.clearance));
      break;
    default:
      error(localize("Unsupported drilling orientation."));
      return;
    }
*/
    repositionToCycleClearance(cycle, x, y, z);
    // return to initial Z which is clearance plane and set absolute mode

    var F = cycle.feedrate;
    var K = (cycle.dwell == 0) ? 0 : clamp(1, cycle.dwell * 1000, 99999999); // in milliseconds

    switch (cycleType) {
    case "drilling":
      expandCyclePoint(x, y, z);
      break;
    case "counter-boring":
      expandCyclePoint(x, y, z);
      break;
    case "chip-breaking":
      expandCyclePoint(x, y, z);
      break;
    case "deep-drilling":
      expandCyclePoint(x, y, z);
      // DRILL CYCLE GOES HERE
      break;
    case "tapping":
      expandCyclePoint(x, y, z);
      // if (!F) {
        // F = tool.getTappingFeedrate();
      // }
      // writeBlock(mFormat.format(29), sOutput.format(tool.spindleRPM));
      // writeBlock(
        // (properties.type == "A") ? "" : gRetractModal.format(98), conditional(properties.type != "A", gAbsIncModal.format(90)), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND) ? 74 : 84),
        // getCommonCycle(x, y, z, cycle.retract),
        // "K" + milliFormat.format(K),
        // feedOutput.format(F));
      break;
    case "left-tapping":
      // if (!F) {
        // F = tool.getTappingFeedrate();
      // }
      // writeBlock(mFormat.format(29), sOutput.format(tool.spindleRPM));
      // writeBlock(
        // (properties.type == "A") ? "" : gRetractModal.format(98), conditional(properties.type != "A", gAbsIncModal.format(90)), gCycleModal.format(74),
        // getCommonCycle(x, y, z, cycle.retract),
        // "K" + milliFormat.format(K),
        // feedOutput.format(F));
      break;
    case "right-tapping":
      // if (!F) {
        // F = tool.getTappingFeedrate();
      // }
      // writeBlock(mFormat.format(29), sOutput.format(tool.spindleRPM));
      // writeBlock(
        // (properties.type == "A") ? "" : gRetractModal.format(98), conditional(properties.type != "A", gAbsIncModal.format(90)), gCycleModal.format(84),
        // getCommonCycle(x, y, z, cycle.retract),
        // "K" + milliFormat.format(K),
        // feedOutput.format(F));
      break;
    case "tapping-with-chip-breaking":
    case "left-tapping-with-chip-breaking":
    case "right-tapping-with-chip-breaking":
      // if (!F) {
        // F = tool.getTappingFeedrate();
      // }
      // writeBlock(mFormat.format(29), sOutput.format(tool.spindleRPM));
      // writeBlock(
        // (properties.type == "A") ? "" : gRetractModal.format(98), conditional(properties.type != "A", gAbsIncModal.format(90)), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84)),
        // getCommonCycle(x, y, z, cycle.retract),
        // "K" + milliFormat.format(K),
        // "Q" + xFormat.format(cycle.incrementalDepth),
        // feedOutput.format(F));
      break;
    case "fine-boring":
      expandCyclePoint(x, y, z);
      break;
    case "reaming":
      expandCyclePoint(x, y, z);
      break;
    case "stop-boring":
      expandCyclePoint(x, y, z);
      break;
    case "boring":
      expandCyclePoint(x, y, z);
      break;
    default:
      expandCyclePoint(x, y, z);
    }
  } else {
    if (cycleExpanded) {
      expandCyclePoint(x, y, z);
    } else if (useXZCMode) {
      var _x = xOutput.format(getModulus(x, y));
      var _c = cOutput.format(getC(x, y));
      if (!_x /*&& !_y*/ && !_c) {
        xOutput.reset(); // at least one axis is required
        _x = xOutput.format(getModulus(x, y));
      }
      writeBlock(_x, _c);
    } else {
      var _x = xOutput.format(x);
      var _y = yOutput.format(y);
      var _z = zOutput.format(z);
      if (!_x && !_y && !_z) {
        switch (gPlaneModal.getCurrent()) {
        case 17: // XY
          xOutput.reset(); // at least one axis is required
          _x = xOutput.format(x);
          break;
        case 18: // ZX
          zOutput.reset(); // at least one axis is required
          _z = zOutput.format(z);
          break;
        case 19: // YZ
          yOutput.reset(); // at least one axis is required
          _y = yOutput.format(y);
          break;
        }
      }
      writeBlock(_x, _y, _z);
    }
  }
}

function onCycleEnd() {
  if (!cycleExpanded) {
    switch (cycleType) {
    case "thread-turning":
      alreadyInThreadingCycle = false;
      forceFeed();
      xOutput.reset();
      zOutput.reset();
      g92ROutput.reset();
      break;
    default:
      //  writeBlock(gCycleModal.format(80));
    }
  }
}

function onPassThrough(text) {
  writeBlock(text);
}

function onParameter(name, value) {
}

var currentCoolantMode = COOLANT_OFF;

function setCoolant(coolant) {
  if (coolant == currentCoolantMode) {
    return; // coolant is already active
  }

  var m = undefined;
  if (coolant == COOLANT_OFF) {
    writeBlock(mFormat.format((currentCoolantMode == COOLANT_THROUGH_TOOL) ? 89 : 9));
    currentCoolantMode = COOLANT_OFF;
    return;
  }

  switch (coolant) {
  case COOLANT_FLOOD:
    m = 8;
    break;
  case COOLANT_THROUGH_TOOL:
    m = 88;
    break;
  default:
    onUnsupportedCoolant(coolant);
    m = 9;
  }

  if (m) {
    writeBlock(mFormat.format(m));
    currentCoolantMode = coolant;
  }
}

function onCommand(command) {
  switch (command) {
  case COMMAND_COOLANT_OFF:
    setCoolant(COOLANT_OFF);
    break;
  case COMMAND_COOLANT_ON:
    setCoolant(COOLANT_FLOOD);
    break;
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
    break;
  case COMMAND_OPTIONAL_STOP:
    writeBlock(mFormat.format(1));
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
      writeBlock(mFormat.format(50));
      break;
    }
    break;
  case COMMAND_SPINDLE_COUNTERCLOCKWISE:
    switch (currentSection.spindle) {
    case SPINDLE_PRIMARY:
      writeBlock(mFormat.format(4));
      break;
    case SPINDLE_SECONDARY:
      writeBlock(mFormat.format(50));
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
      writeBlock(mFormat.format(50));
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
  default:
    onUnsupportedCommand(command);
  }
}

function engagePartCatcher(engage) {

  if (properties.gotPartCatcher &&
      hasParameter("operation-strategy") &&
      (getParameter("operation-strategy") == "turningPart") &&
      currentSection.partCatcher) {
    if (engage) {
      // catch part here
      writeBlock(mFormat.format(90));
    } else {
      writeBlock(mFormat.format(91));
      forceXYZ();
    }
  }
}

function onSectionEnd() {
  forceAny();
  if (properties.gotPartCatcher) {
    engagePartCatcher(false);
  }
  
  if (usePolarMode) {
    setPolarMode(false); // disable polar interpolation mode
  }
  if (currentSection.getType() == TYPE_MILLING) {
	  if (properties.LiveToolM51 ==true){
		writeBlock(mFormat.format(50));
	  }else {
		writeBlock(mFormat.format(45), "S0");
  }
  }
}

function onClose() {
  writeln("");

  optionalSection = false;

  onCommand(COMMAND_COOLANT_OFF);

  // we might want to retract in Z before X
  // writeBlock(gFormat.format(28), "U" + xFormat.format(0)); // retract

  forceXYZ();
  writeBlock(gFormat.format(53), gMotionModal.format(0), zOutput.format(0)); // retract Z
  writeBlock(gFormat.format(95));
  onImpliedCommand(COMMAND_END);
  onImpliedCommand(COMMAND_STOP_SPINDLE);
  writeBlock(mFormat.format(30)); // stop program, spindle stop, coolant off
  writeln("%");
}
