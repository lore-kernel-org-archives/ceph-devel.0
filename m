From: Emil Renner Berthing <ceph@esmil.dk>
Subject: Re: Segmentation faults in ceph-osd
Date: Tue, 21 May 2013 19:13:49 +0200
Message-ID: <CANBLGcw+=8JMi0ihwm-qgALE9LjqzViB2t7OcQKb3g5QsMXDWQ@mail.gmail.com>
References: <CANBLGcybBofQqpP2wetuN+QDPO_QaX2s8AhM2WebcvW7njBd4Q@mail.gmail.com>
 <CAPYLRziXri6RYPZGCqQbnVS87XrnH1Bq2deX3yY4A8G5g3Yk5Q@mail.gmail.com>
 <CANBLGcwPMCSpXDgsXKBDQ2p-FhQNYg-FqagrUCrpa=BMTcogEg@mail.gmail.com>
 <CAPYLRzjiBJ7dBTibfLhPwRhCu+vEVcBCB_1dQpOKL+VT_TY2bw@mail.gmail.com>
 <CANBLGcyp9htDc=qZYP6iga-oSC7cGV-68F8UgWvR3rRKQhCX9A@mail.gmail.com>
 <CAPYLRzgd7ikRn=MoQUgazHJYUMUbzRwoH6PYJMcaBckbvdMLgg@mail.gmail.com>
 <98EBE255-FB43-4390-A53B-CE14CD2FE62B@saaby.com> <CA+4uBUY4YkSGJ-9rC0JpMfP-vE5uL2gbPOoEynK8ZSzs1StjGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:50032 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab3EUROK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 13:14:10 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so592062vbf.24
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 10:14:09 -0700 (PDT)
In-Reply-To: <CA+4uBUY4YkSGJ-9rC0JpMfP-vE5uL2gbPOoEynK8ZSzs1StjGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Anders Saaby <anders@saaby.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 21 May 2013 19:05, Samuel Just <sam.just@inktank.com> wrote:
> Do you use xattrs at all?

Yes, on each object we set between 2 to 4 attributes at write time
which are then left unchanged.
/Emil

> -Sam
>
> On Tue, May 21, 2013 at 9:34 AM, Anders Saaby <anders@saaby.com> wrot=
e:
>> On 21/05/2013, at 18.19, Gregory Farnum <greg@inktank.com> wrote:
>>> On Tue, May 21, 2013 at 9:01 AM, Emil Renner Berthing <ceph@esmil.d=
k> wrote:
>>>> On 21 May 2013 17:55, Gregory Farnum <greg@inktank.com> wrote:
>>>>> On Tue, May 21, 2013 at 8:44 AM, Emil Renner Berthing <ceph@esmil=
=2Edk> wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> Here are some more stats on our servers:
>>>>>> - each server has 64GB ram,
>>>>>> - there are 12 OSDs pr. server,
>>>>>> - each OSD uses around 1.5 GB of memory,
>>>>>> - we have 18432 PGs,
>>>>>> - around 5 to 10 MB writes/s is written to each OSD and almost n=
o reads (yet).
>>>>>
>>>>> What interface are you writing with? How many OSD servers are the=
re?
>>>>
>>>> We're using librados and there are 132 OSDs so far.
>>>
>>> Okay, so the allocation is happening in the depths of LevelDB =E2=80=
=94 maybe
>>> the issue is there somewhere. Are you doing anything weird with oma=
p,
>>> snapshots, or xattrs?
>>
>> I can help; No, we are not using omap, snaps or weird stuff with xat=
trs.
>>
>> We are storing objects of sizes from few KB to GBs. Also, we have a =
quirk in the application design right now, which means that we store an=
 object, write it again under a new name and delete the original object=
=2E - if that is of any potential value to finding this.
>>
>>
>> --
>> Anders
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
