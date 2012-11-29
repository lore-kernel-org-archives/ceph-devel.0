From: Sage Weil <sage@inktank.com>
Subject: Re: parsing in the ceph osd subsystem
Date: Thu, 29 Nov 2012 08:34:08 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59153 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2K2QeI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 11:34:08 -0500
In-Reply-To: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 29 Nov 2012, Andrey Korolyov wrote:
> $ ceph osd down -
> osd.0 is already down
> $ ceph osd down ---
> osd.0 is already down
> 
> the same for ``+'', ``/'', ``%'' and so - I think that for osd subsys
> ceph cli should explicitly work only with positive integers plus zero,
> refusing all other input.

which branch is this?  this parsing is cleaned u pin the latest 
next/master.



> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
