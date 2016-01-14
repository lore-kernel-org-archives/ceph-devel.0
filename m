From: Marcus Watts <mwatts@redhat.com>
Subject: Re: Ideas for new ceph-mgr service
Date: Wed, 13 Jan 2016 23:49:30 -0500
Message-ID: <20160114044930.GB25708@degu.b.linuxbox.com>
References: <CALe9h7f-AaBxcNU=25dmYUxbZe9RhJwxvBTRyc5qVxzTjSCMrw@mail.gmail.com>
 <156637337.14721161.1452700430079.JavaMail.zimbra@redhat.com>
 <CALe9h7fm_r2a8p7BMYscr+Ba09X_ZMQsQcA+2QwPdkpAYCVZFg@mail.gmail.com>
 <56969124.4040604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbcANEtd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jan 2016 23:49:33 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id EE024461C0
	for <ceph-devel@vger.kernel.org>; Thu, 14 Jan 2016 04:49:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56969124.4040604@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: John Spray <jspray@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jan 13, 2016 at 12:02:12PM -0600, Mark Nelson wrote:
Various wrote:
...
> >>>We currently have an unfulfilled need for a high level
> >>>management/monitoring service that can take some of the non-essential
...
> >>>So, the idea is to create a new lightweight service (ceph-mgr) that
> >>>runs alongside the mon, and uses the existing Ceph network channels to
> >>>talk to remote hosts.  The address of this service would be published
...

I think I'm going to take this in a slightly different direction.
[ ie, "blue sky" warning. ]

What was described up there (ceph-mgr) is pretty much an "admin" server.
Which is a nice idea.  But, -- well, I think what you've described is
pretty much a web server running python, except maybe you've got a weird
transport instead of http?  (and some local cached data...)

I think there are a variety of things ceph-mon does that it shouldn't,
and some things it doesn't do that maybe it shouldn't, but something should.

So some things ceph-mon doesn't do: start/stop ceph services.
Why this is useful: better integration, control of when services
start and stop, ability to migrate services between machines depending
on load or other factors.

Things ceph-mon does that it *should* do: location service/broker.
Where are things running?  This is the "fixed point" that you have
to advertise in ceph.conf, because you have to start somewhere.
Once you can locate everything elsewhere, you no longer have to run
it all in the mon.

ceph-mon provides consensus data services, and a variety of databases
on top of that.  This doesn't necessarily need to be the same set
of machines or service that does location brokering, and it might
be useful to move different databases to different sets of machines.
It may also be useful to separate one database into subsets that
get managed by different machines.  Also it should be separate from
the next bit.

I think this is the part that's actually already been discussed,
but:
ceph-mon provides an "exec" environment.  They all get "argv",and
they produce "stdout" and "stderr" output.  And there are a bunch
of canned apps.  It would be nice to de-couple argument parsing and
stdout/stderr output from the actual operation logic.  
So the seperation I would try to have is;
	1/ lowlevel "fixed" logic, as C++, providing a variety of
	simpler operations or where operation speed or consistency
	matters.
	2/ mid-level "programmarable" logic, perhaps as python
	where it can be threaded/operation speed doesn't matter.
	Eats and produces binary structures, perhaps json, or not.
	Runs with "system privileges".
	Also provide ability (*new*) - to add additional scripts,
	and to provide for periodic scheduled internal operations
	("cron".)
	Operations at this layer may not correspond exactly to user commands.
		If you want C++ -- how about a plugin shared-object
		architecture for this bit?
	3/ high-level "outer" logic.  runs on end-user user machines
	with user privileges (which might not be trustable.)  Might parse
	arg lines, might be a menu, cgi applet, might produce text output,
	xml, json, or html.  Might in some cases execute
	multiple operations in response to one user request.

The consensus and "exec" mechanisms in ceph today are kind of
conmingled, and each consensus database has its own specific list
of data.  Separating it could be icky, but I think there's a win.

One goal in this should to avoid a "firehouse" concentration
of too much stuff in any one place.  Ie, should allow for as
much parallelism as possible, and to require the least degree of
serialization or exclusion.

Anyways, those are some of my thoughts about where this could go.

					-Marcus Watts
