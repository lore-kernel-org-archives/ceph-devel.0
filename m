From: Sage Weil <sage@newdream.net>
Subject: Re: "converting" btrfs osds to xfs?
Date: Tue, 8 May 2012 12:38:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205081238010.14100@cobra.newdream.net>
References: <CAPud5_6MkeN-6n4rGX=Mew7nGfsmOOAiAtWVgdPArio6z2d_Fg@mail.gmail.com>
 <CADvuQRHDkpiDQSn84CvVccHf-pwPzyQZZQcpy34P0TcaWAk-FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1475060255-1336505923=:14100"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37119 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099Ab2EHTiq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 May 2012 15:38:46 -0400
In-Reply-To: <CADvuQRHDkpiDQSn84CvVccHf-pwPzyQZZQcpy34P0TcaWAk-FQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Nick Bartos <nick@pistoncloud.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1475060255-1336505923=:14100
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 8 May 2012, Tommi Virtanen wrote:
> On Tue, May 8, 2012 at 8:39 AM, Nick Bartos <nick@pistoncloud.com> wrote:
> > I am considering converting some OSDs to xfs (currently running btrfs)
> > for stability reasons. =A0I have a couple of ideas for doing this, and
> > was hoping to get some comments:
> >
> > Method #1:
> > 1. =A0Check cluster health and make sure data on a specific OSD is
> > replicated elsewhere.
> > 2. =A0Bring down the OSD
> > 3. =A0Reformat it to xfs
> > 4. =A0Restart OSD
> > 5. =A0Repeat 1-4 until all btrfs OSDs have been converted.
> ...
> > Obviously #1 seems much more appetizing, but unfortunately I can't
> > seem to find out how to verify that data on a specific OSD is
> > replicated elsewhere. =A0I could go off general cluster health, but tha=
t
> > seems more error prone.
>=20
> You can set the osd weight in crush to 0 and wait for the files inside
> the osd data dir to disappear. If you want to control how much

You can also just mark the osd 'out' without touching the CRUSH map;=20
that'll be easier and a bit more efficient wrt data movement:

=09ceph osd out 123

When the one comes back, you'll need to

=09ceph osd in 123

sage

> bandwidth is consumed for this transfer, you can also drop the weight
> in e.g. 0.1 decrements. That should give you enough feedback from "du"
> or "df" to be comfortable with the fact that your data is actually
> moving elsewhere.
>=20
> I'd recommend completely removing the osd, and creating a new one; you
> can even reuse the the osd id. Just don't try to copy the files over
> from filesystem to another; the details of the btrfs interaction are
> more low-level than what just a tar or cp can capture.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1475060255-1336505923=:14100--
