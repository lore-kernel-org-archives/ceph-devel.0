From: Sage Weil <sweil@redhat.com>
Subject: Re: releasing hammer v0.94.7 ?
Date: Fri, 8 Apr 2016 08:43:47 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604080840170.19675@cpach.fuggernut.com>
References: <57067073.9040200@dachary.org> <1755778347.2548.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758503AbcDHMnx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Apr 2016 08:43:53 -0400
In-Reply-To: <1755778347.2548.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Loic Dachary <loic@dachary.org>, Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 8 Apr 2016, Wido den Hollander wrote:
> > Op 7 april 2016 om 16:36 schreef Loic Dachary <loic@dachary.org>:
> > 
> > Hi Sage,
> > 
> > Here are the issues that would be in hammer v0.94.7 if we decided to release
> > it now: http://tracker.ceph.com/versions/511
> > And here is the backport queue :
> > http://tracker.ceph.com/projects/ceph/issues?query_id=78
> > 
> > Do you think it is time to cut the release and ask QE to start testing ?
> > 
> 
> As this might be the last Hammer release I wonder if we could fix this bug:
> http://tracker.ceph.com/issues/15348

Don't worry, it won't be the last one--we have at least another half 
year left.

> I already submitted a PR for it: https://github.com/ceph/ceph/pull/8441
> 
> I backported it on a production cluster to Hammer and it works fine. Might be
> something we can squeeze in?

Can you add a test to s3-tests for this?

sage
