From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: SimpleMessenger testing plan
Date: Tue, 14 Feb 2012 18:19:15 -0800
Message-ID: <CAF3hT9D90uSqXLtziGeLmgKgPiSS=0z95toT9yo3oRAB5U=4QQ@mail.gmail.com>
References: <CAF3hT9Co8J-RU1_dn9ATi8AtzxBEG+ggcwjrgPVrzDg1kGqn3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47270 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757499Ab2BOCTQ convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Feb 2012 21:19:16 -0500
Received: by obcva7 with SMTP id va7so802352obc.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 18:19:16 -0800 (PST)
In-Reply-To: <CAF3hT9Co8J-RU1_dn9ATi8AtzxBEG+ggcwjrgPVrzDg1kGqn3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In our meeting today we decided a rule syntax was too complicated, and
we should just have a separate "TestDriver" for any tests we care to
write, with a function based interface to the MessengerDriver. TV
asked me to look at libfiu again so we don't need to add wrappers at
every syscall site; look for an email on that sometime this week
(probably Friday).

To make everything more transparent, our states will be recorded more
precisely as debug_state.set_state(module, state) where state is
delimited by '/' rather than '::'.

I'll probably start work on this Friday.
-Greg

On Tue, Feb 14, 2012 at 1:17 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> We on the team decided a while ago that it's past time to start
> looking seriously at how we can do proper testing of more of our core
> components without spinning up a full Ceph instance. We've been tryin=
g
> to sneak it in as we can on new features and modules, but after some
> recent experiences debugging and fixing the SimpleMessenger I got
> tasked with looking at how we can implement proper module tests for
> it. I did so yesterday and came up with a design outline that I'd lik=
e
> to start working on when the team gets back from FAST. We will be
> meeting about it as a group later and I welcome any input from the
> list over the next couple of days! :)
>
> First, we need to decide on the approach we want to take to running
> these tests. Sage suggested that we might want to spin up a bunch of
> Messengers and run them through a workload while randomly failing
> their network operations some random fraction of the time. This
> doesn't satisfy me for two reasons. First, I like to *know* that
> certain scenarios have been tested, which is difficult to check with
> random failure injection; second, I want to be able to check the
> post-failure state of the system to make sure that we haven't leaked
> resources or otherwise failed non-catastrophically. Given that, we
> need to define a testing framework with very fine-grained control ove=
r
> when failures are injected.
>
> My design consists of two parts. One is a mechanism for incrementally
> designating the state of the SimpleMessenger; the second is a system
> for testing based on this state, syscall fault injection, and
> purpose-written testing scripts.
> The interface for the state designator is simple:
> debug_state.set_state("Accepter::accepting"). We want it to be
> extensible so that you can start off with simple brackets and then
> move on to deeper levels like
> "Accepter::accepting::waiting"->"Accepter::accepting::reading_other_a=
ddr",
> etc. And to allow states for more than one module =97 allowing the
> SimpleMessenger to store the state of the Accepter as well as the
> state for the Dispatcher, etc. This suggests to me a pretty simple
> implementation where we grab out the first word of the state as the
> module (Accepter, Dispatcher) and look those up in a map, then use th=
e
> rest of the state as part of a recursing struct so it can nest
> arbitrarily. We have an instance as part of each Messenger and as par=
t
> of each Pipe and insert set_state calls through the SimpleMessenger
> code as we decide we care about them.
>
> The system for testing is broken into two big pieces. One is a
> MessengerDriver, which acts as the client for a single SimpleMessenge=
r
> instance. The DebugState has hooks to notify the MessengerDriver on
> state changes, and we will instrument the SimpleMessenger's syscalls
> to pass through the MessengerDriver (using either macros or pluggable
> objects) so it can inject failures on demand.
> The second piece is a TestDriver, which creates MessengerDriver
> objects and is responsible for feeding them test orders on how to
> behave. This interface can start off pretty simply, eg as simple
> hard-coded arrays of tests to run, but I expect it to evolve, perhaps
> to the point where we can programmatically generate complicated
> many-to-many tests in Python.
> The interface between the TestDriver and the MessengerDriver should b=
e
> pretty simple, consisting largely of the function
> test_orders(vector<string>& ops).
> Test orders are lists of strings(for now. Better later). These string=
s
> can be things like:
> connect <ip>: initiate a connect attempt to the given IP
> send <message> <ip>: start sending the given message to the given IP
> wait <module> <n> <state>: wait until you've seen the given state n
> times in the given module
> fail <module> <function> <error code>: the next time the given module
> calls the given syscall function, return the given error code
> shutdown: destroy the attached SimpleMessenger and return.
> These can be expanded later to do fancier things like: (these example=
s
> allow even more precise cross-Messenger synchronization)
> block <cond> <module> <function>, block <cond> <module> <state> : the
> next time <module> calls <function>/reaches <state>, block on <cond>
> signal <cond> <module> <function>, signal <cond> <module> <state>: th=
e
> next time <module> calls <function>/reaches <state>, notify <cond>
>
> Then the MessengerDriver will run through the given operations until
> it runs out, and then when its code next executes it will block while
> waiting for more instructions to come in via test_orders().
>
> Because the MessengerDriver will be called into on every state change
> and on every syscall, simple instructions like this let us write very
> powerful, precisely-timed tests with a fairly small set of
> instructions to interpret.
>
> I'm not terribly interested in replacing the networking stack =97=A0d=
oing
> so would require writing our own routing code and I don't see much
> benefit to it in terms of testability. Perhaps even a negative, in
> that by going through the normal networking paths we will hit more of
> TCP's bizarre behavior patterns (not all of them, obviously, since
> we're all in a single process on a single machine, but more).
> We will also need some glue to do things like pass bound IP addresses
> around, etc, but I don't see that being important or difficult in
> terms of the interfaces described.
>
> Thoughts? Obvious points I've failed to consider?
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
