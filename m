From: Sage Weil <sweil@redhat.com>
Subject: Re: is function get_net_marked_down right?
Date: Tue, 16 Sep 2014 22:16:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409162215310.20205@cobra.newdream.net>
References: <CABF_e-H+qqq+ig7KDvwwgDbnuwVVwJ_K3hspaCWozaZC8jM9qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48853 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaIQFQZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 01:16:25 -0400
In-Reply-To: <CABF_e-H+qqq+ig7KDvwwgDbnuwVVwJ_K3hspaCWozaZC8jM9qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cheng Wei-Chung <freeze.vicente.cheng@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 17 Sep 2014, Cheng Wei-Chung wrote:
> Dear all:
> 
> I have seen this function few days.
> OSDMap::Incremental::get_net_marked_down
> 
> There is something strange I don't know why.
> 
> why we increase n when we got state and previous state is UP?
> if (p->second & CEPH_OSD_UP) {
>       if (previous->is_up(p->first))
>         n++;  // marked down
>       else
>         n--;  // marked up
> }
> 
> This function aims to help check whether the osd can be mark down or not, right?
> 
> For counting the osd that state is down, the above function is
> counting the osd that state is up?
> 
> I would like to know there is some minor error or something I don't
> really understand.

For lame historical reasons the CEPH_OSD_UP flag in the incremental 
*toggles* the up/down state ... it either means the OSD came up or that it 
went down.

sage

