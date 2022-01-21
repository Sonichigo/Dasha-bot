context
{
  input endpoint: string;
}

start node Root
{
  do
  {
    #connect($endpoint);
    #sayText("Hello! My name is Dasha! Can you hear me?.");
    wait *;
  }

  transitions
  {
    Can_hear_you: goto Can_hear_you on true;
  }
}

node Can_hear_you {
  do
  {
    #sayText("Great! Let's get started.");
    wait *;
  }

  transitions
  {
    next: goto Next on true;
  }
}

node Next {
  do
  {
    #sayText("You said " + #getMessageText());
    wait *;
  }

  transitions
  {
    next: goto Next on true;
    bye_bye: goto bye_bye on false;
  }
}

node bye_bye {
    do {
        #sayText("No worries mate.Let's connect sometime else Cheers!");
        #disconnect();
        exit;
    }
}

digression bye {
    conditions { on true tags: onclosed; }
    do {
        #sayText("Thanks for your call. Have a nice day. Bye!");
        exit;
    }
}