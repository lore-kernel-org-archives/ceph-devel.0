From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Tue, 18 Dec 2012 18:21:56 +0100
Message-ID: <CAOLwVUkVhoM6U4z1iBPYFucdaq4AtV69_YReh2UaE_Jkocm4xQ@mail.gmail.com>
References: <CAOLwVUmJb0y39dg3zTv=c4iPSkjLBhG3L7L4=L7Ms96iP-SiWw@mail.gmail.com>
 <CAOLwVUnRqj+u7Vn2De+zAfvXLpYhj=tNggGZZdOH+m_xj2SMCQ@mail.gmail.com>
 <CA+4uBUY6Vf0HU71bL8z-3QhbsSSv+LRXFyfAiHHoNAzMw=5dLw@mail.gmail.com>
 <CAOLwVUn5VbH1P=0wu-Oxb1bSKpaQfC6uQ5012wvPc7bvz606JA@mail.gmail.com>
 <CAOLwVU=_Tz6Swirzk6AWwREdmG8qQUiQt=wd1OyNiPVSF1bqng@mail.gmail.com> <CA+4uBUZyeGAHH9Ntws2tCKud66H758qyCPWVG-aZnB2gcZjpJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:51469 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab2LRRWS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Dec 2012 12:22:18 -0500
Received: by mail-la0-f43.google.com with SMTP id z14so775153lag.2
        for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 09:22:16 -0800 (PST)
In-Reply-To: <CA+4uBUZyeGAHH9Ntws2tCKud66H758qyCPWVG-aZnB2gcZjpJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Nothing terrific...

Kernel logs from my clients are full of "libceph: osd4
172.20.11.32:6801 socket closed"

I saw this somewhere on the tracker.

Does this harm?

Thanks.

--
Regards,
S=E9bastien Han.



On Mon, Dec 17, 2012 at 11:55 PM, Samuel Just <sam.just@inktank.com> wr=
ote:
>
> What is the workload like?
> -Sam
>
> On Mon, Dec 17, 2012 at 2:41 PM, S=E9bastien Han <han.sebastien@gmail=
=2Ecom> wrote:
> > Hi,
> >
> > No, I don't see nothing abnormal in the network stats. I don't see
> > anything in the logs... :(
> > The weird thing is that one node over 4 seems to take way more memo=
ry
> > than the others...
> >
> > --
> > Regards,
> > S=E9bastien Han.
> >
> >
> > On Mon, Dec 17, 2012 at 11:31 PM, S=E9bastien Han <han.sebastien@gm=
ail.com> wrote:
> >>
> >> Hi,
> >>
> >> No, I don't see nothing abnormal in the network stats. I don't see=
 anything in the logs... :(
> >> The weird thing is that one node over 4 seems to take way more mem=
ory than the others...
> >>
> >> --
> >> Regards,
> >> S=E9bastien Han.
> >>
> >>
> >>
> >> On Mon, Dec 17, 2012 at 7:12 PM, Samuel Just <sam.just@inktank.com=
> wrote:
> >>>
> >>> Are you having network hiccups?  There was a bug noticed recently=
 that
> >>> could cause a memory leak if nodes are being marked up and down.
> >>> -Sam
> >>>
> >>> On Mon, Dec 17, 2012 at 12:28 AM, S=E9bastien Han <han.sebastien@=
gmail.com> wrote:
> >>> > Hi guys,
> >>> >
> >>> > Today looking at my graphs I noticed that one over 4 ceph nodes=
 used a
> >>> > lot of memory. It keeps growing and growing.
> >>> > See the graph attached to this mail.
> >>> > I run 0.48.2 on Ubuntu 12.04.
> >>> >
> >>> > The other nodes also grow, but slowly than the first one.
> >>> >
> >>> > I'm not quite sure about the information that I have to provide=
=2E So
> >>> > let me know. The only thing I can say is that the load haven't
> >>> > increase that much this week. It seems to be consuming and not =
giving
> >>> > back the memory.
> >>> >
> >>> > Thank you in advance.
> >>> >
> >>> > --
> >>> > Regards,
> >>> > S=E9bastien Han.
> >>
> >>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
