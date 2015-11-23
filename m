From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Multiple OSDs suicide because of client issues?
Date: Mon, 23 Nov 2015 12:37:51 -0700
Message-ID: <CAANLjFrA14SiTgGdNPGJZODeF1j-BO8GAJOEf9fFQCHbpM3MOg@mail.gmail.com>
References: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com>
	<CAJ4mKGb5F+cuUKdU6PHs47sed9ZCb+qEnNDvxfuxB=vFyDx96A@mail.gmail.com>
	<CAANLjFo=vCsny5=JW1wYiQk5S=oXdtVd0OzXEC=uTGgmDO9ydA@mail.gmail.com>
	<CAJ4mKGbYrDOpiEJiMKZwHaEHGrZT=b58GjzYg4x35U1XtDbDWg@mail.gmail.com>
	<CAANLjFpn+MGw4cY7aZarLuXgiVznovaJGXY2wtXwMmm8n24Qsw@mail.gmail.com>
	<CAJ4mKGaA=OnH3XPM=m5JE+1Rwc38gsmwrJv3FP1MCY5qO1nYrg@mail.gmail.com>
	<CAANLjFoyAyDrxoGLTdPwzRN12ffqkHqNeXgBZBmG+s7i02WBCw@mail.gmail.com>
	<CAJ4mKGawUUwAB7DC6uWf=6xVGpeg=ac3PB1wx2_3msDPCYDkOw@mail.gmail.com>
	<CAANLjFq-eqTy4XN_YTMyS0M2h4Smo1GNSmuqL+FuDAZDG3yXGg@mail.gmail.com>
	<alpine.DEB.2.00.1511231110530.11017@cobra.newdream.net>
	<CAANLjFrU0aDV44u7srskMOCHvFaHYEG4kdxnhxH_MMxW6S9Mfw@mail.gmail.com>
	<alpine.DEB.2.00.1511231131000.11017@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36176 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbbKWThv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 14:37:51 -0500
Received: by vkay187 with SMTP id y187so45094211vka.3
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 11:37:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511231131000.11017@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for the log dump command, I'll keep that in the back pocket, it
would have been helpful in a few situations.

I'm trying to microbenchmark the new Weighted Round Robin queue I've
been working on and just trying to dump the info to the logs so that I
can see it at runtime. So this is in a branch that isn't published
yet.

In file included from osd/OSD.cc:37:0:
osd/OSD.h: In member function =E2=80=98virtual void
OSD::ShardedOpWQ::_process(uint32_t, ceph::heartbeat_handle_d*)=E2=80=99=
:
osd/OSD.h:1072:7: error: invalid use of non-static data member =E2=80=98=
OSD::whoami=E2=80=99
   int whoami;
       ^
osd/OSD.cc:8270:388: error: from this location
   dout(15) << "Wrr (" << dendl;


               ^
osd/OSD.cc:8270:413: error: cannot call member function =E2=80=98epoch_=
t
OSD::get_osdmap_epoch()=E2=80=99 without object
   dout(15) << "Wrr (" << dendl;


                                        ^
In file included from osd/OSD.cc:37:0:
osd/OSD.h: In member function =E2=80=98virtual void
OSD::ShardedOpWQ::_enqueue(std::pair<boost::intrusive_ptr<PG>,
PGQueueable>)=E2=80=99:
osd/OSD.h:1072:7: error: invalid use of non-static data member =E2=80=98=
OSD::whoami=E2=80=99
   int whoami;
       ^
osd/OSD.cc:8361:388: error: from this location
   dout(15) << "Wrr (" << std::this_thread::get_id() << ") " <<
sdata->pqueue.get_queue() <<


               ^
osd/OSD.cc:8361:413: error: cannot call member function =E2=80=98epoch_=
t
OSD::get_osdmap_epoch()=E2=80=99 without object
   dout(15) << "Wrr (" << std::this_thread::get_id() << ") " <<
sdata->pqueue.get_queue() <<


The second set of errors just gets a string from the get_queue()
function, but the problem seems to be with just "dout(15) << "Wrr ("
<< dendl;" I would think that there is already an object of the OSD
created, so I'm a bit confused. Thanks for helping with a simple
issue.
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Nov 23, 2015 at 12:32 PM, Sage Weil <sweil@redhat.com> wrote:
> On Mon, 23 Nov 2015, Robert LeBlanc wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> Is there a way through the admin socket or inject args that can tell
>> the OSD process to dump the in memory logs without crashing? Do you
>
> Yep, 'ceph daemon osd.NN log dump'.
>
>> have an idea of the overhead? From the code it looks like it is alwa=
ys
>> evaluated, just depends on if it is stored in memory or dumped to
>> disk. I'm trying to figure out an issue with dout() right now in the
>> code I'm working on (invalid use of static member) and I'm trying to
>> understand how it works.
>
> What's the error and problematic line?
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
