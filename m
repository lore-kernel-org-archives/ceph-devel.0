From: Sage Weil <sweil@redhat.com>
Subject: Re: Multiple OSDs suicide because of client issues?
Date: Mon, 23 Nov 2015 11:54:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511231153210.11017@cobra.newdream.net>
References: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com> <CAJ4mKGb5F+cuUKdU6PHs47sed9ZCb+qEnNDvxfuxB=vFyDx96A@mail.gmail.com> <CAANLjFo=vCsny5=JW1wYiQk5S=oXdtVd0OzXEC=uTGgmDO9ydA@mail.gmail.com> <CAJ4mKGbYrDOpiEJiMKZwHaEHGrZT=b58GjzYg4x35U1XtDbDWg@mail.gmail.com>
 <CAANLjFpn+MGw4cY7aZarLuXgiVznovaJGXY2wtXwMmm8n24Qsw@mail.gmail.com> <CAJ4mKGaA=OnH3XPM=m5JE+1Rwc38gsmwrJv3FP1MCY5qO1nYrg@mail.gmail.com> <CAANLjFoyAyDrxoGLTdPwzRN12ffqkHqNeXgBZBmG+s7i02WBCw@mail.gmail.com> <CAJ4mKGawUUwAB7DC6uWf=6xVGpeg=ac3PB1wx2_3msDPCYDkOw@mail.gmail.com>
 <CAANLjFq-eqTy4XN_YTMyS0M2h4Smo1GNSmuqL+FuDAZDG3yXGg@mail.gmail.com> <alpine.DEB.2.00.1511231110530.11017@cobra.newdream.net> <CAANLjFrU0aDV44u7srskMOCHvFaHYEG4kdxnhxH_MMxW6S9Mfw@mail.gmail.com> <alpine.DEB.2.00.1511231131000.11017@cobra.newdream.net>
 <CAANLjFrA14SiTgGdNPGJZODeF1j-BO8GAJOEf9fFQCHbpM3MOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41131 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108AbbKWTyd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Nov 2015 14:54:33 -0500
In-Reply-To: <CAANLjFrA14SiTgGdNPGJZODeF1j-BO8GAJOEf9fFQCHbpM3MOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 23 Nov 2015, Robert LeBlanc wrote:
> Thanks for the log dump command, I'll keep that in the back pocket, it
> would have been helpful in a few situations.
> 
> I'm trying to microbenchmark the new Weighted Round Robin queue I've
> been working on and just trying to dump the info to the logs so that I
> can see it at runtime. So this is in a branch that isn't published
> yet.
> 
> In file included from osd/OSD.cc:37:0:
> osd/OSD.h: In member function ?virtual void
> OSD::ShardedOpWQ::_process(uint32_t, ceph::heartbeat_handle_d*)?:
> osd/OSD.h:1072:7: error: invalid use of non-static data member ?OSD::whoami?
>    int whoami;
>        ^
> osd/OSD.cc:8270:388: error: from this location
>    dout(15) << "Wrr (" << dendl;

#undef
#define dout_prefix *_dout << "something: "

(whatever dout_perfix currently is for this code includes whoami... you're 
probably in a class other than OSD but still in OSD.cc.. move it to a 
different .cc file, or put it above the current class OSD stuff.

sage
