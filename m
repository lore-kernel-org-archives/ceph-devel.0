From: Sage Weil <sage@newdream.net>
Subject: Re: config on mons
Date: Wed, 15 Nov 2017 13:32:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711151318370.28240@piezo.novalocal>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal> <alpine.DEB.2.11.1711142208490.28240@piezo.novalocal> <CALe9h7ciU3ajzPTkh1iCC=+qdEdHbt3n97NCgQDgsML6cLUS2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:50645 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbdKONc6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Nov 2017 08:32:58 -0500
In-Reply-To: <CALe9h7ciU3ajzPTkh1iCC=+qdEdHbt3n97NCgQDgsML6cLUS2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 14 Nov 2017, John Spray wrote:
> On Tue, Nov 14, 2017 at 10:21 PM, Sage Weil <sage@newdream.net> wrote:
> > I've updated the pad at
> >
> >         http://pad.ceph.com/p/config
> >
> > After thinking about this a bit more, I think we may need to abandon the
> > idea of a pure ceph.conf-less world.  Lots of people already have tooling
> > around ceph.conf, getting rid of it will be an awkward process (even for a
> > one-time upgrade), and I'm not sure we can eliminate it entirely anyway
> > since many options affect the bootstrapping phase, authentication, and so
> > on.
> >
> > Instead, I'm currently partial to giving processes a more nuanced view of
> > their config based on where the value comes from.  A single option may
> > include
> >
> > 1- a default value (compiled in)
> > 2- a value from the mon
> > 3- a value from ceph.conf
> > 4- a value set via command line, 'ceph tell', 'ceph daemon ... config set
> > ...', etc.
> >
> > We would always use the highest-priority value on that list.  This means
> > that ceph.conf can override the mon, just like a command-line argument
> > overrides ceph.conf.
> 
> I think that if there are some folks who just cannot work without
> loading local configs onto their nodes, I want to insulate folks
> working on user interfaces from having to handle the resulting
> complexity.  The folks pushing config files out to their nodes
> presumably have their own preferred way of dealing with this stuff, so
> they shouldn't miss it from the Ceph UI.
> 
> In that spirit, I think that we don't need to have a per-setting
> granularity of what is overridden and what isn't: daemons should just
> flag whether they are consuming the mon config (default), or whether
> they are using local ceph.conf.  That way, folks building UIs can grey
> things out at a whole-page level if the cluster is not using
> centralized config.  It sacrifices some flexibility for the people who
> want to use local conf for some things but central conf for others (do
> those people exist?) but I think it's worth it to avoid having a
> complicated UI that has to worry about displaying and communicating
> the subtle distinctions between those 1/2/3/4 values which might all
> be different.

The problem is I think non-trivial ceph.confs are going to still be 
required in many valid situations, since there are a load of settings that 
affect how to connect and authenticate with the mon.  For most users the 
defaults will do and it will just be 'mon_host' (or maybe they 
use DNS for this), but any nontrivial authentication settings (e.g., 
kerberos is coming) or messenger types will require something.

(We also have to allow local overrides to ensure that the mon config can't 
brick the cluster by setting the internal mon settings, like paxos_*, to 
some bad value.)

I could see us combining 3-4 to simplify, though; the fact that a setting 
will go away on daemon restart isn't that interesting or normal, and 
presumably the cluster is *already* in a state where the mon and ceph.conf 
configs aren't fighting each other, so any disparity there will be seen 
for what it is.

I think the reporting to mgr to make a distinction needs to be there, 
though, because (1) to make a transition we want to see the delta between 
what the daemon has running and what the mon wants, and (2) I don't think 
we should make things like 'ceph daemon ... config set ...' turn into a 
request to the monitor to set a config so that the daemon will get a 
corresponding config update.  These are low-level commands that are 
important for debugging/fixing issues and I we shouldn't break them.

> The upshot would be that UI developers could build elements that work
> as expected by default for systems that use the central config, but
> safely disable themselves on systems where the user has gone their own
> way and pushed out local configuration.

I think the scenarios aren't too complex for the UI:

- the mon config doesn't match running config.
  - button to update mon config to match running config, and/or
  - button to clear running config so that it matches mon config
- the mon config is overridden by local ceph.conf
  - button to update/abbreviate/remove local ceph.conf settings so that 
    mon can drive

We can either keep the distinction for 3-4 and implement both, or blur 
them and the 'clear running config' just won't do anything.

Or the UI can not implement those buttons at all and just show that there 
is a disaparity and leave it to the user to fix (or not)...?

> > On the flip side of this, all of these values are also reported to the mgr
> > and tracked along with the other daemon state.  So regardless of where
> > config values come from, it is all still visible via the CLI, GUI, or
> > whatever else.
> >
> > Further, we can then make the GUI (or CLI or whatever) act on that
> > information to, say,
> >
> > - assimilate ceph.conf values into the mon so that ceph.cong can be
> > removed/abbreviated (i.e., the upgrade/transition path to centralized
> > config)
> 
> > - see override values set via cli (i.e., in gui)
> > - clear override values (i.e., ceph tell <daemon> config rm <name>)
> > - surface a HEALTH_WARN if a CLI or 'config set' override has been
> > set on one or more daemons (so the operator knows the running config is
> > not persistent).
> 
> This comes back to our recurring discussion about whether a
> HEALTH_INFO level should exist: I'm increasingly of the opinion that
> when we run into things like this, it's nature's way of telling us
> that maybe our underlying model is weird (in this case, maybe we
> didn't need to have the concept of ephemeral configuration settings in
> the system at all).
> 
> Maybe ephemeral config changes should be treated the same way I
> propose to treat local overrides: the daemon reports just that it has
> been overridden, and the GUI goes hands-off and does not attempt to
> communicate the story to the user "Well, you see, it's currently set
> to xyz until the next restart, at which point it will revert to abc,
> that is unless you have a local ceph.conf in which case...".

I don't think the restart subtlety needs to be communicated...

> The ability to rollback config changes seems like it would be the
> "right way" to accomplish having some config settings that we set and
> then subsequently revert, rather than having the revert happen
> implicitly when the daemon next restarts (intentionally or not).

Agreed.  We should be setting things like debug_osd=20 for diagnosing 
an issue via the mon.

> > - surface a HEALTH_WARN if a mon option is overriden by a daemon's local
> > ceph.conf file.
> 
> Hmm, this makes me a bit confused, as if you're still thinking of the
> local ceph.conf being a deprecated/upgrade thing?  If it's really
> permitted in general than it wouldn't make sense for it to be a WARN.

This warning would only appear if the mon sets option foo to A and the 
conf sets teh same option to B...

sage
