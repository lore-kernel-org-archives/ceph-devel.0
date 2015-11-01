From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: why we use two ObjectStore::Transaction in ReplicatedBackend::submit_transaction?
Date: Sun, 1 Nov 2015 11:40:40 +0800
Message-ID: <CANE=7sUagDEN+hROu176_+9-PftBH-_iReSFsJa+kwW6ceJFXQ@mail.gmail.com>
References: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com>
	<alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net>
	<CALZt5jwEocBc2uqvec11ynWVWu=M=pG5wZSw_quFBVoaCgZcZQ@mail.gmail.com>
	<alpine.DEB.2.00.1510311340560.19081@cobra.newdream.net>
	<CANE=7sWnQHAY=6GbXPzMM63qENZFRyiuKT6L2VHHG7yppUmA5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35778 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbKADkl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Oct 2015 23:40:41 -0400
Received: by oifu63 with SMTP id u63so79832740oif.2
        for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2015 20:40:40 -0700 (PDT)
In-Reply-To: <CANE=7sWnQHAY=6GbXPzMM63qENZFRyiuKT6L2VHHG7yppUmA5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ning Yao <zay11022@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If we keep them separate and pass them to
ObjectStore::queue_transactions() ,the cpu usage of
ObjectStore::queue_transactions() would take up from 6.03% to 6.76%
compared with re-using op_t items.

2015-11-01 11:05 GMT+08:00 =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@gmail.c=
om>:
> Yes, I think so.
> keeping them separate and pass them to
> ObjectStore::queue_transactions() would increase the time on
> transaction encode process and exhaust more cpu.
>
> The transaction::append holds 0.8% cpu on my environment.
> The transaction encoding is also really a bottleneck which process
> holds 1.8% cpu on my environment.
>
> 2015-11-01 4:42 GMT+08:00 Sage Weil <sage@newdream.net>:
>> On Sat, 31 Oct 2015, Ning Yao wrote:
>>> Yeah, since issue_op is called before log_operation, we may conside=
r
>>> to reuse op_t after sent encoded op_t to the wire. local_t.append()=
,
>>> at least, does copy the op_bl in op_t transaction and we may avoid
>>> this memory copy, and if we can avoid this append operation as well=
 as
>>> in sub_op_modify_impl(), it, at least, improves the performance 1%~=
2%
>>> under my testing environment using ssd as Filestore backend.
>>> The only difference we find in this path is that local_t should be
>>> done first, but actually it seems that the order of the transaction=
 is
>>> not quite important. If so, we may refactor and improve this?
>>
>> I seem to recall that in teh EC case the order does matter (I had sw=
itched
>> the append order when trying to fix this before but had to revert be=
cause
>> things broke).
>>
>> And I'm a bit nervous about re-using local_t and relying on the send=
 vs
>> submit timing.  Is it not practical to keep them separate and
>> pass them both down to ObjectStore::queue_transactions()?
>>
>> sage
>
>
>
> --
> Regards,
> xinze



--=20
Regards,
xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
