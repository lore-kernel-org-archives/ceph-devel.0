From: Marcus Watts <mwatts@redhat.com>
Subject: Re: ceph / rocksdb
Date: Thu, 25 Feb 2016 03:15:22 -0500
Message-ID: <20160225081522.GA14622@degu.b.linuxbox.com>
References: <20160224060546.GC6585@degu.b.linuxbox.com>
 <CALqRxCwrsTv=Lbrc98f7WLqwZxeySiAdq08E0h8a2eNyDU6SPQ@mail.gmail.com>
 <alpine.DEB.2.11.1602241305060.7555@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44998 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759947AbcBYIP0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Feb 2016 03:15:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id DB9D0486AB
	for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 08:15:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1602241305060.7555@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Feb 24, 2016 at 01:06:48PM -0500, Sage Weil wrote:
> On Wed, 24 Feb 2016, Ken Dreyer wrote:
> > I'm really interested in getting our various bundled libraries into
> > separate packages.
> > 
> > Does ceph's rocksdb have a lot of changes from rocksdb upstream? If
> > so, I'm leaning towards packaging this as "ceph-rocksdb" until those
> > changes are present in an upstream rocksdb release.
> 
> There are a few that aren't upstream yet, but they'll merge eventually. 
> That said, I fully expect that we'll make other changes in the future that 
> we'll want to build/test/ship before they go upstream... so a special 
> package name probably makes sense.
> 
> sage
> 
> 
> > 
> > - Ken
> > 
... and I'm eliding what I posted originally to conserve electrons.

When I looked at upstream rocksdb I couldn't find anything we had that
they didn't have.  I believe it should not be hard to work towards
a target of using the unmodified distribution version in production
environments.

Looks like:
* debian - has rocksdb (=4.1.0); appears to be very recent.  Has no
  current packages that use rocksdb.  There appear to be plans to use
  rocksdb with osquery.
* ubuntu.  Looks to be the identical state to debian, same maintainer.
* fedora.  No rocksdb currently.  I think we could be the maintainer here,
		if we want.

All this is going to be very distribution specific, involve maintainers,
upstream, &etc.  Still, this looks like it could be very tractable.

What we do locally with "build/test/ship" is another matter entirely.
I can see a world where the gitbuilders just install "our" rocksdb as
another build dependency for ceph.  Conceivably if we want to get fancy
those gitbuilders (or others?) could also be building rocksdb (presumably
from our repo), producing packages that after additional vetting (teuthology
etc.) can be made available to the ceph git builders.  The only real
complexity I can see is it might be useful sometimes to steer different
rocksdb packages towards different ceph branches.

					-Marcus Watts
