From: Sage Weil <sweil@redhat.com>
Subject: Re: on-the-wire encryption, addrs, and cephx
Date: Fri, 6 May 2016 12:53:19 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605061249190.15518@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605050822230.15413@cpach.fuggernut.com> <CAJ4mKGaU_oB6QLGxUF5irPM4T9FOoN0Q=wRNWBXH0TS0GFMEQg@mail.gmail.com> <alpine.DEB.2.11.1605060823190.15518@cpach.fuggernut.com> <20160506161105.GA23534@ultraspiritum>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49508 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755370AbcEFQxK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 12:53:10 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80B43627F5
	for <ceph-devel@vger.kernel.org>; Fri,  6 May 2016 16:53:09 +0000 (UTC)
In-Reply-To: <20160506161105.GA23534@ultraspiritum>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 6 May 2016, Adam C. Emerson wrote:
> On 06/05/2016, Sage Weil wrote:
> [snip]
> > and we'll also need to keep the v1 protocol support around for a
> > long time (probably a couple years at least) for the benefit of old
> > clients.  And there's no reason anybody *has* to switch to the new
> > protocol unless they need the new features or improved security.
> [snip]
> 
> I can understand not wanting to force people to take a performance
> hit. However, it sounded, from your writeup, like even without
> encryption the new auth mechanism would be an improvement on the old
> one. Once we do get it working, tested, and performant, I'd suggest we
> might want to force users' hand on the issue and announce that the old
> mechanism will be removed in some upcoming version, rather than
> waiting for users to rotate older clients out over time.

As soon as the new stuff is stable and performant, yeah, I think we should 
announce the old stuff is deprecated.  But we will have to keep it around 
for a pretty long time to support existing kernels and clients.  People 
still pretty frequently have dumpling or older clients talking to 
up-to-date clusters.  Partly this is just infrastructure moving slowly, 
and partly it users not wanting to restart running VMs.

I would say at least 2 LTS releases, maybe longer...

sage
