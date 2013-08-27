From: Sage Weil <sage@inktank.com>
Subject: Re: trivial bug in aio_write
Date: Tue, 27 Aug 2013 08:31:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308270831000.2000@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B664AFC7D@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50049 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab3H0PbH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 11:31:07 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B664AFC7D@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's not; I've pushed a fix.  Thanks!

sage

On Tue, 27 Aug 2013, James Harper wrote:

> In internal.cc function aio_write, the ldout(cct, ...) statement writes out &buf instead of buf. I assume this is not intentional.
> 
> James
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
