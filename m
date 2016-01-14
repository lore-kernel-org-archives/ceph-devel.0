From: John Spray <jspray@redhat.com>
Subject: Re: Ideas for new ceph-mgr service
Date: Thu, 14 Jan 2016 11:01:55 +0000
Message-ID: <CALe9h7esJCGynYreJvcjjM5qxBFV6Bn+yBcfsn127FQr0cb4dg@mail.gmail.com>
References: <CALe9h7f-AaBxcNU=25dmYUxbZe9RhJwxvBTRyc5qVxzTjSCMrw@mail.gmail.com>
 <156637337.14721161.1452700430079.JavaMail.zimbra@redhat.com>
 <CALe9h7fm_r2a8p7BMYscr+Ba09X_ZMQsQcA+2QwPdkpAYCVZFg@mail.gmail.com>
 <56969124.4040604@redhat.com> <20160114044930.GB25708@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36716 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbcANLCQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jan 2016 06:02:16 -0500
Received: by mail-qk0-f175.google.com with SMTP id q19so235352609qke.3
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jan 2016 03:02:15 -0800 (PST)
In-Reply-To: <20160114044930.GB25708@degu.b.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jan 14, 2016 at 4:49 AM, Marcus Watts <mwatts@redhat.com> wrote:
> On Wed, Jan 13, 2016 at 12:02:12PM -0600, Mark Nelson wrote:
> Various wrote:
> ...
>> >>>We currently have an unfulfilled need for a high level
>> >>>management/monitoring service that can take some of the non-essential
> ...
>> >>>So, the idea is to create a new lightweight service (ceph-mgr) that
>> >>>runs alongside the mon, and uses the existing Ceph network channels to
>> >>>talk to remote hosts.  The address of this service would be published
> ...
>
> I think I'm going to take this in a slightly different direction.
> [ ie, "blue sky" warning. ]

OK, duly warned!

> What was described up there (ceph-mgr) is pretty much an "admin" server.
> Which is a nice idea.  But, -- well, I think what you've described is
> pretty much a web server running python, except maybe you've got a weird
> transport instead of http?  (and some local cached data...)

It's primarily a service for holding onto live stats and metadata
about the cluster, and providing an execution environment for code
that wants to use all that data, either for monitoring or for doing
interesting cluster-wide management operations.

Then it loads a module that just happens to be a python web server.

> I think there are a variety of things ceph-mon does that it shouldn't,
> and some things it doesn't do that maybe it shouldn't, but something should.
>
> So some things ceph-mon doesn't do: start/stop ceph services.
> Why this is useful: better integration, control of when services
> start and stop, ability to migrate services between machines depending
> on load or other factors.

That's a useful thing to bring up.  Starting/stopping services is
actually a line that I actively don't want to cross: anything that
requires SSHing out into the host environment should IMHO be separate
to the things that we can do within the Ceph cluster.  Service
management is something for general purpose management tools.

> Things ceph-mon does that it *should* do: location service/broker.
> Where are things running?  This is the "fixed point" that you have
> to advertise in ceph.conf, because you have to start somewhere.
> Once you can locate everything elsewhere, you no longer have to run
> it all in the mon.
>
> ceph-mon provides consensus data services, and a variety of databases
> on top of that.  This doesn't necessarily need to be the same set
> of machines or service that does location brokering, and it might
> be useful to move different databases to different sets of machines.
> It may also be useful to separate one database into subsets that
> get managed by different machines.  Also it should be separate from
> the next bit.

These are fair points about designing a more scale-out-able mon
cluster, but I think this is a pretty long way apart from the concept
of adding a layer on top of the mon cluster for management/monitoring.

> I think this is the part that's actually already been discussed,
> but:
> ceph-mon provides an "exec" environment.  They all get "argv",and
> they produce "stdout" and "stderr" output.  And there are a bunch
> of canned apps.  It would be nice to de-couple argument parsing and
> stdout/stderr output from the actual operation logic.

Strictly speaking they actually get a dict of arguments that
ceph_argparse.py composes by interpreting an argv and mapping it to a
command from MonCommands.h.  That mapping of a command line into a
named command and set of named arguments is already happening in the
python cli.

What I envision is using the existing mon commands as the low level
primitives for friendlier interfaces layered on top.  The classic
example of this is increasing the number of PGs in a pool.  We have
the mon commands for setting pg_num, setting pgp_num, and querying
whether the pg creation is complete.  On top of that, one needs a
friendlier command that knows how to iterate through that process in
chunks of N pgs at a time.  Calamari's management stuff never got very
far, but that was one of the neat things that it was capable of.

Supporting long-running operations generally is important to me.
Spitting commands at a mon cluster is already a fully solved problem,
which could be cleaner but basically works.  The interesting (new)
thing is making higher level operations, like "scrub this OSD and
complete when we've scrubbed all those PGs" or "mark this OSD out and
complete when all the data has migrated away".  The kind of thing
where someone writing a UI would naturally put a progress bar on it.

> So the seperation I would try to have is;
>         1/ lowlevel "fixed" logic, as C++, providing a variety of
>         simpler operations or where operation speed or consistency
>         matters.
>         2/ mid-level "programmarable" logic, perhaps as python
>         where it can be threaded/operation speed doesn't matter.
>         Eats and produces binary structures, perhaps json, or not.
>         Runs with "system privileges".
>         Also provide ability (*new*) - to add additional scripts,
>         and to provide for periodic scheduled internal operations
>         ("cron".)
>         Operations at this layer may not correspond exactly to user commands.
>                 If you want C++ -- how about a plugin shared-object
>                 architecture for this bit?
>         3/ high-level "outer" logic.  runs on end-user user machines
>         with user privileges (which might not be trustable.)  Might parse
>         arg lines, might be a menu, cgi applet, might produce text output,
>         xml, json, or html.  Might in some cases execute
>         multiple operations in response to one user request.

So my vision is that in the above list:
 (1) is the existing ceph-mon
 (2) is ceph-mgr
 (3) is outside consumers of our APIs

For the moment, I'd still have the Ceph CLI pointing straight at (1)
for all the commands that it already has.  It could also learn to talk
to (2) for newly added functionality, but I wouldn't want to convert
it all over and pass commands through ceph-mgr just for the heck of
it.

I'm not about re-implementing the entire existing command set.  I'm
interested in creating a place where we can add new, higher level
functionality.  That might create a situation where a CLI would talk
to one interface for some operations, and another interface for
others, but I think that is the price of incremental improvement
rather than trying to do a big bang redesign of the existing stuff.

> The consensus and "exec" mechanisms in ceph today are kind of
> conmingled, and each consensus database has its own specific list
> of data.  Separating it could be icky, but I think there's a win.

I'm not sure they really are that commingled.  The mon is pretty
clearly structured into the generic paxos parts, and the specific
subsystem message handling.  The code could be cleaner (it would be
nice to avoid the massive if() blocks) but there is already a clear
separation between message handling and the consensus mechanisms.

> One goal in this should to avoid a "firehouse" concentration
> of too much stuff in any one place.  Ie, should allow for as
> much parallelism as possible, and to require the least degree of
> serialization or exclusion.

To some extent there will always be a (logical) firehose, even if we
shard the (physical) firehose across multiple nodes.  For example, if
we shard the nonessential PG stats updates from OSDs across multiple
ceph-mgr instances, we'll still at some point need a way to merge them
back together to do health reporting.  The first, simplest victory
would be to move them out of the mon: parallelising that their
handling more would be a further improvement.

John
