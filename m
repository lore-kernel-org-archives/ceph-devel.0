From: Sage Weil <sage@newdream.net>
Subject: Re: xattrs vs. omap with radosgw
Date: Wed, 17 Jun 2015 07:38:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506170737310.16406@cobra.newdream.net>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl> <alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net> <55812276.2040305@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54273 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbbFQOiG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jun 2015 10:38:06 -0400
In-Reply-To: <55812276.2040305@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: GuangYang <yguang11@outlook.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Wed, 17 Jun 2015, Nathan Cutler wrote:
> > We've since merged something 
> > that stripes over several small xattrs so that we can keep things inline, 
> > but it hasn't been backported to hammer yet.  See
> > c6cdb4081e366f471b372102905a1192910ab2da.
> 
> Hi Sage:
> 
> You wrote "yet" - should we earmark it for hammer backport?

Yes, please!

sage
