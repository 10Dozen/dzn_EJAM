#include "macro.hpp"

PREP(main,fnc_initPlayer);
PREP(main,fnc_firedEH);
PREP(main,fnc_reloadedEH);

PREP(main,fnc_getMappingData);
PREP(main,fnc_processMappingData);
PREP(main,fnc_getEnumText);
PREP(main,fnc_getClassFamily);
PREP(main,fnc_isInVehicleCrew);

PREP(main,fnc_checkJammed);
PREP(main,fnc_getJamCause);

PREP(main,fnc_setJammed);
PREP(main,fnc_setUnjammed);
PREP(main,fnc_processWeaponFixed);
PREP(main,fnc_wasteRound);

PREP(main,fnc_setWeaponState);
PREP(main,fnc_getWeaponState);
PREP(main,fnc_calculateStateOnBoltOpen);
PREP(main,fnc_calculateStateOnBoltPull);
PREP(main,fnc_isMagAttached);
PREP(main,fnc_hasMagazine);

PREP(interact,fnc_addACEAction);
PREP(interact,fnc_inspectWeapon);
PREP(interact,fnc_doAction);
PREP(interact,fnc_doHotkeyAction);
PREP(interact,fnc_playActionSound);
PREP(interact,fnc_operateBolt);
PREP(interact,fnc_manageMagazine);

PREP(ui,fnc_uiShowUnjamMenu);
PREP(ui,fnc_uiShowBriefState);
PREP(ui,fnc_uiShowProgressBar);
PREP(ui,fnc_uiShowConfig);

GVAR(Configure) = { [] spawn FUNC(uiShowConfig); };
