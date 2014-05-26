From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Questions of KeyValueStore (leveldb) backend
Date: Mon, 26 May 2014 17:29:40 +0800
Message-ID: <CACJqLyYrnk4a74nQ+cmP5bqi2WwOMCHTR+Wrm=Qt55Ar+sdL0w@mail.gmail.com>
References: <BLU436-SMTP4071B1A51539EAA2F9D7ECDF3B0@phx.gbl>
	<CACJqLyZYe6+CBrB49B5TnyahsT6387-bWDXCQ6JCYcJGP8iyJA@mail.gmail.com>
	<538307F4.8090101@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35505 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaEZJ3p convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 May 2014 05:29:45 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so4044870wib.4
        for <ceph-devel@vger.kernel.org>; Mon, 26 May 2014 02:29:41 -0700 (PDT)
In-Reply-To: <538307F4.8090101@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Guang Yang <yguang11@outlook.com>, Ceph-devel <ceph-devel@vger.kernel.org>

On Mon, May 26, 2014 at 5:23 PM, Wido den Hollander <wido@42on.com> wro=
te:
> On 05/26/2014 06:55 AM, Haomai Wang wrote:
>>
>> On Mon, May 26, 2014 at 9:46 AM, Guang Yang <yguang11@outlook.com> w=
rote:
>>>
>>> Hello Haomai,
>>> We are evaluating the key-value store backend which comes along wit=
h
>>> Firefly release (thanks for implementing it in Ceph), it is very pr=
omising
>>> for a couple of our use cases, after going through the related code=
 change,
>>> I have a couple of questions which needs your help:
>>>    1. One observation is that, for object larger than 1KB, it will =
be
>>> striped to multiple chunks (k-v in the leveldb table), with one str=
ip as 1KB
>>> size. Is there any particular reason we choose 1KB as the strip siz=
e (and I
>>> didn=E2=80=99t find a configuration to tune this value)?
>>
>>
>> 1KB is not a serious value, this value can be configured in the near
>> future.
>>
>
> So that is currently hardcoded? I can't find any reference to it in
> config_opts.h

Yes

>
>
>>>
>>>    2. This is properly a leveldb question, do we expect performance
>>> degradation as the leveldb instance keeps increasing (e.g. several =
TB)?
>>
>>
>> Ceph OSD is expected to own a physical disk, normally is several
>> TB(1-4TB). LevelDB can take it easy. Especially we use it to store
>> large value(compared to normal application usage).
>>
>
> With a large value you mean something like 4MB? The regular strip-siz=
e for
> RBD, CephFS and such?

Not 4MB, it should be 4KB matching the default page size in kernel. Or
4MB for radosgw goal.
I want to match the operation "set_alloc_size" and make it better for w=
orkload.


>
>>>
>>> Thanks,
>>> Guang
>>
>>
>>
>>
>
>
> --
> Wido den Hollander
> 42on B.V.
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
