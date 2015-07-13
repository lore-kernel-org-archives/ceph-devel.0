From: =?utf-8?B?546LIOWBpQ==?= <jason.jianwang@gmail.com>
Subject: Re: rads gateway Parallel Uploads
Date: Mon, 13 Jul 2015 02:37:46 -0400
Message-ID: <0BB68A07-61F5-46D5-AD60-E6F9A19A8741@gmail.com>
References: <0142046B-030E-4E7D-96FB-C7C519E4B0FC@gmail.com> <55A357A3.7060002@42on.com> <D891CEBE-6A3A-468E-940A-A57B93110D02@gmail.com> <55A35C7A.1000000@42on.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35986 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbbGMGhu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 02:37:50 -0400
Received: by pachj5 with SMTP id hj5so26729543pac.3
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jul 2015 23:37:49 -0700 (PDT)
In-Reply-To: <55A35C7A.1000000@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

Got it.=20
Thanks
Jian
> On Jul 13, 2015, at 2:36 AM, Wido den Hollander <wido@42on.com> wrote=
:
>=20
>=20
>=20
> On 13-07-15 08:32, =E7=8E=8B =E5=81=A5 wrote:
>> Does rados gateway support object composition? Like Google could sto=
rage, user can upload divide a large object into several objects and up=
load parallel, then combine them as a single object.
>> Thanks
>> Jian
>=20
> Yes, that is how multipart uploads work. The RADOS Gatewas supports i=
t.
>=20
> Wido
>=20
>>> On Jul 13, 2015, at 2:16 AM, Wido den Hollander <wido@42on.com> wro=
te:
>>>=20
>>>=20
>>>=20
>>> On 13-07-15 08:07, =E7=8E=8B =E5=81=A5 wrote:
>>>> Hello Cepher,
>>>> I am working on prorting Google Cloud Storage API to rados gateway=
 and I notice that Google Cloud Storage support parallel uploads as bel=
ow:
>>>> "Object composition enables a simple mechanism for uploading an ob=
ject in parallel: simply divide your data into as many chunks as requir=
ed to fully utilize your available bandwidth, upload each chunk to a di=
stinct object, compose your final object, and delete any temporary obje=
cts. =E2=80=9C
>>>> So I am wondering whether radios gateway support the similar featu=
re to let user parallel upload large objects?
>>>=20
>>> Yes, you can do a multipart upload with the RADOS gateway, no probl=
em.
>>>=20
>>> Wido
>>>=20
>>>> Thanks
>>>> Jian
>>>>=20
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>=20
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
