From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: use kernel DNS resolver
Date: Fri, 23 Sep 2011 12:15:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109231213580.31698@cobra.newdream.net>
References: <CAB2gnbVw2_FSWVVmUA1OobE1Ti9Q1w3AP_67=Vo4zwZtQ=gHYg@mail.gmail.com>
 <Pine.LNX.4.64.1109221426310.19558@cobra.newdream.net>
 <CAB2gnbVaS=x9hurY0P8x4Ltqh11foOpsMBy2MNt662T2X9+BLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37766 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab1IWTPh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 15:15:37 -0400
In-Reply-To: <CAB2gnbVaS=x9hurY0P8x4Ltqh11foOpsMBy2MNt662T2X9+BLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, 23 Sep 2011, Noah Watkins wrote:
> On Thu, Sep 22, 2011 at 14:29, Sage Weil <sage@newdream.net> wrote:
> > Currently the dns resolution is handled by mount.ceph and 'rbd map/unmap'.
> > I don't think that will go away (at the very least need to support old
> > kernels).
> 
> This is good to know. I never encountered the DNS lookup because I've
> always used a non-standard installation path, avoiding mount.ceph.
> 
> > Allowing this in the raw kernel interface would be nice, but I don't think
> > we want make DNS_RESOLVER a strict dependency, since it's new, kind of
> > kludgey, and a ripe target for compiling out of small or secure kernels.
> > Can you make it build either with or without it?
> 
> I sent out a new version of the patch that defines a libceph specific 
> configuration option to use the in-kernel dns resolver.

So I was actually thinking we could just #ifdef off of 
CONFIG_DNS_RESOLVER, but I think your approach might be better because 
you'll see it in the config process and turn it on, vs having to dig 
through to wherever DNS_RESOLVER lives in kconfig.

Maybe it should default y though?

sage
