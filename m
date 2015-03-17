From: Xinze Chi <xmdxcxz@gmail.com>
Subject: Fwd: Fwd: Reduce read latency and bandwidth for ec pool
Date: Tue, 17 Mar 2015 15:52:37 +0800
Message-ID: <CANE=7sWb3EXwwpEN_suc0JVNrm46YggVhO7sekG51w5reiMocg@mail.gmail.com>
References: <CANE=7sUo7tMT=kyuN86vs5b13nnqY9wpOuNuf=_z=P7UXKc+sg@mail.gmail.com>
	<CANE=7sVcY5sCaHUSFn+MDkAYzeewa767ziXXLqNiSCXhnG4s-g@mail.gmail.com>
	<5507DC67.2030800@dachary.org>
	<CANE=7sV1CQA=ZV5ELihrE4DZNGN5=4c07uP4Pv2w8LLpzqWabA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:32876 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbCQHwh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2015 03:52:37 -0400
Received: by oibu204 with SMTP id u204so1603715oib.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 00:52:37 -0700 (PDT)
In-Reply-To: <CANE=7sV1CQA=ZV5ELihrE4DZNGN5=4c07uP4Pv2w8LLpzqWabA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

---------- Forwarded message ----------
=46rom: Xinze Chi <xmdxcxz@gmail.com>
Date: 2015-03-17 15:52 GMT+08:00
Subject: Re: Fwd: Reduce read latency and bandwidth for ec pool
To: Loic Dachary <loic@dachary.org>


Yes, In my VDI environment, client read 4k every time. If we can read
object from only shard. It would reduce the latency and bandwidth a
lot.

Thanks.

2015-03-17 15:48 GMT+08:00 Loic Dachary <loic@dachary.org>:
> Hi,
>
> On 17/03/2015 08:27, Xinze Chi wrote:
>> hi, loic:
>>
>>    I have an idea which could reduce read latency and bandwidth for =
ec pool.
>>
>>    But, I don't know whether it is feasible.
>>
>>    Such as ec pool stripe_width =3D 16384 =3D 4 * 4096,  K =3D 4, M =
=3D2
>>
>>    So ceph will partition the total of 16384 bytes to 4 data chunk,
>> and encoding 2 parity chunk
>>
>>    shard_0 include 0 - (4096-1) in original data;
>>    shard_1 include 4096 - (4096*2 - 1) in original data;
>>    shard_2 include 4096*2 - (4096 * 3 -1) in original data;
>>    shard_3 include 4096*3 - (4096 * 4 - 1) in original data
>>    shard_4 include parity chunk
>>    shard_5 include parity chunk
>>
>>     Now if client read (offset 0, len 4096) from object, it should
>> read 4 shard (from 0-3) and decode all this 4 chunk.
>>
>>     But, this example, maybe we can compute the destination shard
>> based on ec pool config ,read offset and read len , we only read
>>
>> shard_0 and return it to client, because shard_0 has include all dat=
a
>> as client need.
>
> That optimization makes sense to me. I guess you're interested in hav=
ing small objects in the pool and only read a few bytes at a time ?
>
> Cheers
>
>>
>>     Wait for your comment.
>>
>>     Thanks.
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
