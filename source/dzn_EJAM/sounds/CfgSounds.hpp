// Was 1,1

#define SOUND_CLASS(X,Y)	class X { \
	sound[] = {Y, db+10, 1}; \
	name = ""; \
	titles[] = {0, ""}; \
}

#include "..\macro.hpp"

class CfgSounds
{
	sounds[] = {};
	SOUND_CLASS(open_bolt, SND(BoltOpen.ogg));
	SOUND_CLASS(pull_bolt, SND(BoltPull.ogg));
	SOUND_CLASS(attach_mag, SND(MagAttach.ogg));
	SOUND_CLASS(detach_mag, SND(MagDetach.ogg));
	SOUND_CLASS(clear_chamber, SND(Fixing.ogg));
	SOUND_CLASS(remove_case, SND(Fixing.ogg));
	SOUND_CLASS(drop_mag, SND(MagDrop.ogg));
};
