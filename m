From: Christian Brunner <christian@brunner-muc.de>
Subject: Re: Designing a cluster guide
Date: Sun, 20 May 2012 10:31:01 +0200
Message-ID: <CAJafhzTv8a6auWQAw3u2zqRDi-DR9g1b9kwXYbX+kCG0=dOofg@mail.gmail.com>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
	<4FB8A3A5.5090809@profihost.ag>
	<CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
	<4FB8AADE.1000406@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54121 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab2ETIbB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 May 2012 04:31:01 -0400
Received: by obbtb18 with SMTP id tb18so6414636obb.19
        for <ceph-devel@vger.kernel.org>; Sun, 20 May 2012 01:31:01 -0700 (PDT)
In-Reply-To: <4FB8AADE.1000406@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org, Gregory Farnum <greg@inktank.com>

2012/5/20 Stefan Priebe <s.priebe@profihost.ag>:
> Am 20.05.2012 10:19, schrieb Christian Brunner:
>
>> - Cheap Object Storage (S3):
>>
>> =A0 Many 3,5'' SATA Drives for the storage (probably in a RAID confi=
g)
>> =A0 A small and cheap SSD for the journal
>>
>> - Basic Block Storage (RBD):
>>
>> =A0 Many 2,5'' SATA Drives for the storage (RAID10 and/or mutliple O=
SDs)
>> =A0 Small MaxIOPS SSDs for each OSD journal
>>
>> - High performance Block Storage (RBD)
>>
>> =A0 Many large SATA SSDs for the storage (prbably in a RAID5 config)
>> =A0 stec zeusram ssd drive for the journal
>
> That's exactly what i thought too but then you need a seperate ceph /=
 rbd
> cluster for each type.
>
> Which will result in a minimum of:
> 3x mon servers per type
> 4x osd servers per type
> ---
>
> so you'll need a minimum of 12x osd systems and 9x mon systems.

You can arrange the storage types in different pools, so that you
don't need separate mon servers (this can be done by adjusting the
crushmap) and you could even run multiple OSDs per server.

Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
