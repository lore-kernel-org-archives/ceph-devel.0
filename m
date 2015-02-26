From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: ceph versions
Date: Thu, 26 Feb 2015 18:59:55 -0500 (EST)
Message-ID: <567942662.11970131.1424995195896.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net> <54EFAE77.3020101@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:47297 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbB0ABA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 19:01:00 -0500
In-Reply-To: <54EFAE77.3020101@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org



----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
> Sent: Thursday, February 26, 2015 3:38:31 PM
> Subject: Re: ceph versions
> 
> Hi Sage,
> 
> I prefer Option D because it's self explanatory. We could also drop the
> names. I became attached to them but they are confusing to the new users who
> is required to remember that firefly is 0.80, giant is 0.87 etc.
> 
> Cheers
> 
> On 27/02/2015 00:12, Sage Weil wrote:
> > -- Option D -- "labeled"
> > 
> > X.Y-{dev,rc,release}Z
> > 
> >  - Increment Y on each major named release
> >  - Increment X if it's a major major named release (bigger change
> > than usual)
> >  - Use dev, rc, or release prefix to clearly label what type of release
> > this is
> >  - Increment Z for stable updates
> > 
> >  1.0-dev1 first infernalis dev release
> >  1.0-dev2 another dev release
> >  ...
> >  1.0-rc1 first rc
> >  1.0-rc2 next rc
> >  1.0-release1 final release
> >  1.0-release2 stable update
> >  1.0-release3 stable update
> >  1.1-dev1 first cut for j-release
> >  1.1-dev2 ...
> >  ...
> >  1.1-rc1
> >  1.1-release1 stable
> >  1.1-release2 stable
> >  1.1-release3 stable
> > 
> > Q: How do I tell what kind of release this is?
> > A: Look at the string embedded in the version
> > 
> > Q: Will these funny strings confuse things that sort by version?
> > A: I don't think so.
> 
> dev < rc < release : good pick ;-)
> 

This is the one I lean towards, with one slight variation. I'd drop the 'release' tag and have X.Y[.Z] format for the formal releases, e.g.,
2.0-dev1 first infernalis dev release
2.0-dev2
..
2.0-rc1
2.0-rc2
...
2.0 # infarnalis
2.0.1 # first dot release
...
2.1-dev1 # first j dev release
...
2.1 # j release

Then after a few release move to 3.0 to avoid the dreadful big numbers.

Sage did mention that this might have some issues in certain environments to sort correctly. Possibly replacing the dash with a tilde solves this?

Yehuda
