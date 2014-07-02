From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [ceph-users] Why is librbd1 / librados2 from Firefly 20% slower
 than the one from dumpling?
Date: Wed, 02 Jul 2014 21:44:06 +0200
Message-ID: <53B46106.7050306@profihost.ag>
References: <539B11C4.1010400@profihost.ag>	<CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ@mail.gmail.com>	<53AD1411.101@profihost.ag>	<CAPYLRzhJ_3WkWSFUAx+w+gt5PTLD7SYmSyQ-xPRZ31ahN4a1Ag@mail.gmail.com>	<53B40292.2000108@profihost.ag>	<CACJqLyZYpEJYUn5m5B4LCGGfszY_xPjui5q7HShQuotBkVDt4Q@mail.gmail.com>	<53B40526.7080907@profihost.ag>	<CAPYLRziFqZYFn4E22oE+-HXXcRppzwY=h2TbDuCErSixzZ=eWQ@mail.gmail.com>	<53B456E3.1060909@profihost.ag> <CAPYLRzgZyk_qHfuEANcbLYLHXX++Lj71t5xeTxbLf9ywy6s-ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:51094 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbaGBToG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jul 2014 15:44:06 -0400
In-Reply-To: <CAPYLRzgZyk_qHfuEANcbLYLHXX++Lj71t5xeTxbLf9ywy6s-ww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi Greg,

Am 02.07.2014 21:36, schrieb Gregory Farnum:
> On Wed, Jul 2, 2014 at 12:00 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>>
>> Am 02.07.2014 16:00, schrieb Gregory Farnum:
>>
>>> Yeah, it's fighting for attention with a lot of other urgent stuff. :(
>>>
>>> Anyway, even if you can't look up any details or reproduce at this
>>> time, I'm sure you know what shape the cluster was (number of OSDs,
>>> running on SSDs or hard drives, etc), and that would be useful
>>> guidance. :)
>>
>>
>> Sure
>>
>> Number of OSDs: 24
>> Each OSD has an SSD capable of doing tested with fio before installing ceph
>> (70.000 iop/s 4k write, 580MB/s seq. write 1MB blocks)
>>
>> Single Xeon E5-1620 v2 @ 3.70GHz
>>
>> 48GB RAM
>
> Awesome, thanks.
>
> I went through the changelogs on the librados/, osdc/, and msg/
> directories to see if I could find any likely change candidates
> between Dumpling and Firefly and couldn't see any issues. :( But I
> suspect that the sharding changes coming will more than make up the
> difference, so you might want to plan on checking that out when it
> arrives, even if you don't want to deploy it to production.n

To which changes do you refer? Will they be part or backported of/to 
firefly?

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
