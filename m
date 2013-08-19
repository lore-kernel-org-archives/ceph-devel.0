From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: v0.61.8 Cuttlefish released
Date: Mon, 19 Aug 2013 22:14:46 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B6649FD75@BITCOM1.int.sbss.com.au>
References: <alpine.DEB.2.00.1308191251390.11136@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:57726 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab3HSWPD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 18:15:03 -0400
In-Reply-To: <alpine.DEB.2.00.1308191251390.11136@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> We've made another point release for Cuttlefish. This release contains a
> number of fixes that are generally not individually critical, but do trip
> up users from time to time, are non-intrusive, and have held up under
> testing.
> 
> Notable changes include:
> 
>  * librados: fix async aio completion wakeup
>  * librados: fix aio completion locking
>  * librados: fix rare deadlock during shutdown

Could any of these be causing the segfaults I'm seeing in tapdisk rbd? Are these fixes in dumpling?

Thanks

James
