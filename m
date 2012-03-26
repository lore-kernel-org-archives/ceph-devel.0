From: Sage Weil <sage@newdream.net>
Subject: Re: osd shutdown notification
Date: Mon, 26 Mar 2012 15:41:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203261520160.19530@cobra.newdream.net>
References: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
 <CAORUGqDBoyvSFsSMVZdfWhPUFGsQTG6pZ-n9u=YnXtj0zzOGAg@mail.gmail.com>
 <Pine.LNX.4.64.1203261251230.19530@cobra.newdream.net>
 <CAORUGqDi8+Jdhoop7QYHvROBYouJd5AvHr_ZHLD5Z+j6jZHrdA@mail.gmail.com>
 <Pine.LNX.4.64.1203261310240.19530@cobra.newdream.net>
 <CAORUGqAbHhZJ-=-HXwBZjboUGVKJBP9nBHD4ZKufs7-OeCqKnw@mail.gmail.com>
 <Pine.LNX.4.64.1203261408230.19530@cobra.newdream.net>
 <CAORUGqCuTnHUxCuH9MT0RrZKO8QBiGj2Ev3NcBQmaCB+hgiYsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1124186152-1332801660=:19530"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58942 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab2CZWlD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 18:41:03 -0400
In-Reply-To: <CAORUGqCuTnHUxCuH9MT0RrZKO8QBiGj2Ev3NcBQmaCB+hgiYsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1124186152-1332801660=:19530
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 26 Mar 2012, Tommi Virtanen wrote:
> On Mon, Mar 26, 2012 at 14:55, Sage Weil <sage@newdream.net> wrote:
> >> Why do you need to know where osd.42 was last seen just to be able to
> >> authoritatively claim osd.42 is 1) down 2) at a new location.
> >
> > Not "where" but "which". =A0If a ceph-osd stops, and gets restarted (on=
 same
> > host, different host, whatever) I want to make sure the _old_ instance =
is
> > marked down (if not already down) in the map and any new instance is no=
t.
> > We can't ignore the possibility of a race, as all kinds of things can m=
ake
> > the notification path go faster or slower than a replacement ceph-osd
> > might. =A0addr is just one possible unique identifier to achieve that; =
we
> > could also use the up_from epoch or anything else unique to the instanc=
e.
> > The problem is it is unknown until the process has been alive for a whi=
le,
> > so a wrapper can't see it easily.
> >
> > Well, the addr is (ip, port, nonce) where nonce is actually the pid, so=
 if
> > we can tell what ip ceph-osd will bind to that might work...
>=20
> Okay so if I understand correctly, you're worried that this:
>=20
> - osd.42 pid 123 dies
> - small utility sends "osd.42 is dead"
> - osd.42 pid 234 starts up
>=20
> is observed as this:
>=20
> - osd.42 pid 123 dies
> - osd.42 pid 234 starts up
> - small utility sends "osd.42 is dead"
>=20
> ?

Yeah, or in fact the second ordering is what really happens, because the=20
234 start is done by someone/something else.

> I'd expect the last two to happen in separate rounds of paxos, or
> something, and thus not be reorderable (the client won't reorder them;
> it runs the notifier first to completion, only then starts the new
> daemon instance).. but if they can be reordered like that, then it
> seems like a valid concern. Perhaps the small utility "osd.42 is dead"
> should be just a hint, "osd.42 might be dead, please check and flag it
> down asap if it doesn't respond"?

The problem is a remote 'please check' generally involves a timeout, and=20
we already do that with the OSD pings.

Maybe I'm being overly paranoid here and the pid as a unique id is=20
sufficient.  e.g.,

 #!/bin/sh
 ...annoying arg parsing...
 ceph-osd -i $id ... &
 pid=3D$!
 wait
 ceph osd stopped $id $pid $? &

?

sage


>=20
> >> > execv() in the signal handler, OTOH, is easy. =A0Is it that offensiv=
e?
> >> >
> >> > The other nice thing about that is that the failure notification can=
 be
> >> > informative for free: "osd.42 stopped: got SIGTERM", "osd.42 stopped=
:
> >> > failed assert at foo.cc:1234", etc.
> >>
> >> I'm worried about all the things that want us to exit(3). Code
> >> coverage, valgrind, what not.
> >>
> >> If you're thinking of shipping the crash reason to monitors, I think
> >> you're once again trying to replace a bunch of a sysadmin's toolkit
> >> with Ceph-internal features. Ones that they can't use with all the
> >> non-Ceph things they run on their storage cluster anyway, like statsd,
> >> sshd, etc. I feel confident in saying Ceph will lose that race, in
> >> stability, functionality and familiarity to target audience.
> >
> > I see your point, but I don't know what in the sysadmin's toolkit would
> > actually do this (now or in the future). =A0For an external agent/wrapp=
er to
> > work it would need to:
> >
> > =A01- start ceph-osd
> > =A02- query it for it's cookie/nonce (or infer what it will be)
> > =A03- wait for the process to stop/crash
> > =A04- send a notification (using ceph specific tool)
> >
> > Assuming for a moment that we do want a mon notification if ceph-osd, s=
ay,
> > fails an assert, what would you expect the process to look like?
>=20
> Oh, that was "If you're thinking of shipping the crash reason to
> monitors, ...". As in, if you're thinking of making "ceph -s" or
> something say "osd.42 stopped: Crashed due to SIGSEGV". That part
> people have tools for, and it's in no way ceph specific.
>=20
> I did not mean that part of the message to apply to the failure
> discovery optimization.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1124186152-1332801660=:19530--
