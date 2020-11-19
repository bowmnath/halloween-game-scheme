# Halloween-Game Simulator in Scheme

This is a simulator for Zork, the CIS 343 Halloween game, written in Scheme.
It is a simulator because it does not accept user input. It accepts a
predefined list of moves and shows how the game would have played out.

I wrote it for practice, but I thought the students might be interested in
seeing a larger functional program.

## Running Simulator

The game instance to run is set up in `instance.scm`. To watch a simulation
play out, simply run

```
mit-scheme --quiet < instance.scm
```

Because the game is randomly generated, you will see different outcomes each
time. The preset game in `instance.scm` fairly regularly shows wins, losses,
and cancellation due to illegal moves.

## Functional Style

Do not necessarily take this as a great example of how to structure functional
code. I am new to functional programming, and it probably shows. In particular,
I thought it would be fun to make practically *everything* a function, even
when using a list may have been simpler. Also, I latched on to the first
example I found for printing output, so there may be a better way.

The code did look a little bit nicer in a few places before I added output.
You can look at commit `e02f21b6` to see the differences. In particular, I
added getters to Monster and Player that are not strictly necessary to simulate
the game.

In terms of actual coding style, this is a "do as I say, not as I do"
situation.  I would expect much better commenting on any code that was
submitted in CIS 343 (or anywhere).

## Background

In Winter 2020 (and previous semesters), CIS 343 at GVSU had a project to
create a particular Halloween game called Zork. There were very slight
variations in Winter 2020, but the original assignment can be found at:

https://github.com/irawoodring/343/blob/master/assignments/zork.md

The purpose of the game was to practice object-oriented programming. Later in
the course, the students learned about functional programming through Scheme --
specifically, `mit-scheme`. I wanted to practice functional programming on a
slightly larger project than the ten-or-so-line functions we typically write in
the course, so I wrote Zork in Scheme.

## License

This code is released under the MIT License. Please hack away and enjoy. If
anyone makes the game interactive, I would love to see it! I'll gladly post a
link here or accept a pull request.

## Bugs

I did not test this thoroughly at all, so there are no doubt bugs lurking. I am
not going to spend a lot of development time on this, but, if you see something
egregious, feel free to point it out.
