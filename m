From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: librbd discard bug problems -> i got it
Date: Mon, 19 Nov 2012 16:28:13 -0800
Message-ID: <50AACE9D.8080905@inktank.com>
References: <50AAA25F.9040908@profihost.ag> <50AAB4D6.3030304@inktank.com> <50AABDD1.5050802@profihost.ag> <50AAC1B1.9070701@inktank.com> <50AAC3CB.9090309@profihost.ag> <50AAC51C.1090904@inktank.com> <50AAC835.908@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:50734 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab2KTA2v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 19:28:51 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so975522dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 16:28:51 -0800 (PST)
In-Reply-To: <50AAC835.908@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/19/2012 04:00 PM, Stefan Priebe wrote:
> Hi Josh,
>
> i don't get it. Every debug line i print is a prositive fine value. BUt
> rbd_aio_bh_cb get's called with these values. As you can see that are
> not much values i copied all values < 0 from log for discarding a whole
> 30GB device.

Could you post the patch of the debug prints you added and the log?
