From: Gregory Farnum <greg@inktank.com>
Subject: Re: parsing in the ceph osd subsystem
Date: Wed, 28 Nov 2012 23:53:01 -0800
Message-ID: <B453C492BDAC445C8A5673E1A088151C@inktank.com>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:46508 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab2K2HxF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 02:53:05 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so5150502dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Nov 2012 23:53:04 -0800 (PST)
In-Reply-To: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wednesday, November 28, 2012 at 11:45 PM, Andrey Korolyov wrote:
> $ ceph osd down -
> osd.0 is already down
> $ ceph osd down ---
> osd.0 is already down
> 
> the same for ``+'', ``/'', ``%'' and so - I think that for osd subsys
> ceph cli should explicitly work only with positive integers plus zero,
> refusing all other input.

 
Yes indeed! This is already fixed in bobtail (and v0.54, maybe?), and I believe Joao went through and audited all our input parsing pretty carefully. Certainly things are much better than they were.
-Greg


