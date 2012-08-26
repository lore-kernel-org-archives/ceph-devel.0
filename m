From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Ceph doesn't detect journal failure while the OSD is running
Date: Sun, 26 Aug 2012 23:07:47 +0200
Message-ID: <CAOLwVU=r46QGy_P7Lc2HNmY4cJKfi3bpTHM_Wad_P2TaXX5WEg@mail.gmail.com>
References: <CAOLwVUkKW4FhSb4+YKrC7j+_EFAkh--mS_famV44Zd67OgB-oQ@mail.gmail.com>
 <F13ACA9DFF5F414BB9E2B7502BD9EC33@inktank.com> <CAOLwVUkigWf-tSLepaaTOj8dsN43gpuLsJ2h=4Lm6GLAG16g1A@mail.gmail.com>
 <alpine.DEB.2.00.1208261355520.11218@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51044 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764Ab2HZVIJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 Aug 2012 17:08:09 -0400
Received: by lagy9 with SMTP id y9so2158558lag.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 14:08:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208261355520.11218@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

I used:

umount -l to bypassed the warning.

I agree for the second one, that's a normal behavior, even if the file
doesn't exist anymore, the file is still opened by the OSD process.

On Sun, Aug 26, 2012 at 10:59 PM, Sage Weil <sage@inktank.com> wrote:
> On Sun, 26 Aug 2012, S?bastien Han wrote:
>> Hi Greg,
>>
>> My first test was:
>>
>> * put a journal on tmpfs
>> * umount the tmpfs
>
> This should have errored out with 'device is busy'.  Are you sure it
> actually umounted?
>
>> The second one was almost the same:
>>
>> * rm -rf /journals/*
>>
>> Here /journals contains every journal... (3 actually)
>
> That's normal Unix behavior.  The file doesn't go away until all names are
> unlinked/removed *and* all open file handles are closed...
>
> sage
>
>
>> This action wiped off the journal and ceph didn't detect anything.
>>
>> After that I created a new pool, a new image inside it, mapped it,
>> formated it and wrote data in it with dd. I also used rados bench to
>> write data.
>> Ceph didn't see anything, only a service ceph restart osd make them
>> the OSDs crashed.
>
>
>
>>
>>
>> On Sun, Aug 26, 2012 at 9:43 PM, Gregory Farnum <greg@inktank.com> wrote:
>> >
>> > On Sunday, August 26, 2012 at 11:09 AM, S?bastien Han wrote:
>> > > Hi guys!
>> > >
>> > > Ceph doesn't seem to detect a journal failure. The cluster keeps
>> > > writing data even if the journal doesn't exist anymore.
>> > > I can find anywhere in the log or from the ceph's command output any
>> > > information about a journal failure. Obviously if an OSD is restarted
>> > > ceph will complain but a failure on fly won't be detected.
>> > >
>> > > It seems that Ceph just writes directly to the backend filesystem
>> > > without complaining.
>> > >
>> > > Yes my monitoring system will tell me that the disk which contains my
>> > > journals is down... But it's not the point here :)
>> > >
>> > > The really good point for me is that the cluster keeps running even if
>> > > the journal is gone. The bad point is obviously that the cluster keeps
>> > > writing data to the backend filesystem (without O_DIRECT I guess...).
>> > > I'll prefer a 'read only' cluster facility while the journal is down.
>> > > Being able to retrieve the data is as crucial as writing data.
>> > >
>> > > Any reaction about that? Roadmap feature maybe?
>> > So are you saying the filesystem that the journal was located on disappeared? Or the underlying disk disappeared?
>> > And then the OSD didn't notice?
>> >
>> > If so, that's definitely a problem to be corrected as soon as we can?It's more likely to make the OSD shut down than to continue serving reads, though.
>> > -Greg
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
