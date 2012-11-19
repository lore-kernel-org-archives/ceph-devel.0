From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: librbd discard bug problems -> i got it
Date: Tue, 20 Nov 2012 00:16:33 +0100
Message-ID: <50AABDD1.5050802@profihost.ag>
References: <50AAA25F.9040908@profihost.ag> <50AAB4D6.3030304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58905 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab2KSXQf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:16:35 -0500
In-Reply-To: <50AAB4D6.3030304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

mhm qemu rbd block driver. Get's always these errors back. As 
rbd_aio_bh_cb is directly called from librbd the problem must be there. 
Strangely i can't find where rbd_aio_bh_cb get's called with -512.

ANy further ideas?

rbd_aio_bh_cb got error back. Code: -512 Error: 0
rbd_aio_bh_cb got error back. Code: -512 Error: 0
rbd_aio_bh_cb got error back. Code: -512 Error: 0
rbd_aio_bh_cb got error back. Code: -512 Error: 0
rbd_aio_bh_cb got error back. Code: -512 Error: 0
rbd_aio_bh_cb got error back. Code: -512 Error: 0
rbd_aio_bh_cb got error back. Code: -512 Error: 0
rbd_aio_bh_cb got error back. Code: -512 Error: 0
rbd_aio_bh_cb got error back. Code: -512 Error: 0
rbd_aio_bh_cb got error back. Code: -1006628352 Error: 0

Stefan
