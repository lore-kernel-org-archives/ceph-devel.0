From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: xattrs vs. omap with radosgw
Date: Wed, 17 Jun 2015 09:32:06 +0200
Message-ID: <55812276.2040305@suse.cz>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl> <alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42877 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204AbbFQHcK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 03:32:10 -0400
In-Reply-To: <alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: GuangYang <yguang11@outlook.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

> We've since merged something 
> that stripes over several small xattrs so that we can keep things inline, 
> but it hasn't been backported to hammer yet.  See
> c6cdb4081e366f471b372102905a1192910ab2da.

Hi Sage:

You wrote "yet" - should we earmark it for hammer backport?

Nathan
