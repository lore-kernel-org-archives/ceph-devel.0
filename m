From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: improve speed with auth supported=none
Date: Mon, 12 Nov 2012 22:57:19 +0100
Message-ID: <50A170BF.5030402@profihost.ag>
References: <50A117B9.4060804@profihost.ag> <CAOLwVU=2BNvOs1SUqVrXS9Wajng5zk0mebnK3cZnZFO=rzrGbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60633 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab2KLV5S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 16:57:18 -0500
In-Reply-To: <CAOLwVU=2BNvOs1SUqVrXS9Wajng5zk0mebnK3cZnZFO=rzrGbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>

Thanks,

this gives another burst for iops. I'm now at 23.000 iops ;-) So for=20
random 4k iops ceph auth and especially the logging is a lot of overhea=
d.

Greets,
Stefan
Am 12.11.2012 19:26, schrieb S=E9bastien Han:
> I guess you can refer to that link on the list:
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/9776
>
> btw do you get 5000 iop/s on the rbd kernel or on a vm disk?
>
> cheers.
>
>
> On Mon, Nov 12, 2012 at 4:37 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Hello list,
>>
>> i'm still trying to improve ceph speed. Disable logging on host and =
rbd
>> client gives me additional 5000 iop/s which is great.
>>
>> But i also wanted to try disabling authentication using:
>> auth supported=3Dnone
>>
>> How does this work? Do i just have to place this line under global s=
ection
>> in ceph.conf?
>>
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
