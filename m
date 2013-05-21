From: Anders Saaby <anders@saaby.com>
Subject: Re: Segmentation faults in ceph-osd
Date: Tue, 21 May 2013 18:34:05 +0200
Message-ID: <98EBE255-FB43-4390-A53B-CE14CD2FE62B@saaby.com>
References: <CANBLGcybBofQqpP2wetuN+QDPO_QaX2s8AhM2WebcvW7njBd4Q@mail.gmail.com> <CAPYLRziXri6RYPZGCqQbnVS87XrnH1Bq2deX3yY4A8G5g3Yk5Q@mail.gmail.com> <CANBLGcwPMCSpXDgsXKBDQ2p-FhQNYg-FqagrUCrpa=BMTcogEg@mail.gmail.com> <CAPYLRzjiBJ7dBTibfLhPwRhCu+vEVcBCB_1dQpOKL+VT_TY2bw@mail.gmail.com> <CANBLGcyp9htDc=qZYP6iga-oSC7cGV-68F8UgWvR3rRKQhCX9A@mail.gmail.com> <CAPYLRzgd7ikRn=MoQUgazHJYUMUbzRwoH6PYJMcaBckbvdMLgg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.saaby.com ([95.170.88.191]:45482 "EHLO mail.saaby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab3EUQeN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 12:34:13 -0400
In-Reply-To: <CAPYLRzgd7ikRn=MoQUgazHJYUMUbzRwoH6PYJMcaBckbvdMLgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Emil Renner Berthing <ceph@esmil.dk>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On 21/05/2013, at 18.19, Gregory Farnum <greg@inktank.com> wrote:
> On Tue, May 21, 2013 at 9:01 AM, Emil Renner Berthing <ceph@esmil.dk>=
 wrote:
>> On 21 May 2013 17:55, Gregory Farnum <greg@inktank.com> wrote:
>>> On Tue, May 21, 2013 at 8:44 AM, Emil Renner Berthing <ceph@esmil.d=
k> wrote:
>>>> Hi Greg,
>>>>=20
>>>> Here are some more stats on our servers:
>>>> - each server has 64GB ram,
>>>> - there are 12 OSDs pr. server,
>>>> - each OSD uses around 1.5 GB of memory,
>>>> - we have 18432 PGs,
>>>> - around 5 to 10 MB writes/s is written to each OSD and almost no =
reads (yet).
>>>=20
>>> What interface are you writing with? How many OSD servers are there=
?
>>=20
>> We're using librados and there are 132 OSDs so far.
>=20
> Okay, so the allocation is happening in the depths of LevelDB =97 may=
be
> the issue is there somewhere. Are you doing anything weird with omap,
> snapshots, or xattrs?

I can help; No, we are not using omap, snaps or weird stuff with xattrs=
=2E

We are storing objects of sizes from few KB to GBs. Also, we have a qui=
rk in the application design right now, which means that we store an ob=
ject, write it again under a new name and delete the original object. -=
 if that is of any potential value to finding this.


--=20
Anders

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
