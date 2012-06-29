From: Gregory Farnum <greg@inktank.com>
Subject: Re: Designing a cluster guide
Date: Fri, 29 Jun 2012 11:50:48 -0700
Message-ID: <CAPYLRzguXka1S_CyQ5q-f9VmhACpkHRZer1_9kuk3LPpfXOMcw@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag>
	<4FABC15C.3030500@profihost.ag>
	<CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
	<CAPYLRzim+GHZe88_YA=1COKqh-A4XkPmUDYYiUyFVaQ2dxCuvA@mail.gmail.com>
	<CAMsVa3vyJo05M4KkXmYwmRnoPi2V-sjM7SVHrM0ZJJ6JEZdCzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55150 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab2F2Suu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 14:50:50 -0400
Received: by lbbgm6 with SMTP id gm6so5011792lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 11:50:48 -0700 (PDT)
In-Reply-To: <CAMsVa3vyJo05M4KkXmYwmRnoPi2V-sjM7SVHrM0ZJJ6JEZdCzA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Edmonds <mornir@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jun 29, 2012 at 11:42 AM, Brian Edmonds <mornir@gmail.com> wrot=
e:
> What are the likely and worst case scenarios if the OSD journal were
> to simply be on a garden variety ramdisk, no battery backing? =A0In t=
he
> case of a single node losing power, and thus losing some data, surely
> Ceph can recognize this, and handle it through normal redundancy? =A0=
I
> could see it being an issue if the whole cluster lost power at once.
> Anything I'm missing?

If you lose a journal, you lose the OSD. The end. We could potentially
recover much of the data through developer-driven manual data
inspection, but I suspect it's roughly equivalent to what a lot of
data forensics services offer =97 expensive for everybody and not
something to rely on.
Ceph can certainly handle losing *one* OSD, but if you have a
correlated failure of more than one, you're almost certain to lose
data some amount of data (how much depends on how many OSDs you have,
and how you've replicated that data). If that's an acceptable tradeoff
for you, go for it...but I doubt that it is when you come down to it.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
