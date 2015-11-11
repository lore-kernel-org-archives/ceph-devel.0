From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: disabling buffer::raw crc cache
Date: Wed, 11 Nov 2015 16:03:21 +0800
Message-ID: <CANE=7sWCUw5PiKwQqqq__6XpyF89jk1v_rsNgnfX10UtkRxXpQ@mail.gmail.com>
References: <D2682DD5.8AA1%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34598 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbbKKIDV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 03:03:21 -0500
Received: by obbza9 with SMTP id za9so17070373obb.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2015 00:03:21 -0800 (PST)
In-Reply-To: <D2682DD5.8AA1%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ah, I confuse that why the crc cache logic would exhaust so much cpu.

2015-11-11 15:27 GMT+08:00 Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>:
> Hello, Guys!
>
> While running CPU bound 4k block workload, I found that disabling crc
> cache in the buffer::raw gives around 7% performance improvement.
>
> If there is no strong use case which benefit from that cache, we woul=
d
> remove it entirely, otherwise conditionally enable it based on the ob=
ject
> size.
>
> =E2=80=B9
> Evgeniy
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards,
xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
