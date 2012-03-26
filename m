From: Sage Weil <sage@newdream.net>
Subject: Re: osd shutdown notification
Date: Mon, 26 Mar 2012 12:52:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203261251230.19530@cobra.newdream.net>
References: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
 <CAORUGqDBoyvSFsSMVZdfWhPUFGsQTG6pZ-n9u=YnXtj0zzOGAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1063115870-1332791571=:19530"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37716 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab2CZTwx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 15:52:53 -0400
In-Reply-To: <CAORUGqDBoyvSFsSMVZdfWhPUFGsQTG6pZ-n9u=YnXtj0zzOGAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1063115870-1332791571=:19530
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 26 Mar 2012, Tommi Virtanen wrote:
> On Mon, Mar 26, 2012 at 12:36, Sage Weil <sage@newdream.net> wrote:
> > Currently when you shutdown/kill a ceph-osd it is no different from it
> > crashing: you have to wait N seconds for its peers to conclude the proc=
ess
> > is down before the OSD is deemed 'failed' and the osd map is updated.
> >
> > This would be pretty easy to improve on:
> >
> > =A0- on a clean shutdown (e.g., due to SIGTERM), we could execv a call =
to
> > =A0 the ceph tool to tell the monitors the osd stopped (maybe with a
> > =A0 'reason' and nice log message).
> >
> > =A0- on an unclean shutdown (e.g., failed assert, segfault) we can
> > =A0 do the same, with an appropriate message in the system log
>=20
> A clean shutdown can send the "This location is now defunct" message
> itself, execve seems to be extra just complications for it.

Yeah
=20
> For daemon crashes, perhaps the next run, after upstart/etc restarts
> the daemon, can somehow convince others proactively that the new
> osd.42 is better than the old osd.42. That sounds like a good feature
> to have..

That much we already have, but startup/restart can take a while. =20
sysvinit doesn't do auto-restart, though, and it would be nice not to rely=
=20
on it in upstart/whatever. =20

I can also imagine a scenario where we don't have auto-restart but do want=
=20
fast failure notification...

sage
--557981400-1063115870-1332791571=:19530--
