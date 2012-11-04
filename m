From: Sage Weil <sage@inktank.com>
Subject: Re: Memory leak bug in the latest master
Date: Sun, 4 Nov 2012 01:12:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211040111570.26143@cobra.newdream.net>
References: <CAAM7YAkMNe-0ig4DcumUHA++0gkqArwj-SYMzoqN7PDU2W9-OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41208 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab2KDJM2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 04:12:28 -0500
In-Reply-To: <CAAM7YAkMNe-0ig4DcumUHA++0gkqArwj-SYMzoqN7PDU2W9-OA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng " <yanzheng@21cn.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, reiher@inktank.com

Hi Yan-

Thanks!  Tracked this down to teh Pipe AuthSessionHandler.  Fixed in 
bcefc0e80ac2bda6d3b4550a6d849302bcc201d6.

sage

On Sat, 3 Nov 2012, Yan, Zheng  wrote:

> Hi Everybody,
> 
> I found there is a memory leak bug in the latest master (c51e1f9b64).
> The bug affects
> both ceph-osd and ceph-mds. git bisect show bad commit could be any of:
> 27974c4621188cf403a558d7f01f7409539158f3
> cc5d05bc294711155324d21a8bdba574847f881e
> 2b56e800b58ed8322428f24ff9b9fafb2e35a01c
> 7cce4d41548bde68b93bfbc902a6eb1cd25bfcb7
> 1166f3a085e4a6bb84a976646d778df913bde648
> 
> Regards
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
