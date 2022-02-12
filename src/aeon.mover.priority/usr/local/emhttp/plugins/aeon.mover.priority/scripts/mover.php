#!/usr/bin/php
<?
require_once("/usr/local/emhttp/plugins/dynamix/include/Wrappers.php");


$vars = @parse_ini_file("/var/local/emhttp/var.ini");
$cfg = parse_plugin_cfg("aeon.mover.priority");
$cfgLogger = ($cfg["logging"] ?: "no") == "yes";

function logger($value) {
	global $cfgLogger;

	if (!$cfgLogger) {
		return;
	}

	exec("logger aeon.mover.priority :: " . escapeshellarg($value));
}

function startMover($options = "") {
	global $cfg;

	$moverOld = "/usr/local/sbin/mover.old";
	$cpuPriority = $cfg["cpuPriority"] ?: "0";
	$ioPriority = $cfg["ioPriority"] ?: "-c 2 -n 0";

	// Original mover script has:
	// - start
	// - stop
	// - status

	if ($options == "stop") {
		passthru("$moverOld stop");
		return;
	}

	if ($options == "status") {
		passthru("$moverOld status");
		return;
	}
	
	$command = "ionice $ioPriority nice -n $cpuPriority $moverOld";

	logger($command);
	passthru($command);
}

logger("Starting");

if ($argv[2]) {
	startMover(trim($argv[2]));
} else {
	startMover();
}

logger("Finished");

?>
