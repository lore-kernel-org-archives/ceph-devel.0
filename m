From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: The questions of data collection and cache tiering in Ceph
Date: Thu, 8 Oct 2015 11:34:25 -0700
Message-ID: <CAJ4mKGaSOR+jSsWfrXQ6wmh3HCuWzk04koeKr6St5Y0AF=9kCw@mail.gmail.com>
References: <1f22defc.11cdc.1504836bb4f.Coremail.cymengxiang@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38240 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbbJHSe0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Oct 2015 14:34:26 -0400
Received: by wiclk2 with SMTP id lk2so37653080wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Oct 2015 11:34:25 -0700 (PDT)
In-Reply-To: <1f22defc.11cdc.1504836bb4f.Coremail.cymengxiang@126.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6JSh5q+F?= <cymengxiang@126.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 8, 2015 at 9:09 AM, =E8=94=A1=E6=AF=85 <cymengxiang@126.com=
> wrote:
>
> Dear developers,
>
>    Recently I met some troubles when I read the Ceph=E2=80=99s source=
 code and understand the architecture.
> The details of problems are as followed.
>
>    1.In monitoring tools, they can collect much data when Ceph runs. =
I wonder what
> kind of data the Ceph can provide (object data, PG data or other data=
?). Could the
> Ceph provide every object=E2=80=99s data (e.g. The times the object i=
s read or wrote
> ,the latest time the object is used ,etc.) ,if Ceph could ,in source =
code ,where
> could I find these details. I really want to know the monitoring data=
 the Ceph
> can provides and where they are in source code so that I could know h=
ow to use it
> more efficiently. For example, I know the Ceph could provide the data=
 of the
> objects=E2=80=99 number per PG, the read and write bandwidth, but I c=
ouldn=E2=80=99t find how to
> achieve these in source code.

I'm not quite sure what you're asking here, but I think you'll want to
look at the MPGStats.h message (in ceph/src/messages), and trace
backwards through the OSD code (ceph/src/osd/) which creates them and
then forwards through the monitor code (ceph/src/mon/OSDMonitor.cc)

>
>    2.From official documents, Ceph provides the cache tiering to impr=
ove
> performance. But I couldn=E2=80=99t find more details to describe the=
 cache tiering
> like which kind of algorithm the cache agent uses. In the source code=
, where
> could I find these?

The cache tiering is part of the OSD=10. Look at the TierAgentState.h
file and the parts of ReplicatedPG.cc which reference it.

>
>   3.In write process , there are two responses to client ,first is fr=
om journal and
> second is occurred when object writes to real disk .so when I write a=
 object to
> Ceph using librbd, does not the write finish until the second respons=
e occurs and
> what mean the first and second responses for clients? When a object w=
rites to journal
> but not to filestore (that is not to disk ), could I read this object=
? If I could,
> where could I read this object?

You get a response from the OSDs:
1) when the write operation is durable.
2) when the write operation is readable.

The order these arrive in will depend on your OSD configuration (btrfs
can send readable before durable; xfs always sends durable first;
etc). If you get a "durable" response, any subsequent operations on
that object will wait until that durable op is readable before
completing.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
