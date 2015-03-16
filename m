From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: crc error when decode_message?
Date: Mon, 16 Mar 2015 22:06:22 +0800
Message-ID: <CACJqLyZ50EkaLwSv2yEDuNq0Yj+=Og+x5gK01ao-woN1UqZPjw@mail.gmail.com>
References: <CANE=7sWQaG8PZYEU9OsjkmU6GB6jKhcnSG1cm6o38EeMb65pGw@mail.gmail.com>
	<CANE=7sXX9mFuuFGJE7edXdE2q7pt+teOjXkCgb5aWjToAYM1MA@mail.gmail.com>
	<CACJqLybJus0ijP+xB7OorE7sAkhn8DWb7MPTJAMxSOVRL1mR4g@mail.gmail.com>
	<CANE=7sWuRcWhNx9VFBDp5csKed06a2ZDXbd1am2G+6Ua=wFC4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33847 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbbCPOGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 10:06:23 -0400
Received: by pdbni2 with SMTP id ni2so59347357pdb.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2015 07:06:22 -0700 (PDT)
In-Reply-To: <CANE=7sWuRcWhNx9VFBDp5csKed06a2ZDXbd1am2G+6Ua=wFC4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinze Chi <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 16, 2015 at 10:04 PM, Xinze Chi <xmdxcxz@gmail.com> wrote:
> How to process the write request in primary?
>
> Thanks.
>
> 2015-03-16 22:01 GMT+08:00 Haomai Wang <haomaiwang@gmail.com>:
>> AFAR Pipe and AsyncConnection both will mark self fault and shutdown
>> socket and peer will detect this reset. So each side has chance to
>> rebuild the session.
>>
>> On Mon, Mar 16, 2015 at 9:19 PM, Xinze Chi <xmdxcxz@gmail.com> wrote:
>>> Such as, Client send write request to osd.0 (primary), osd.0 send
>>> MOSDSubOp to osd.1 and osd.2
>>>
>>> osd.1 send reply to osd.0 (primary), but accident happened:
>>>
>>> 1. decode_message crc error when decode reply msg
>>> or
>>> 2. the reply msg is lost when send to osd.0, so osd.0 do not receive replay msg
>>>
>>> Could anyone tell me what is the behavior if osd.0 (primary)?
>>>

osd.0 and osd.1 both will try to reconnect peer side, and the lost
message will be resend to osd.0 from osd.1

>>> Thanks
>>>
>>> 2015-03-16 20:02 GMT+08:00 Xinze Chi <xmdxcxz@gmail.com>:
>>>> hi, all:
>>>>
>>>>       I want to know what is the behavior of primary when
>>>> decode_message crc error , such as read
>>>>
>>>> ack response message from remote peer?
>>>>
>>>>       Thanks.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat



-- 
Best Regards,

Wheat
