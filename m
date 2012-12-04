From: Sage Weil <sage@inktank.com>
Subject: Re: next branch: logrotate and invoke-rc.d
Date: Tue, 4 Dec 2012 05:26:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212040526110.6542@cobra.newdream.net>
References: <50BDAF4C.3090806@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52865 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab2LDN07 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 08:26:59 -0500
In-Reply-To: <50BDAF4C.3090806@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 4 Dec 2012, Stefan Priebe - Profihost AG wrote:
> Hello list,
> 
> since a few days can't remember which revision. It seems something in
> logrotate was changed.
> 
> I'm getting the following daily cron output:
> 
> Subject: Cron <root@cloud1-ceph1> test -x /usr/sbin/anacron || ( cd / &&
> run-parts --report /etc/cron.daily )
> 
> /etc/cron.daily/logrotate:
> /usr/sbin/invoke-rc.d

Pushed a fix to next.  Thanks!

sage

> 
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
