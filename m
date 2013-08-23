From: Sage Weil <sage@inktank.com>
Subject: Re: v0.67.2 Dumpling released
Date: Fri, 23 Aug 2013 09:52:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308230950150.28981@cobra.newdream.net>
References: <alpine.DEB.2.00.1308230941510.28981@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39400 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab3HWQwC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 12:52:02 -0400
In-Reply-To: <alpine.DEB.2.00.1308230941510.28981@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

On Fri, 23 Aug 2013, Sage Weil wrote:
>  * osd: disable PGLog::check() via config option (fixes CPU burn)

Just to clarify this point: the new config option contorls some debugging 
checks we left in, and is now off (i.e., no expensive checks) by default, 
so users don't need to do anything here except enjoy the lower CPU 
utilization.

sage
