// Copyright Epic Games, Inc. All Rights Reserved.

#include "WatertopiaGameMode.h"
#include "WatertopiaCharacter.h"
#include "UObject/ConstructorHelpers.h"

AWatertopiaGameMode::AWatertopiaGameMode()
{
	// set default pawn class to our Blueprinted character
	static ConstructorHelpers::FClassFinder<APawn> PlayerPawnBPClass(TEXT("/Game/ThirdPerson/Blueprints/BP_ThirdPersonCharacter"));
	if (PlayerPawnBPClass.Class != NULL)
	{
		DefaultPawnClass = PlayerPawnBPClass.Class;
	}
}
