From: Timofey Titovets <nefelim4ag@gmail.com>
Subject: Re: RBD Kernel: write_same_max_bytes and SCSI XCOPY
Date: Thu, 10 Dec 2015 00:44:17 +0300
Message-ID: <CAGqmi74aCRTi=MLcLrtDvR0B=rr7yGNzD4bdeCgLO7Xh7tNROA@mail.gmail.com>
References: <CAGqmi77oh71KZN75Ti4k7uzp=0eujrg5vWKgLnbMvhirXuDN-A@mail.gmail.com>
 <56689F07.40502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36313 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267AbbLIVo6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 16:44:58 -0500
Received: by lft93 with SMTP id 93so3064054lft.3
        for <ceph-devel@vger.kernel.org>; Wed, 09 Dec 2015 13:44:57 -0800 (PST)
In-Reply-To: <56689F07.40502@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thank you Mike, for your work & answers

2015-12-10 0:37 GMT+03:00 Mike Christie <mchristi@redhat.com>:
> On 12/09/2015 01:08 AM, Timofey Titovets wrote:
>> Hi list,
>> As i found write_same_max_bytes are equal to zero
>> if i understand correctly, it's means what RBD not support offloading
>> copy operations
>>
>
> Not yet.
>
> I did patches to support commands like write same and compare and write
> in this patchset where I made a lio rbd backend driver:
>
> http://www.spinics.net/lists/target-devel/msg10330.html
>
> but they were not accepted upstream.
>
> I am currently reworking the patches to be acceptable. Some distros did
> pick them up though so you might see them in there.
>
>
>> Is this possible to add this feature, as example for LIO with SCSI XCOPY?
>
>
> The linux kernel does yet not have xcopy support like how it supports
> write same or discard. There are patches, but it has not been merged
> upstream.
>
> However, LIO does support this command by what I guess you could call
> emulating it where if the underlying device does not support the command
> natively then LIO will perform the operations needed. It does this for
> other commands like write same too. So, even though rbd does not
> currently support these commands, you can use LIO and rbd and it will
> still execute them although it would not be offloaded like how you would
> want. For example, for write same LIO will just do multiple writes to
> the rbd device.
>



-- 
Have a nice day,
Timofey.
