From: Sage Weil <sage@newdream.net>
Subject: Re: read/write on RADOS using external buffer
Date: Mon, 15 Nov 2010 10:07:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011151003160.3026@cobra.newdream.net>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
 <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
 <20101019222727.GA1737@enoki.dokukino.com> <AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
 <Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
 <AANLkTin0+n+e6Cb_WJcz5JA7xR_XG_K=2k0_bhSDuDRh@mail.gmail.com>
 <Pine.LNX.4.64.1010200821210.3927@cobra.newdream.net>
 <AANLkTi=GyJdFkRV5zo-v-74tn=YBKCBuZC9fdeg1fJCr@mail.gmail.com>
 <Pine.LNX.4.64.1010200948040.3927@cobra.newdream.net>
 <AANLkTingwXNcvkTV3OG-siRywzEj6r_Vmb==BnodEUka@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40617 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551Ab0KOSDS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Nov 2010 13:03:18 -0500
In-Reply-To: <AANLkTingwXNcvkTV3OG-siRywzEj6r_Vmb==BnodEUka@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

I got around to implementing this and merged it into the unstable branch.  
See commit 7f38858c0c19db36c5ecf36cb4d333579981c811.  From my limited 
testing it seems to work fine.  Currently it only triggers via the 
librados C interface (currently the only place where there is a user 
provided buffer).

Eventually libceph/Client.h should be updated to do the same, but it's a 
bit more involved.

sage
