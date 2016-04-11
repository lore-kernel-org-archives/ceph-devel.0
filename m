From: Wido den Hollander <wido@42on.com>
Subject: Re: releasing hammer v0.94.7 ?
Date: Mon, 11 Apr 2016 09:30:01 +0200 (CEST)
Message-ID: <615221452.2670.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
References: <57067073.9040200@dachary.org>
 <1755778347.2548.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
 <alpine.DEB.2.11.1604080840170.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:49550 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbcDKHaI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 03:30:08 -0400
In-Reply-To: <alpine.DEB.2.11.1604080840170.19675@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>


> Op 8 april 2016 om 14:43 schreef Sage Weil <sweil@redhat.com>:
> 
> 
> On Fri, 8 Apr 2016, Wido den Hollander wrote:
> > > Op 7 april 2016 om 16:36 schreef Loic Dachary <loic@dachary.org>:
> > > 
> > > Hi Sage,
> > > 
> > > Here are the issues that would be in hammer v0.94.7 if we decided to
> > > release
> > > it now: http://tracker.ceph.com/versions/511
> > > And here is the backport queue :
> > > http://tracker.ceph.com/projects/ceph/issues?query_id=78
> > > 
> > > Do you think it is time to cut the release and ask QE to start testing ?
> > > 
> > 
> > As this might be the last Hammer release I wonder if we could fix this bug:
> > http://tracker.ceph.com/issues/15348
> 
> Don't worry, it won't be the last one--we have at least another half 
> year left.
> 

Ok, great! In the meantime I created a PR for Hammer:
https://github.com/ceph/ceph/pull/8528

> > I already submitted a PR for it: https://github.com/ceph/ceph/pull/8441
> > 
> > I backported it on a production cluster to Hammer and it works fine. Might
> > be
> > something we can squeeze in?
> 
> Can you add a test to s3-tests for this?
> 

Good one. Never touched those before. I'll look into that.

Wido

> sage
