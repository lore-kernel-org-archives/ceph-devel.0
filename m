From: Sage Weil <sage@newdream.net>
Subject: Re: osd shutdown notification
Date: Mon, 26 Mar 2012 14:55:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203261408230.19530@cobra.newdream.net>
References: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
 <CAORUGqDBoyvSFsSMVZdfWhPUFGsQTG6pZ-n9u=YnXtj0zzOGAg@mail.gmail.com>
 <Pine.LNX.4.64.1203261251230.19530@cobra.newdream.net>
 <CAORUGqDi8+Jdhoop7QYHvROBYouJd5AvHr_ZHLD5Z+j6jZHrdA@mail.gmail.com>
 <Pine.LNX.4.64.1203261310240.19530@cobra.newdream.net>
 <CAORUGqAbHhZJ-=-HXwBZjboUGVKJBP9nBHD4ZKufs7-OeCqKnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-72468473-1332796563=:19530"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52676 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623Ab2CZVzq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 17:55:46 -0400
In-Reply-To: <CAORUGqAbHhZJ-=-HXwBZjboUGVKJBP9nBHD4ZKufs7-OeCqKnw@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1203261418320.19530@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-72468473-1332796563=:19530
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1203261418321.19530@cobra.newdream.net>

On Mon, 26 Mar 2012, Tommi Virtanen wrote:
> On Mon, Mar 26, 2012 at 13:16, Sage Weil <sage@newdream.net> wrote:
> >> Perhaps a separate executable that sends "osd.42 is now definitely
> >> down" will be good enough? Hopefully you don't have two osd.42's
> >> around, anyway. And if you want that, instead of execing ceph-osd, you
> >> do a fork & exec, wait in the parent, then exec that thing that marks
> >> it down. For upstart (and often for others too), there's a "after the
> >> service exits" hook where we could also plug that in, if we wanted to.
> >
> > ...except that the way to reliably mark down a particular osd.42 requir=
es
> > data that's private to the ceph-osd instance, and unknown until it star=
ts
> > up and joins the cluster. =A0That makes it awkward to implement any kin=
d of
> > wrapper because you have to pass it a cookie using some side-channel.
>=20
> Why do you need to know where osd.42 was last seen just to be able to
> authoritatively claim osd.42 is 1) down 2) at a new location.

Not "where" but "which".  If a ceph-osd stops, and gets restarted (on same=
=20
host, different host, whatever) I want to make sure the _old_ instance is=
=20
marked down (if not already down) in the map and any new instance is not. =
=20
We can't ignore the possibility of a race, as all kinds of things can make=
=20
the notification path go faster or slower than a replacement ceph-osd=20
might.  addr is just one possible unique identifier to achieve that; we=20
could also use the up_from epoch or anything else unique to the instance. =
=20
The problem is it is unknown until the process has been alive for a while,=
=20
so a wrapper can't see it easily.

Well, the addr is (ip, port, nonce) where nonce is actually the pid, so if=
=20
we can tell what ip ceph-osd will bind to that might work...


> > execv() in the signal handler, OTOH, is easy. =A0Is it that offensive?
> >
> > The other nice thing about that is that the failure notification can be
> > informative for free: "osd.42 stopped: got SIGTERM", "osd.42 stopped:
> > failed assert at foo.cc:1234", etc.
>=20
> I'm worried about all the things that want us to exit(3). Code
> coverage, valgrind, what not.
>
> If you're thinking of shipping the crash reason to monitors, I think
> you're once again trying to replace a bunch of a sysadmin's toolkit
> with Ceph-internal features. Ones that they can't use with all the
> non-Ceph things they run on their storage cluster anyway, like statsd,
> sshd, etc. I feel confident in saying Ceph will lose that race, in
> stability, functionality and familiarity to target audience.

I see your point, but I don't know what in the sysadmin's toolkit would=20
actually do this (now or in the future).  For an external agent/wrapper to=
=20
work it would need to:

 1- start ceph-osd
 2- query it for it's cookie/nonce (or infer what it will be)
 3- wait for the process to stop/crash
 4- send a notification (using ceph specific tool)

Assuming for a moment that we do want a mon notification if ceph-osd, say,=
=20
fails an assert, what would you expect the process to look like?

sage
--557981400-72468473-1332796563=:19530--
