From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: ceph-osd cpu usage
Date: Thu, 15 Nov 2012 09:12:00 -0600
Message-ID: <50A50640.1040103@inktank.com>
References: <7840e3d1-17b2-4618-ae1f-ff3dbdff71f6@mailpro> <50A4DDE8.8040506@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60482 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768223Ab2KOPMC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 10:12:02 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1130258pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 07:12:02 -0800 (PST)
In-Reply-To: <50A4DDE8.8040506@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

Out of curiosity, does it help much if you disable crc32c calculations?=
=20
Use the "nocrc" option in your ceph.conf file.  I've had my eye on=20
crcutil as an alternative to how we do crc32c now.

http://code.google.com/p/crcutil/

Mark

On 11/15/2012 06:19 AM, Stefan Priebe - Profihost AG wrote:
> Am 15.11.2012 12:18, schrieb Alexandre DERUMIER:
>> cpu usage is same for read and write  ?
>
> no for read it is just around 25%. And i get "full" (limited by rbd /
> librbd) 23.000 iops per vm.
>
>
>> ----- Mail original -----
>>
>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>> =C3=80: ceph-devel@vger.kernel.org
>> Envoy=C3=A9: Jeudi 15 Novembre 2012 11:56:37
>> Objet: ceph-osd cpu usage
>>
>> Hello list,
>>
>> my main problem right now is that ceph does not scale for me (more v=
ms
>> using rbd). It does not scale as the ceph-osd is using all my CPU co=
re
>> all the time (8 cores) with just 4 SSDs. The SSDs are far away from
>> being loaded.
>>
>> What is the best way to find out what the ceph-osd process is doing =
all
>> the time?
>>
>> A gperf graph is attached.
>>
>> Greets,
>> Stefan
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
