From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: crc error when decode_message?
Date: Mon, 16 Mar 2015 22:01:58 +0800
Message-ID: <CACJqLybJus0ijP+xB7OorE7sAkhn8DWb7MPTJAMxSOVRL1mR4g@mail.gmail.com>
References: <CANE=7sWQaG8PZYEU9OsjkmU6GB6jKhcnSG1cm6o38EeMb65pGw@mail.gmail.com>
	<CANE=7sXX9mFuuFGJE7edXdE2q7pt+teOjXkCgb5aWjToAYM1MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34604 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbbCPOB7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 10:01:59 -0400
Received: by pacwe9 with SMTP id we9so65815001pac.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2015 07:01:59 -0700 (PDT)
In-Reply-To: <CANE=7sXX9mFuuFGJE7edXdE2q7pt+teOjXkCgb5aWjToAYM1MA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinze Chi <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

AFAR Pipe and AsyncConnection both will mark self fault and shutdown
socket and peer will detect this reset. So each side has chance to
rebuild the session.

On Mon, Mar 16, 2015 at 9:19 PM, Xinze Chi <xmdxcxz@gmail.com> wrote:
> Such as, Client send write request to osd.0 (primary), osd.0 send
> MOSDSubOp to osd.1 and osd.2
>
> osd.1 send reply to osd.0 (primary), but accident happened:
>
> 1. decode_message crc error when decode reply msg
> or
> 2. the reply msg is lost when send to osd.0, so osd.0 do not receive replay msg
>
> Could anyone tell me what is the behavior if osd.0 (primary)?
>
> Thanks
>
> 2015-03-16 20:02 GMT+08:00 Xinze Chi <xmdxcxz@gmail.com>:
>> hi, all:
>>
>>       I want to know what is the behavior of primary when
>> decode_message crc error , such as read
>>
>> ack response message from remote peer?
>>
>>       Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
