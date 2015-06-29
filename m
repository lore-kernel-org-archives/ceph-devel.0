From: Dan van der Ster <dan@vanderster.com>
Subject: Re: CRC32 of messages
Date: Mon, 29 Jun 2015 08:55:23 +0200
Message-ID: <CABZ+qqkjYQBQJEjHGA8xs78d59khNLf9oDjA0ORTpFG0QiGtTQ@mail.gmail.com>
References: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com> <90559C83A9C7FA45B5846C975DFA612DDB4C4DC457@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:32918 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbbF2G4G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 02:56:06 -0400
Received: by laar3 with SMTP id r3so51737100laa.0
        for <ceph-devel@vger.kernel.org>; Sun, 28 Jun 2015 23:56:04 -0700 (PDT)
Received: from mail-la0-f52.google.com (mail-la0-f52.google.com. [209.85.215.52])
        by mx.google.com with ESMTPSA id v16sm6321896lal.41.2015.06.28.23.56.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jun 2015 23:56:03 -0700 (PDT)
Received: by lacny3 with SMTP id ny3so113524596lac.3
        for <ceph-devel@vger.kernel.org>; Sun, 28 Jun 2015 23:56:02 -0700 (PDT)
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB4C4DC457@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 29, 2015 at 8:31 AM, Da=C5=82ek, Piotr
<Piotr.Dalek@ts.fujitsu.com> wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Erik G. Burrows
>> Sent: Friday, June 26, 2015 6:49 PM
>>
>> All,
>> Can someone explain to me the rationale for performing in-software C=
RC32
>> hashes of all messages through the Pipe and AsyncMessage classes?
>>
>> On my servers, operf shows that 20% of the total CPU time in my benc=
hmark
>> tests are being spent in the librados ceph_crc32c_sctp function. I c=
an see that
>> the library is trying to use CPU accelerations if available, but wha=
t I'd like to
>> understand is: why checksum the messages at all?
>
> As Somnath already wrote, you can disable CRC checking for messages. =
But they're also used for journals, among other things, so you'll alway=
s see some CPU usage spent on CRC32 calculations.
>
>> If the messages are local, there should not be any corruption at all=
, and if
>> they are coming in over IP, then the kernel and NIC should do Layer-=
2/3 CRCs
>> and reject any corrupted packets. So why re-CRC the messages at the =
Ceph
>> layer?
>
> I can imagine data corruption coming from Ceph itself and not caught =
by IP layers, for example due to bug in Ceph code or mainboard/RAM fail=
ure. And it's a nice debug feature you can use when dealing with low-le=
vel code.
>

That's not to mention that the TCP checksum is remarkably weak. We've
just had an incident where a broken router was quite efficiently
corrupting something like 1/66 packets in a way which was invisible to
the TCP checksum. Some example corruptions are here our report -- note
that it's still a work in progress:
https://cds.cern.ch/record/2026187/files/Adler32_Data_Corruption.pdf

Thankfully CRC32-C /probably/ prevented this broken router from
corrupting our Ceph volumes.

Cheers, Dan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
