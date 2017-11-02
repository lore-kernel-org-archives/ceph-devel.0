From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: Re: cephfs performance
Date: Thu, 2 Nov 2017 17:48:18 +0800
Message-ID: <67B12E11-4188-4A38-B54F-1D8E47A91CED@gmail.com>
References: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
 <CA+2bHPYe+krYUmrdQ58=TAJJ6UAODw36gx2_Qzv8wxnhnYn_rA@mail.gmail.com>
 <CAB7xdi=C8fPuKy=R9xd4weykpDPsgvfnXcMZkvB+YNaaX1oJ8A@mail.gmail.com>
 <CA+2bHPbbFttvv2Ci6W59g-raZqVCDaZgrQ-BPpYQvs_0XTcdNA@mail.gmail.com>
 <CAB7xdin_PNRCCqf1nO0LVb4P8fUXMJqwBqXHavrQU_VVi6SuNg@mail.gmail.com>
 <CA+2bHPbSeg0t4M41XL+rdjuT2fmz8WnU1N_G0N5a2zhNNqOSng@mail.gmail.com>
 <CAB7xdikWd6nuUJy96BQJogTohWzZBotsy+OF7jrgVip7AqEMpw@mail.gmail.com>
 <CA+2bHPZC2eQ=dS4v1ECQUEu+WWv7eRrAeCFbf4smbBD+nbmeDA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:44905 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755356AbdKBJsV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Nov 2017 05:48:21 -0400
Received: by mail-pg0-f47.google.com with SMTP id j3so4610999pga.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Nov 2017 02:48:21 -0700 (PDT)
In-Reply-To: <CA+2bHPZC2eQ=dS4v1ECQUEu+WWv7eRrAeCFbf4smbBD+nbmeDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <ukernel@gmail.com>

Hi Patrick,

sorry to dig out this old email.
you said two clients may write same file at same time only if no any =
clients got =A1=B0buffer/cache=A1=B1 capability.
here my question is:
the two client would got two different =A1=B0mtime=A1=B1 of that inode, =
since they can make =A1=B0Fw=A1=B1 cap dirty.=20
how would mds behave when the two client flushes the dirty caps?

Regards,
Dongdong


> =D4=DA 2017=C4=EA7=D4=C222=C8=D5=A3=AC=C9=CF=CE=E72:55=A3=ACPatrick =
Donnelly <pdonnell@redhat.com> =D0=B4=B5=C0=A3=BA
>=20
> Hi Sheng,
>=20
> Sorry I misspoke in my previous email. The clients may all have the
> capability to read and write but none of them will be able to
> **cache** reads/writes or **buffer** writes. They rely on synchronous
> read/write with the OSDs for consistency/atomicity.
>=20
> On Fri, Jul 21, 2017 at 9:19 AM, sheng qiu <herbert1984106@gmail.com> =
wrote:
>> so when multiple write clients or a mix of read and write clients
>> accessing same file, the previous cached data of this file on all
>> clients will be revoked.
>=20
> Yes.
>=20
>> And the following multi-clients' write or mixed read and write
>> accessing to that file will become synchronous.
>=20
> Writes/reads are become synchronous, yes.
>=20
>> On Tue, Jul 18, 2017 at 9:41 AM, Patrick Donnelly =
<pdonnell@redhat.com> wrote:
>>> On Tue, Jul 18, 2017 at 9:17 AM, sheng qiu =
<herbert1984106@gmail.com> wrote:
>>>> Hi Patrick,
>>>>=20
>>>> thanks for your quick response.
>>>> just one concern, if disable direct I/O, multiple clients access =
same
>>>> file via different mount point on different machines, will it cause
>>>> data inconsistency?
>>>=20
>>> No, but you'll still effectively have synchronous I/O because only =
one
>>> writer will have write capabilities from the MDS.
>>>=20
>>> --
>>> Patrick Donnelly
>=20
>=20
>=20
> --=20
> Patrick Donnelly
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

