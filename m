From: Bassam Tabbara <bassamtabbara@hotmail.com>
Subject: Re: Supporting partial writes for EC backend
Date: Fri, 30 Jan 2015 10:58:39 -0800
Message-ID: <BLU436-SMTP48BAFD96E02F69EE6BDE18A7310@phx.gbl>
References: <BLU436-SMTP14889EB55A90A7C338308A9A7310@phx.gbl> <CA+4uBUZWqWqy=gddVB=sWT7PsLsvq4mYVMn8_-tjM3sUL50Qsw@mail.gmail.com> <BLU436-SMTP163B80C7054F010E6535A1EA7310@phx.gbl> <CA+4uBUbzpHKF0ATmgUztZ4hzGm3XhkR1caB8Cd=k73FZeNLNnw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s12.hotmail.com ([65.55.111.151]:60073 "EHLO
	BLU004-OMC4S12.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752604AbbA3S6p convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Jan 2015 13:58:45 -0500
In-Reply-To: <CA+4uBUbzpHKF0ATmgUztZ4hzGm3XhkR1caB8Cd=k73FZeNLNnw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks, I=E2=80=99ll take a look at osd_internals.=20

Are you saying that a cache tier =E2=80=94> EC Pool is good enough? Wha=
t if any is the downside to using a cache tier ontop of an EC pool? I a=
ssume that the size of cache is going to be important, and so is the mi=
gration algorithm between the cache tier and the backing tier.=09

> On Jan 30, 2015, at 10:49 AM, Samuel Just <sam.just@inktank.com> wrot=
e:
>=20
> This would need to be a new backend, and it's going to be a massive
> amount of work.  You want to start by reading and understanding all o=
f
> the docs in osd_internals.  I also suspect you'll get a lot of what
> you need from using a replicated cache in front of an EC pool.
> -Sam
>=20
> On Fri, Jan 30, 2015 at 10:00 AM, Bassam Tabbara
> <bassamtabbara@hotmail.com> wrote:
>> I=E2=80=99d like to explore adding a new EC pool type as you suggest=
=2E The idea is to have RBD sit on-top of a fully functional EC backend=
=2E Just as with RAID6 arrays today some applications are aware of the =
read-modify-write penalty and they could optimize for it.
>>=20
>> I=E2=80=99m new to ceph, so if you can point me in the right directi=
on I would appreciate it. Do you think this is something that could be =
implemented as a modification to the existing ECBackend or is this a ne=
w backend. I=E2=80=99m happy to jump on a quick call if it makes things=
 easier.
>>=20
>>> On Jan 30, 2015, at 8:59 AM, Samuel Just <sam.just@inktank.com> wro=
te:
>>>=20
>>> Basically, it's an architectural choice:
>>>=20
>>> https://github.com/ceph/ceph/blob/master/doc/dev/osd_internals/eras=
ure_coding/pgbackend.rst#client-writes
>>>=20
>>> If we wanted to support partial writes, we'd probably want to
>>> introduce a second EC pool type with different tradeoffs.  Note, yo=
u
>>> can get slow partial writes on an EC pool by placing a replicated
>>> cache in front.
>>> -Sam
>>>=20
>>> On Fri, Jan 30, 2015 at 8:36 AM, Bassam Tabbara
>>> <bassamtabbara@hotmail.com> wrote:
>>>> Hello,
>>>>=20
>>>> I realize that the EC Backend does not support all operations like=
 partial writes, truncate, and others. I=E2=80=99d like to understand w=
hether adding the missing operations is something that is architectural=
ly possible, or if this is a limitation of the architecture / approach.=
 Can someone shed some light on this?
>>>>=20
>>>> I realize that partial writes are going to be slow/inefficient on =
an EC backend compared to a replicated backend.
>>>>=20
>>>> Thanks!
>>>> Bassam--
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
