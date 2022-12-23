context
{
  input endpoint: string;
}

start node Root
{
  do
  {
    #connect($endpoint);
    #waitForSpeech(1000);
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
    #sayText("Awesome!! Shall we get started?");
    wait *;
  }

  transitions
  {
    yes: goto Yes on true;
  }
}

node Yes {
  do
  {
    #sayText("Great! I'll record the talk!!.");
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
    #waitForSpeech(1000);
    #sayText(#getMessageText());
    wait *;
  }

  transitions
  {
    next: goto Next on #messageHasIntent("repeat");
    bye_bye: goto bye_bye on #messageHasIntent("bye");
  }
}

node bye_bye {
    do {
        #waitForSpeech(1000);
        #sayText("No worries mate. Let's connect sometime else. Cheers!");
        #disconnect();
        exit;
    }
}

digression hangup {
    conditions { 
      on true tags: onclosed; 
      }
    do {
        #sayText("Thanks for your call. Have a nice day. Bye!");
        exit;
    }
}