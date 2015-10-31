From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: why we use two ObjectStore::Transaction in ReplicatedBackend::submit_transaction?
Date: Sun, 1 Nov 2015 00:26:54 +0800
Message-ID: <CANE=7sVCzfm9LhqGyf6CLsgL=FtWbqEg72e4Q7aOcMwWANDi2A@mail.gmail.com>
References: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com>
	<alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net>
	<CALZt5jwEocBc2uqvec11ynWVWu=M=pG5wZSw_quFBVoaCgZcZQ@mail.gmail.com>
	<CO1PR02MB208AE0D8B1C669E5E48DC93F42E0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34874 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbJaQ0z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Oct 2015 12:26:55 -0400
Received: by oifu63 with SMTP id u63so75734567oif.2
        for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2015 09:26:54 -0700 (PDT)
In-Reply-To: <CO1PR02MB208AE0D8B1C669E5E48DC93F42E0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Ning Yao <zay11022@gmail.com>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeh, But using two transaction, I think it would malloc more memory
and exhaust cpu in encode process. Because it would not reuse the
append_buffer in bufferlist. I would give out the performance data
after.

2015-10-31 23:58 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
> BTW, latest code base is already separating out 2 transaction. No mor=
e append call..
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Ning Yao
> Sent: Saturday, October 31, 2015 8:35 AM
> To: Sage Weil
> Cc: =E6=B1=A0=E4=BF=A1=E6=B3=BD; ceph-devel@vger.kernel.org
> Subject: Re: why we use two ObjectStore::Transaction in ReplicatedBac=
kend::submit_transaction?
>
> Yeah, since issue_op is called before log_operation, we may consider =
to reuse op_t after sent encoded op_t to the wire. local_t.append(), at=
 least, does copy the op_bl in op_t transaction and we may avoid this m=
emory copy, and if we can avoid this append operation as well as in sub=
_op_modify_impl(), it, at least, improves the performance 1%~2% under m=
y testing environment using ssd as Filestore backend.
> The only difference we find in this path is that local_t should be do=
ne first, but actually it seems that the order of the transaction is no=
t quite important. If so, we may refactor and improve this?
> Regards
> Ning Yao
>
>
> 2015-10-31 21:18 GMT+08:00 Sage Weil <sage@newdream.net>:
>> On Sat, 31 Oct 2015, ??? wrote:
>>> hi, all:
>>>
>>>     There are two ObjectStore::Transaction in
>>> ReplicatedBackend::submit_transaction, one is op_t and the other on=
e
>>> is local_t. Is that something
>>>     critilal logic we should consider?
>>>
>>>     If we could reuse variable op_t it would be great. Because it i=
s
>>> expensive to calling local_t.append(*op_t).
>>>
>>>     There are similar logic in ReplicatedBackend::sub_op_modify_imp=
l.
>>
>> The local_t items are only applied locally; the op_t items are encod=
ed
>> and sent over the wire to the replicas.
>>
>> If append() is expensive we should just refactor to avoid that.  IIR=
C
>> I got partway down this path but apparently didn't finish.  The
>> ObjectStore interface takes a list of transactions to apply, so I
>> think it's just a matter of refactoring the interfaces a bit...?
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html



--=20
Regards,
xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
