From: Emil Renner Berthing <ceph@esmil.dk>
Subject: Re: Segmentation faults in ceph-osd
Date: Mon, 3 Jun 2013 17:42:00 +0200
Message-ID: <CANBLGcwV2kbqSj_fwZwef=F6ba8SKRgPkeszqg0QWJSLS=Rm-g@mail.gmail.com>
References: <CANBLGcybBofQqpP2wetuN+QDPO_QaX2s8AhM2WebcvW7njBd4Q@mail.gmail.com>
 <CAPYLRziXri6RYPZGCqQbnVS87XrnH1Bq2deX3yY4A8G5g3Yk5Q@mail.gmail.com>
 <CANBLGcwPMCSpXDgsXKBDQ2p-FhQNYg-FqagrUCrpa=BMTcogEg@mail.gmail.com>
 <CAPYLRzjiBJ7dBTibfLhPwRhCu+vEVcBCB_1dQpOKL+VT_TY2bw@mail.gmail.com>
 <CANBLGcyp9htDc=qZYP6iga-oSC7cGV-68F8UgWvR3rRKQhCX9A@mail.gmail.com>
 <CAPYLRzgd7ikRn=MoQUgazHJYUMUbzRwoH6PYJMcaBckbvdMLgg@mail.gmail.com>
 <98EBE255-FB43-4390-A53B-CE14CD2FE62B@saaby.com> <CA+4uBUY4YkSGJ-9rC0JpMfP-vE5uL2gbPOoEynK8ZSzs1StjGw@mail.gmail.com>
 <CANBLGcw+=8JMi0ihwm-qgALE9LjqzViB2t7OcQKb3g5QsMXDWQ@mail.gmail.com>
 <CA+4uBUbH6QXjZrAed5PetFYoRj+nPf-scBhFgCemVAo5KZSLyQ@mail.gmail.com> <10F53AF8-8BFF-4378-ACBC-C19C929FB9A8@saaby.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:58106 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694Ab3FCPmV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 11:42:21 -0400
Received: by mail-vc0-f182.google.com with SMTP id gf12so2752493vcb.41
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jun 2013 08:42:20 -0700 (PDT)
In-Reply-To: <10F53AF8-8BFF-4378-ACBC-C19C929FB9A8@saaby.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anders Saaby <anders@saaby.com>
Cc: Samuel Just <sam.just@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Unfortunately we keep getting these segmentation faults even when all
the cluster contains is objects from the rados benchmark tool.

I've opened an issue for it here:
http://tracker.ceph.com/issues/5239

On 21 May 2013 23:27, Anders Saaby <anders@saaby.com> wrote:
> On 21/05/2013, at 21.00, Samuel Just <sam.just@inktank.com> wrote:
>> How large are the xattrs?
>> -Sam
>
> Sam,
>
> They are quite small, as far as I can see from 10-50 chars each.
>
> However, as you just explained on irc, our current unbounded 1:1 file=
s vs. objects aproach, which in rare cases leads to ~25GB large objects=
, is not a good idea.. Could those large objects be what triggers the l=
arge leveldb allocation (and eventuelly the segfault)?
>
>
> --
> Anders
>
>> On Tue, May 21, 2013 at 10:13 AM, Emil Renner Berthing <ceph@esmil.d=
k> wrote:
>>> On 21 May 2013 19:05, Samuel Just <sam.just@inktank.com> wrote:
>>>> Do you use xattrs at all?
>>>
>>> Yes, on each object we set between 2 to 4 attributes at write time
>>> which are then left unchanged.
>>> /Emil
>>>
>>>> -Sam
>>>>
>>>> On Tue, May 21, 2013 at 9:34 AM, Anders Saaby <anders@saaby.com> w=
rote:
>>>>> On 21/05/2013, at 18.19, Gregory Farnum <greg@inktank.com> wrote:
>>>>>> On Tue, May 21, 2013 at 9:01 AM, Emil Renner Berthing <ceph@esmi=
l.dk> wrote:
>>>>>>> On 21 May 2013 17:55, Gregory Farnum <greg@inktank.com> wrote:
>>>>>>>> On Tue, May 21, 2013 at 8:44 AM, Emil Renner Berthing <ceph@es=
mil.dk> wrote:
>>>>>>>>> Hi Greg,
>>>>>>>>>
>>>>>>>>> Here are some more stats on our servers:
>>>>>>>>> - each server has 64GB ram,
>>>>>>>>> - there are 12 OSDs pr. server,
>>>>>>>>> - each OSD uses around 1.5 GB of memory,
>>>>>>>>> - we have 18432 PGs,
>>>>>>>>> - around 5 to 10 MB writes/s is written to each OSD and almos=
t no reads (yet).
>>>>>>>>
>>>>>>>> What interface are you writing with? How many OSD servers are =
there?
>>>>>>>
>>>>>>> We're using librados and there are 132 OSDs so far.
>>>>>>
>>>>>> Okay, so the allocation is happening in the depths of LevelDB =E2=
=80=94 maybe
>>>>>> the issue is there somewhere. Are you doing anything weird with =
omap,
>>>>>> snapshots, or xattrs?
>>>>>
>>>>> I can help; No, we are not using omap, snaps or weird stuff with =
xattrs.
>>>>>
>>>>> We are storing objects of sizes from few KB to GBs. Also, we have=
 a quirk in the application design right now, which means that we store=
 an object, write it again under a new name and delete the original obj=
ect. - if that is of any potential value to finding this.
>>>>>
>>>>>
>>>>> --
>>>>> Anders
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
