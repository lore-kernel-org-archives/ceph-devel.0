From: Anders Saaby <anders@saaby.com>
Subject: Re: Segmentation faults in ceph-osd
Date: Tue, 21 May 2013 23:27:30 +0200
Message-ID: <10F53AF8-8BFF-4378-ACBC-C19C929FB9A8@saaby.com>
References: <CANBLGcybBofQqpP2wetuN+QDPO_QaX2s8AhM2WebcvW7njBd4Q@mail.gmail.com> <CAPYLRziXri6RYPZGCqQbnVS87XrnH1Bq2deX3yY4A8G5g3Yk5Q@mail.gmail.com> <CANBLGcwPMCSpXDgsXKBDQ2p-FhQNYg-FqagrUCrpa=BMTcogEg@mail.gmail.com> <CAPYLRzjiBJ7dBTibfLhPwRhCu+vEVcBCB_1dQpOKL+VT_TY2bw@mail.gmail.com> <CANBLGcyp9htDc=qZYP6iga-oSC7cGV-68F8UgWvR3rRKQhCX9A@mail.gmail.com> <CAPYLRzgd7ikRn=MoQUgazHJYUMUbzRwoH6PYJMcaBckbvdMLgg@mail.gmail.com> <98EBE255-FB43-4390-A53B-CE14CD2FE62B@saaby.com> <CA+4uBUY4YkSGJ-9rC0JpMfP-vE5uL2gbPOoEynK8ZSzs1StjGw@mail.gmail.com> <CANBLGcw+=8JMi0ihwm-qgALE9LjqzViB2t7OcQKb3g5QsMXDWQ@mail.gmail.com> <CA+4uBUbH6QXjZrAed5PetFYoRj+nPf-scBhFgCemVAo5KZSLyQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.saaby.com ([95.170.88.191]:45789 "EHLO mail.saaby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab3EUV1r convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 17:27:47 -0400
In-Reply-To: <CA+4uBUbH6QXjZrAed5PetFYoRj+nPf-scBhFgCemVAo5KZSLyQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Emil Renner Berthing <ceph@esmil.dk>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 21/05/2013, at 21.00, Samuel Just <sam.just@inktank.com> wrote:
> How large are the xattrs?
> -Sam

Sam,

They are quite small, as far as I can see from 10-50 chars each.

However, as you just explained on irc, our current unbounded 1:1 files =
vs. objects aproach, which in rare cases leads to ~25GB large objects, =
is not a good idea.. Could those large objects be what triggers the lar=
ge leveldb allocation (and eventuelly the segfault)?=20


--=20
Anders

> On Tue, May 21, 2013 at 10:13 AM, Emil Renner Berthing <ceph@esmil.dk=
> wrote:
>> On 21 May 2013 19:05, Samuel Just <sam.just@inktank.com> wrote:
>>> Do you use xattrs at all?
>>=20
>> Yes, on each object we set between 2 to 4 attributes at write time
>> which are then left unchanged.
>> /Emil
>>=20
>>> -Sam
>>>=20
>>> On Tue, May 21, 2013 at 9:34 AM, Anders Saaby <anders@saaby.com> wr=
ote:
>>>> On 21/05/2013, at 18.19, Gregory Farnum <greg@inktank.com> wrote:
>>>>> On Tue, May 21, 2013 at 9:01 AM, Emil Renner Berthing <ceph@esmil=
=2Edk> wrote:
>>>>>> On 21 May 2013 17:55, Gregory Farnum <greg@inktank.com> wrote:
>>>>>>> On Tue, May 21, 2013 at 8:44 AM, Emil Renner Berthing <ceph@esm=
il.dk> wrote:
>>>>>>>> Hi Greg,
>>>>>>>>=20
>>>>>>>> Here are some more stats on our servers:
>>>>>>>> - each server has 64GB ram,
>>>>>>>> - there are 12 OSDs pr. server,
>>>>>>>> - each OSD uses around 1.5 GB of memory,
>>>>>>>> - we have 18432 PGs,
>>>>>>>> - around 5 to 10 MB writes/s is written to each OSD and almost=
 no reads (yet).
>>>>>>>=20
>>>>>>> What interface are you writing with? How many OSD servers are t=
here?
>>>>>>=20
>>>>>> We're using librados and there are 132 OSDs so far.
>>>>>=20
>>>>> Okay, so the allocation is happening in the depths of LevelDB =97=
 maybe
>>>>> the issue is there somewhere. Are you doing anything weird with o=
map,
>>>>> snapshots, or xattrs?
>>>>=20
>>>> I can help; No, we are not using omap, snaps or weird stuff with x=
attrs.
>>>>=20
>>>> We are storing objects of sizes from few KB to GBs. Also, we have =
a quirk in the application design right now, which means that we store =
an object, write it again under a new name and delete the original obje=
ct. - if that is of any potential value to finding this.
>>>>=20
>>>>=20
>>>> --
>>>> Anders

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
