From: Samuel Just <sam.just@inktank.com>
Subject: Re: Segmentation faults in ceph-osd
Date: Tue, 21 May 2013 10:05:00 -0700
Message-ID: <CA+4uBUY4YkSGJ-9rC0JpMfP-vE5uL2gbPOoEynK8ZSzs1StjGw@mail.gmail.com>
References: <CANBLGcybBofQqpP2wetuN+QDPO_QaX2s8AhM2WebcvW7njBd4Q@mail.gmail.com>
	<CAPYLRziXri6RYPZGCqQbnVS87XrnH1Bq2deX3yY4A8G5g3Yk5Q@mail.gmail.com>
	<CANBLGcwPMCSpXDgsXKBDQ2p-FhQNYg-FqagrUCrpa=BMTcogEg@mail.gmail.com>
	<CAPYLRzjiBJ7dBTibfLhPwRhCu+vEVcBCB_1dQpOKL+VT_TY2bw@mail.gmail.com>
	<CANBLGcyp9htDc=qZYP6iga-oSC7cGV-68F8UgWvR3rRKQhCX9A@mail.gmail.com>
	<CAPYLRzgd7ikRn=MoQUgazHJYUMUbzRwoH6PYJMcaBckbvdMLgg@mail.gmail.com>
	<98EBE255-FB43-4390-A53B-CE14CD2FE62B@saaby.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:61093 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab3EURFB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 13:05:01 -0400
Received: by mail-ee0-f52.google.com with SMTP id c13so559589eek.39
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 10:05:00 -0700 (PDT)
In-Reply-To: <98EBE255-FB43-4390-A53B-CE14CD2FE62B@saaby.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anders Saaby <anders@saaby.com>
Cc: Gregory Farnum <greg@inktank.com>, Emil Renner Berthing <ceph@esmil.dk>, ceph-devel <ceph-devel@vger.kernel.org>

Do you use xattrs at all?
-Sam

On Tue, May 21, 2013 at 9:34 AM, Anders Saaby <anders@saaby.com> wrote:
> On 21/05/2013, at 18.19, Gregory Farnum <greg@inktank.com> wrote:
>> On Tue, May 21, 2013 at 9:01 AM, Emil Renner Berthing <ceph@esmil.dk=
> wrote:
>>> On 21 May 2013 17:55, Gregory Farnum <greg@inktank.com> wrote:
>>>> On Tue, May 21, 2013 at 8:44 AM, Emil Renner Berthing <ceph@esmil.=
dk> wrote:
>>>>> Hi Greg,
>>>>>
>>>>> Here are some more stats on our servers:
>>>>> - each server has 64GB ram,
>>>>> - there are 12 OSDs pr. server,
>>>>> - each OSD uses around 1.5 GB of memory,
>>>>> - we have 18432 PGs,
>>>>> - around 5 to 10 MB writes/s is written to each OSD and almost no=
 reads (yet).
>>>>
>>>> What interface are you writing with? How many OSD servers are ther=
e?
>>>
>>> We're using librados and there are 132 OSDs so far.
>>
>> Okay, so the allocation is happening in the depths of LevelDB =97 ma=
ybe
>> the issue is there somewhere. Are you doing anything weird with omap=
,
>> snapshots, or xattrs?
>
> I can help; No, we are not using omap, snaps or weird stuff with xatt=
rs.
>
> We are storing objects of sizes from few KB to GBs. Also, we have a q=
uirk in the application design right now, which means that we store an =
object, write it again under a new name and delete the original object.=
 - if that is of any potential value to finding this.
>
>
> --
> Anders
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
