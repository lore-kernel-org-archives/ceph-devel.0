From: =?utf-8?B?546LIOWBpQ==?= <jason.jianwang@gmail.com>
Subject: Re: rads gateway Parallel Uploads
Date: Mon, 13 Jul 2015 02:32:06 -0400
Message-ID: <D891CEBE-6A3A-468E-940A-A57B93110D02@gmail.com>
References: <0142046B-030E-4E7D-96FB-C7C519E4B0FC@gmail.com> <55A357A3.7060002@42on.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33901 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbbGMGcJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 02:32:09 -0400
Received: by pdbep18 with SMTP id ep18so219866210pdb.1
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jul 2015 23:32:09 -0700 (PDT)
In-Reply-To: <55A357A3.7060002@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

Does rados gateway support object composition? Like Google could storag=
e, user can upload divide a large object into several objects and uploa=
d parallel, then combine them as a single object.
Thanks
Jian
> On Jul 13, 2015, at 2:16 AM, Wido den Hollander <wido@42on.com> wrote=
:
>=20
>=20
>=20
> On 13-07-15 08:07, =E7=8E=8B =E5=81=A5 wrote:
>> Hello Cepher,
>> I am working on prorting Google Cloud Storage API to rados gateway a=
nd I notice that Google Cloud Storage support parallel uploads as below=
:
>> "Object composition enables a simple mechanism for uploading an obje=
ct in parallel: simply divide your data into as many chunks as required=
 to fully utilize your available bandwidth, upload each chunk to a dist=
inct object, compose your final object, and delete any temporary object=
s. =E2=80=9C
>> So I am wondering whether radios gateway support the similar feature=
 to let user parallel upload large objects?
>=20
> Yes, you can do a multipart upload with the RADOS gateway, no problem=
=2E
>=20
> Wido
>=20
>> Thanks
>> Jian
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
