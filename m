From: Marcus Watts <mwatts@redhat.com>
Subject: Re: new naming convention for building repos and binaries from
 branches
Date: Thu, 6 Oct 2016 23:32:14 -0400
Message-ID: <20161007033214.GB23519@degu.eng.arb.redhat.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
 <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com>
 <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
 <alpine.DEB.2.11.1610061633440.19850@piezo.us.to>
 <CAJ4mKGbfTw+7y_XBkgDj6vzu65Z=VgfpMrBGNM5E+ZAVP3wC_w@mail.gmail.com>
 <CAC-Np1wmFwEHV4WvN9d8tX_NenZ3wAfZE4XNgtW2O_Z_o29D_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbcJGDcR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 23:32:17 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12F6BC05490E
        for <ceph-devel@vger.kernel.org>; Fri,  7 Oct 2016 03:32:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAC-Np1wmFwEHV4WvN9d8tX_NenZ3wAfZE4XNgtW2O_Z_o29D_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Sage Weil <sweil@redhat.com>, Andrew Schoen <aschoen@redhat.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Someone in the middle said:
...
> >If we're really concerned about not building
...

I think that's key.  We build a lot more stuff, a lot
more often, than I think most people actually need or use.
Which means we wind up waiting for builds to complete
that nobody will ever use.

I think the natural progression of things is:

stage 1.	coded up, ready to share, not ready to build or test.
		(might be being built out of stream,  etc.)
		early stage of collaboration, code review, etc.
		[ I think people currently do this in various
		different ways... ]
stage 2.	ready to test / build / for a LIMITED set of
		architectures (often just one.)
		start of testing, don't need all architectures yet.
		OR, failed on one architecture, want to just test *that*
		architecture.  [ We don't currently have a way to
		do this, but I bet at least half of our builds could
		work this way. ]
stage 3.	ready to test / build / for ALL architectures.
		about to commit fix to master / general distribution,
		known to work on one architecture, but want to actually
		do the thorough test on everything.

Doing this by special branch names seems a bit clumsy to me.  I suppose
we could have "nobuild-FOO", "ubuntuonly-FOO", "buildeverywhere-FOO".
But it seems more natural to me to have some kind of prefix
matching/configuration thing that the builder could use to the same
effect.  Then progressing wip-FOO from stage 2 to stage 3 could be just
a matter of the programmer adjusting the filter for the "wip-foo" from
"ubuntuonly" to "buildeverywhere", then the automation building the
identical source on the other architectures (and *not* rebuilding on
the original architecture for which perfectly good builds don't need to
be repeated.)

					-Marcus Watts
