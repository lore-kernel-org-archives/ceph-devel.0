From: Sage Weil <sage@inktank.com>
Subject: Re: status of fancy striping for krbd
Date: Mon, 30 Sep 2013 08:33:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309300831330.12714@cobra.newdream.net>
References: <CABZ+qqmWzDpv=FzwVyM0ai7RaQxiKE4gW+Zx7jELArGqjY+Vdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53860 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303Ab3I3PdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Sep 2013 11:33:03 -0400
In-Reply-To: <CABZ+qqmWzDpv=FzwVyM0ai7RaQxiKE4gW+Zx7jELArGqjY+Vdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 30 Sep 2013, Dan van der Ster wrote:
> Hi all,
> I just noticed that krbd supports mapping format v2 images in 3.11,
> but it doesn't yet support STRIPINGV2. Is this coming anytime soon?

We don't have immediate plans to add the striping feature.  You may be the 
first person to ask for it.  :)

The challenge is that it requires a fair bit of refactoring in the 
osd_client layer to do scatter/gather type IO.  The nice thing is that 
this will equally benefit CephFS, which supports the same range of 
striping configurations.

sage
