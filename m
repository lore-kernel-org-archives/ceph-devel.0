From: Sage Weil <sage@newdream.net>
Subject: Re: cmon silently fails if addr is wrong in ceph.conf (0.20.1)
Date: Fri, 28 May 2010 13:57:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005281356560.3234@cobra.newdream.net>
References: <htnseq$l6k$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36284 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab0E1U5Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 May 2010 16:57:25 -0400
In-Reply-To: <htnseq$l6k$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

On Fri, 28 May 2010, Thomas Mueller wrote:
> i missconfigured the mon addr in ceph.conf. /etc/init.d/ceph did not show 
> any errors - seemd to start. but cmon did not start.
> 
> i've "straced" cmon:
> 
> bind(6, {sa_family=AF_INET, sin_port=htons(6789), sin_addr=inet_addr
> ("192.168.32.61")}, 16) = -1 EADDRNOTAVAbind(6, {sa_family=AF_INET, 
> sin_port=htons(6789), sin_addr=inet_addr("192.168.32.61")}, 16) = -1 
> EADDRNOTAVAIL (Cannot assign requested address)IL (Cannot assign 
> requested address)
> 
> A descriptive error message would be cool.

I pushed a fix to the unstable and testing branches.5D

Thanks!
sage
