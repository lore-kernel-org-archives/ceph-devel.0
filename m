From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CRC32 of messages
Date: Mon, 29 Jun 2015 11:51:33 +0100
Message-ID: <CAC6JEv938Os5jcNoV08vQJ6tLnR8y1kKLHR_z1iNRHXitQkMmw@mail.gmail.com>
References: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
	<90559C83A9C7FA45B5846C975DFA612DDB4C4DC457@ABGEX73E.FSC.NET>
	<CABZ+qqkjYQBQJEjHGA8xs78d59khNLf9oDjA0ORTpFG0QiGtTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:33129 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbF2Kvg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 06:51:36 -0400
Received: by laar3 with SMTP id r3so58457019laa.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 03:51:35 -0700 (PDT)
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com. [209.85.215.42])
        by mx.google.com with ESMTPSA id la10sm10648518lab.15.2015.06.29.03.51.34
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 03:51:34 -0700 (PDT)
Received: by laar3 with SMTP id r3so58456196laa.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 03:51:33 -0700 (PDT)
In-Reply-To: <CABZ+qqkjYQBQJEjHGA8xs78d59khNLf9oDjA0ORTpFG0QiGtTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 29, 2015 at 7:55 AM, Dan van der Ster <dan@vanderster.com> =
wrote:
> On Mon, Jun 29, 2015 at 8:31 AM, Da=C5=82ek, Piotr
> <Piotr.Dalek@ts.fujitsu.com> wrote:
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Erik G. Burrows
>>> Sent: Friday, June 26, 2015 6:49 PM
>>>
>>> All,
>>> Can someone explain to me the rationale for performing in-software =
CRC32
>>> hashes of all messages through the Pipe and AsyncMessage classes?
>>>
>>> On my servers, operf shows that 20% of the total CPU time in my ben=
chmark
>>> tests are being spent in the librados ceph_crc32c_sctp function. I =
can see that
>>> the library is trying to use CPU accelerations if available, but wh=
at I'd like to
>>> understand is: why checksum the messages at all?
>>
>> As Somnath already wrote, you can disable CRC checking for messages.=
 But they're also used for journals, among other things, so you'll alwa=
ys see some CPU usage spent on CRC32 calculations.
>>
>>> If the messages are local, there should not be any corruption at al=
l, and if
>>> they are coming in over IP, then the kernel and NIC should do Layer=
-2/3 CRCs
>>> and reject any corrupted packets. So why re-CRC the messages at the=
 Ceph
>>> layer?
>>
>> I can imagine data corruption coming from Ceph itself and not caught=
 by IP layers, for example due to bug in Ceph code or mainboard/RAM fai=
lure. And it's a nice debug feature you can use when dealing with low-l=
evel code.
>>
>
> That's not to mention that the TCP checksum is remarkably weak. We've
> just had an incident where a broken router was quite efficiently
> corrupting something like 1/66 packets in a way which was invisible t=
o
> the TCP checksum. Some example corruptions are here our report -- not=
e
> that it's still a work in progress:
> https://cds.cern.ch/record/2026187/files/Adler32_Data_Corruption.pdf
>
> Thankfully CRC32-C /probably/ prevented this broken router from
> corrupting our Ceph volumes.

Yes, we have our own CRC32 checksum because loooong ago (before I
started!) Sage saw a lot of network corruption that wasn't being
caught by the TCP checksums so he added some to the Ceph message
stream. I can't tell you with any authority whatsoever how common that
problem is, but I don't think we're turning them off by default in
upstream. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
