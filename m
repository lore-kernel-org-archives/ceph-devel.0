From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: improve speed with auth supported=none
Date: Mon, 12 Nov 2012 19:26:27 +0100
Message-ID: <CAOLwVU=2BNvOs1SUqVrXS9Wajng5zk0mebnK3cZnZFO=rzrGbw@mail.gmail.com>
References: <50A117B9.4060804@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40104 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab2KLS0t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 13:26:49 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so4884227lbo.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Nov 2012 10:26:48 -0800 (PST)
In-Reply-To: <50A117B9.4060804@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I guess you can refer to that link on the list:
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/9776

btw do you get 5000 iop/s on the rbd kernel or on a vm disk?

cheers.


On Mon, Nov 12, 2012 at 4:37 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hello list,
>
> i'm still trying to improve ceph speed. Disable logging on host and rbd
> client gives me additional 5000 iop/s which is great.
>
> But i also wanted to try disabling authentication using:
> auth supported=none
>
> How does this work? Do i just have to place this line under global section
> in ceph.conf?
>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
