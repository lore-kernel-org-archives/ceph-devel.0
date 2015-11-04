From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: ceph encoding optimization
Date: Wed, 4 Nov 2015 23:33:30 +0800
Message-ID: <CANE=7sVGYGX1fPoHETWnXCBDtGEB2DivQVowor77CEKVtXH1Ew@mail.gmail.com>
References: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com>
	<CAJ4mKGYeEHiVL+6V0BQFq4bcZU1nP9Q0YAd2_OkiP8ZR9h+9Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:32950 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030324AbbKDPdc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Nov 2015 10:33:32 -0500
Received: by obbww6 with SMTP id ww6so15759877obb.0
        for <ceph-devel@vger.kernel.org>; Wed, 04 Nov 2015 07:33:31 -0800 (PST)
In-Reply-To: <CAJ4mKGYeEHiVL+6V0BQFq4bcZU1nP9Q0YAd2_OkiP8ZR9h+9Jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I agree with pg_stat_t (and friends) is a good first start.
The eversion_t and utime_t are also good choice to start because they
are used at many places.

2015-11-04 23:07 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> On Wed, Nov 4, 2015 at 7:00 AM, =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz@=
gmail.com> wrote:
>> hi, all:
>>
>>      I am focus on the cpu usage of ceph now. I find the struct (suc=
h
>> as pg_info_t , transaction and so on) encode and decode exhaust too
>> much cpu resource.
>>
>>      For now, we should encode every member variable one by one whic=
h
>> calling encode_raw finally. When there are many members, we should
>> encode it many times. But I think, we could reduce some in some case=
s.
>>
>>      For example , struct A { int a; int b; int c }; ceph would
>> encoding int a , and then encode int b , finally int c. But for this
>> case , we could calling bufferlist.append((char *)(&a), sizeof(A))
>> because there are not padding bytes in this struct.
>>
>>      I use the above optimization, the cpu usage of object_stat_sum_=
t
>> encoding decrease from 0.5% to 0% (I could not see any using perf
>> tools).
>>
>>      This is only a case, so I think we could do similar optimizatio=
n
>> other struct. I think we should pay attention to the padding in
>> struct.
>
> The problem with this approach is that the encoded versions need to b=
e
> platform-independent =E2=80=94 they are shared over the wire and writ=
ten to
> disks that might get transplanted to different machines. Apart from
> padding bytes, we also need to worry about endianness of the machine,
> etc. *And* we often mutate structures across versions in order to add
> new abilities, relying on the encode-decode process to deal with any
> changes to the system. How could we deal with that if just dumping th=
e
> raw memory?
>
> Now, maybe we could make these changes on some carefully-selected
> structs, I'm not sure. But we'd need a way to pick them out, guarante=
e
> that we aren't breaking interoperability concerns, etc; and it would
> need to be something we can maintain as a group going forward. I'm no=
t
> sure how to satisfy those constraints without burning a little extra
> CPU. :/
> -Greg



--=20
Regards,
xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
