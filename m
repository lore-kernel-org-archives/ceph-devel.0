From: Sage Weil <sage@inktank.com>
Subject: Re: 0.56.6: MDS asserts on restart
Date: Fri, 10 May 2013 08:41:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305100841001.25318@cobra.newdream.net>
References: <518CF45B.7010402@de-punkt.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39411 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab3EJPlS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 May 2013 11:41:18 -0400
In-Reply-To: <518CF45B.7010402@de-punkt.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher Kunz <chrislist@de-punkt.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 10 May 2013, Christopher Kunz wrote:
> Hi all,
> 
> after our update to 0.56.6, all MDSes assert and crash on start. This is
> not essential for our setup, but still not great. We assume this might
> be due to a bug - see the nopaste below for a trace.
> 
> http://nopaste.info/aa06c50a2f.html

Do you have the stack trace from the mds log file?  There should be an 
assertion message and a line number.

Thanks!
sage

> 
> Regards,
> 
> --ck
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
