From: Rutger ter Borg <rutger@terborg.net>
Subject: Multiple concurrent async ops per IoCtx?
Date: Wed, 29 Aug 2012 12:57:09 +0200
Message-ID: <k1ksi5$q2p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59372 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab2H2K5T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Aug 2012 06:57:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T6fxX-0000he-OV
	for ceph-devel@vger.kernel.org; Wed, 29 Aug 2012 12:57:19 +0200
Received: from 233-250-103-145.static.glaslokaal.nl ([145.103.250.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 12:57:19 +0200
Received: from rutger by 233-250-103-145.static.glaslokaal.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 12:57:19 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Dear list,

are Rados' IoCtx objects able to process multiple asynchronous 
operations at the same time, or is it necessary to wait for an operation 
to complete, before issuing a following operation?

I.e., can I do the following and expect it to work?

IoCtx ctx;
ctx.aio_read( ... read 1 ... );
ctx.aio_read( ... read 2 ... );
ctx.aio_read( ... read 3 ... );

... time passes ...

read 3 completes (e.g.)
read 1 completes
read 2 completes

TIA,
Cheers,

Rutger


