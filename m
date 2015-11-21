From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: why my cluster become unavailable
Date: Sun, 22 Nov 2015 01:43:03 +0800
Message-ID: <CACJqLyazL_vCxpRGUGROgXN0reyJdUxL-i-OxseT5UV2cXu3pQ@mail.gmail.com>
References: <CAN4gH2NsnmOY8AcQaT245uwDh2fXmwnBTBKdP6_xKQ2M0PVeKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34022 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbbKURnE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Nov 2015 12:43:04 -0500
Received: by oies6 with SMTP id s6so82487701oie.1
        for <ceph-devel@vger.kernel.org>; Sat, 21 Nov 2015 09:43:03 -0800 (PST)
In-Reply-To: <CAN4gH2NsnmOY8AcQaT245uwDh2fXmwnBTBKdP6_xKQ2M0PVeKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Libin Wu <hzwulibin@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 19, 2015 at 11:26 PM, Libin Wu <hzwulibin@gmail.com> wrote:
> Hi, cepher
>
> I have a cluster of 6 OSD server, every server has 8 OSDs.
>
> I out 4 OSDs on every server, then my client io is blocking.
>
> I reboot my client and then create a new rbd device, but the new
> device also can't write io.
>
> Yeah, i understand that some data may lost as threee replicas of some
> object were lost, but why the cluster become unavailable?
>
> There 80 incomplete pg and 4 down+incomplete pg.
>
> Any solution i could solve the problem?

Yes, if you doesn't have a special crushmap to control the data
replcement policy, pg will lack of necessary metadata to boot. If need
to readd outed osds or force remove pg which is incomplete(hope it's
just a test).

>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
