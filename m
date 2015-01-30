From: Bassam Tabbara <bassamtabbara@hotmail.com>
Subject: Re: Supporting partial writes for EC backend
Date: Fri, 30 Jan 2015 10:00:23 -0800
Message-ID: <BLU436-SMTP163B80C7054F010E6535A1EA7310@phx.gbl>
References: <BLU436-SMTP14889EB55A90A7C338308A9A7310@phx.gbl> <CA+4uBUZWqWqy=gddVB=sWT7PsLsvq4mYVMn8_-tjM3sUL50Qsw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s10.hotmail.com ([65.55.111.149]:49675 "EHLO
	BLU004-OMC4S10.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752723AbbA3SA3 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Jan 2015 13:00:29 -0500
In-Reply-To: <CA+4uBUZWqWqy=gddVB=sWT7PsLsvq4mYVMn8_-tjM3sUL50Qsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I=E2=80=99d like to explore adding a new EC pool type as you suggest. T=
he idea is to have RBD sit on-top of a fully functional EC backend. Jus=
t as with RAID6 arrays today some applications are aware of the read-mo=
dify-write penalty and they could optimize for it.=20

I=E2=80=99m new to ceph, so if you can point me in the right direction =
I would appreciate it. Do you think this is something that could be imp=
lemented as a modification to the existing ECBackend or is this a new b=
ackend. I=E2=80=99m happy to jump on a quick call if it makes things ea=
sier.

> On Jan 30, 2015, at 8:59 AM, Samuel Just <sam.just@inktank.com> wrote=
:
>=20
> Basically, it's an architectural choice:
>=20
> https://github.com/ceph/ceph/blob/master/doc/dev/osd_internals/erasur=
e_coding/pgbackend.rst#client-writes
>=20
> If we wanted to support partial writes, we'd probably want to
> introduce a second EC pool type with different tradeoffs.  Note, you
> can get slow partial writes on an EC pool by placing a replicated
> cache in front.
> -Sam
>=20
> On Fri, Jan 30, 2015 at 8:36 AM, Bassam Tabbara
> <bassamtabbara@hotmail.com> wrote:
>> Hello,
>>=20
>> I realize that the EC Backend does not support all operations like p=
artial writes, truncate, and others. I=E2=80=99d like to understand whe=
ther adding the missing operations is something that is architecturally=
 possible, or if this is a limitation of the architecture / approach. C=
an someone shed some light on this?
>>=20
>> I realize that partial writes are going to be slow/inefficient on an=
 EC backend compared to a replicated backend.
>>=20
>> Thanks!
>> Bassam--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
