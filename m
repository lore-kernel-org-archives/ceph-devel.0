From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Re: The questions of data collection and cache tiering in Ceph
Date: Tue, 13 Oct 2015 21:29:30 -0700
Message-ID: <CAJ4mKGbS0Vom7JWXtR25OqtFoZNFk9U_rNHEMmjHNzwCgKbuoQ@mail.gmail.com>
References: <1f22defc.11cdc.1504836bb4f.Coremail.cymengxiang@126.com>
	<CAJ4mKGaSOR+jSsWfrXQ6wmh3HCuWzk04koeKr6St5Y0AF=9kCw@mail.gmail.com>
	<5ba3ce4f.109e5.1505c455f47.Coremail.cymengxiang@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37975 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbbJNE3c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Oct 2015 00:29:32 -0400
Received: by wieq12 with SMTP id q12so62822499wie.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 21:29:31 -0700 (PDT)
In-Reply-To: <5ba3ce4f.109e5.1505c455f47.Coremail.cymengxiang@126.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6JSh5q+F?= <cymengxiang@126.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 12, 2015 at 6:37 AM, =E8=94=A1=E6=AF=85 <cymengxiang@126.co=
m> wrote:
> Greg,
>     Thank you  a lot for your timely reply. These are really helpful =
for me.I also have some doubts.
>     In Ceph, besides monitoring pool, pg, object, it can also acquire=
 other statistics such as  CPU, IOPS, BW. In order to acquire the infor=
mation ,
> do the Ceph need to call other tools or have achieved functions in th=
e source code because I could only find easy equation (like the divisio=
n ) in
> source code?

Uh, it's using the standard linux interfaces for this. Some of that's
via the psuedo-fs stuff in /proc/sys or whatever...

>     As a object , there are two parts : data and attributes. Do they =
store in different spaces finally because I find these is some attribut=
es information in OMap?

Yes, although the specifics depend on your backend configuration. In
the default setup, data is stored in the filesystem, "omap" entries
are stored in leveldb, and the first few object xattrs will get stored
in fs xattrs but more will overflow into leveldb.

>     In your reply, you said ,=E2=80=9Dany subsequent operations on th=
at object will wait until that durable op is readable before completing=
=2E=E2=80=9D so if I set the system
> flushes the objects from journal to disk every 15s, does it mean I co=
uld not read the object in 15s because I only write the object on the j=
ournal but not yet
> on the disk? Is it possible to cause some problems?

No, that's not quite it. If you set it for a 15-second flush interval,
that's how often the backing filesystem will get a forced sync to
disk. But the journal will have persisted the data way before that,
and the data will be written into the filesystem right after that =E2=80=
=94 so
it's readable out of page cache! As soon as the write operation
completes in-memory the OSD will continue processing subsequent ops on
the object (because the OSD journal has persisted the operation).
-Greg

>     Thank you so much.
>     Yours,
>     Chay
>
>
>
>
>
>
>
> =E5=9C=A8 2015-10-09 02:34:25=EF=BC=8C"Gregory Farnum" <gfarnum@redha=
t.com> =E5=86=99=E9=81=93=EF=BC=9A
>>On Thu, Oct 8, 2015 at 9:09 AM, =E8=94=A1=E6=AF=85 <cymengxiang@126.c=
om> wrote:
>>>
>>> Dear developers,
>>>
>>>    Recently I met some troubles when I read the Ceph=E2=80=99s sour=
ce code and understand the architecture.
>>> The details of problems are as followed.
>>>
>>>    1.In monitoring tools, they can collect much data when Ceph runs=
=2E I wonder what
>>> kind of data the Ceph can provide (object data, PG data or other da=
ta?). Could the
>>> Ceph provide every object=E2=80=99s data (e.g. The times the object=
 is read or wrote
>>> ,the latest time the object is used ,etc.) ,if Ceph could ,in sourc=
e code ,where
>>> could I find these details. I really want to know the monitoring da=
ta the Ceph
>>> can provides and where they are in source code so that I could know=
 how to use it
>>> more efficiently. For example, I know the Ceph could provide the da=
ta of the
>>> objects=E2=80=99 number per PG, the read and write bandwidth, but I=
 couldn=E2=80=99t find how to
>>> achieve these in source code.
>>
>>I'm not quite sure what you're asking here, but I think you'll want t=
o
>>look at the MPGStats.h message (in ceph/src/messages), and trace
>>backwards through the OSD code (ceph/src/osd/) which creates them and
>>then forwards through the monitor code (ceph/src/mon/OSDMonitor.cc)
>>
>>>
>>>    2.From official documents, Ceph provides the cache tiering to im=
prove
>>> performance. But I couldn=E2=80=99t find more details to describe t=
he cache tiering
>>> like which kind of algorithm the cache agent uses. In the source co=
de, where
>>> could I find these?
>>
>>The cache tiering is part of the OSD. Look at the TierAgentState.h
>>file and the parts of ReplicatedPG.cc which reference it.
>>
>>>
>>>   3.In write process , there are two responses to client ,first is =
from journal and
>>> second is occurred when object writes to real disk .so when I write=
 a object to
>>> Ceph using librbd, does not the write finish until the second respo=
nse occurs and
>>> what mean the first and second responses for clients? When a object=
 writes to journal
>>> but not to filestore (that is not to disk ), could I read this obje=
ct? If I could,
>>> where could I read this object?
>>
>>You get a response from the OSDs:
>>1) when the write operation is durable.
>>2) when the write operation is readable.
>>
>>The order these arrive in will depend on your OSD configuration (btrf=
s
>>can send readable before durable; xfs always sends durable first;
>>etc). If you get a "durable" response, any subsequent operations on
>>that object will wait until that durable op is readable before
>>completing.
>>-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
