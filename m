From: Sage Weil <sage@inktank.com>
Subject: Re: Missing Option to give amount of PGs on pool creation with
 librados
Date: Mon, 5 Aug 2013 09:29:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308050929020.15886@cobra.newdream.net>
References: <7717d2e3c2768d554dafe48cfe657778@niklasgoerke.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46475 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab3HEQ35 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 12:29:57 -0400
In-Reply-To: <7717d2e3c2768d554dafe48cfe657778@niklasgoerke.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Niklas Goerke <niklas@niklasgoerke.de>
Cc: ceph-devel@vger.kernel.org

On Mon, 5 Aug 2013, Niklas Goerke wrote:
> Hi there
> 
> The way I see it, there is no option to give the amount of PGs when creating a
> new pool using librados [1]. Thus any pool created using librados has 8 PGs
> (default). I don't see a reason for this behaviour. Is there any?
> 
> Otherwise I'll post a feature request for an option to give the amount of PGs.

You can also use the new mon_command call to feed a create command in
json, which does let you specify the pg count (this is exactly what the 
CLI does now).  Starting with 0.66, at least!

sage


> 
> Niklas
> 
> [1] http://ceph.com/docs/next/rados/api/librados/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
