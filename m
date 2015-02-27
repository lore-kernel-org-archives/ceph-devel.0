From: Sage Weil <sweil@redhat.com>
Subject: Re: s3-tests development
Date: Fri, 27 Feb 2015 10:31:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502271030170.23553@cobra.newdream.net>
References: <20150227023734.GE21215@sherlock> <89668076.12410416.1425057105722.JavaMail.zimbra@redhat.com> <20150227182623.GA15693@sherlock>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbbB0Sbe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 Feb 2015 13:31:34 -0500
In-Reply-To: <20150227182623.GA15693@sherlock>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Gaul <andrew@gaul.org>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel@vger.kernel.org, Alfredo Deza <adeza@redhat.com>

On Fri, 27 Feb 2015, Andrew Gaul wrote:
> On Fri, Feb 27, 2015 at 12:11:45PM -0500, Yehuda Sadeh-Weinraub wrote:
> > Andrew Gaul wrote:
> > > While s3-tests has good functionality as it
> > > exists, the project has not progressed much over the last six months.  I
> > > have submitted over 20 pull requests to fix incorrect tests and for
> > > additional test coverage but most remain unreviewed[2].
> > 
> > Right. We do need to be more responsive. The main reason we took our time was that these tests are used for the ceph nightly qa tests, and any changes in these that exposes new incompatibility will fail these. We'd rather first have the issue fixed, then merge the change. An alternative way to doing it is to open a ceph tracker issue about the incompatibility, mark the test as 'fails_on_rgw', in which case we could merge it immediately.
> 
> Instead of testing against master, perhaps you can tag a s3-tests 1.0.0
> release and Ceph can use that?  Alternatively you can run your tests
> against a specific commit hash.  In addition to running s3-tests against
> Ceph, it would be good to run it against AWS, although we are blocked as
> discussed below.

I think this makes sense.  I don't think we should hold back s3-tests 
development because radosgw isn't there yet.  Just as we have branches for 
ceph stable versions we can have one for ceph master and move that forward 
or rebase or annotate as we play catch-up with the tests...

sage
