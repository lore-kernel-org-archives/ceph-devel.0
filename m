From: Sage Weil <sage@newdream.net>
Subject: Re: Replacing a failed disk/OSD: unfound object
Date: Tue, 12 Jul 2011 09:06:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107120904210.30805@cobra.newdream.net>
References: <739109542484ec419c72b1a0f941a54d@carbonite.cn>
 <CAORUGqDHG9k-o_VwWTGo3UtimfyYnrisKnEAt7nf6+B1Q5q1uw@mail.gmail.com>
 <CAORUGqD=XxjRLL6j75yg8gQkKOuuNE=ybt2wVP37cKBZcX1y8Q@mail.gmail.com>
 <620ab7bc3254ca105a1b91930afce314@carbonite.cn>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1676533080-1310486774=:30805"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57510 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab1GLQC6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2011 12:02:58 -0400
In-Reply-To: <620ab7bc3254ca105a1b91930afce314@carbonite.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Meng Zhao <mzhao@carbonite.cn>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, Ceph devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1676533080-1310486774=:30805
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 Jul 2011, Meng Zhao wrote:
> Thanks Tommi.  I rebuilt the ceph cluster a few times just to reproduce t=
he
> situation. The result seems mixed, more likely btrfs failed (after power
> reset). But it does happen anyway.
>=20
> The big question is: However rare, unfound object situation makes the *en=
tire*
> ceph file system not mountable, leads to a total lost of all data. That i=
s
> quite a risk to take for production system.  Is there a way to recover fr=
om
> such situation ?(e.g. remove the file associated with the missing object)

There isn't an easy way to do this currently, but it is very easy to add. =
=20
I've added an issue to the tracker.

The real question is whether the lost object is file data or namespace=20
metadata.  If it's namespace metadata, you may lose part of the directory=
=20
hierarchy (until the fsck/namespace rebuild work is done).  For file data,=
=20
it's easy enough to just mark the unfound object as deleted.

sage


>=20
>=20
> On Fri, 8 Jul 2011 10:08:46 -0700, Tommi Virtanen wrote:
> > [It seems I dropped the Cc: to ceph-devel, added it back.. Please
> > reply to this message instead, and sorry about that. I'm starting to
> > dislike Google Apps for mailing list traffic :( ]
> >=20
> > On Fri, Jul 8, 2011 at 10:07, Tommi Virtanen
> > <tommi.virtanen@dreamhost.com> wrote:
> > > On Fri, Jul 8, 2011 at 01:23, Meng Zhao <mzhao@carbonite.cn> wrote:
> > > > I was trying to replace a disk for an osd by following instruction =
at:
> > > > http://ceph.newdream.net/wiki/Replacing_a_failed_disk/OSD
> > > >=20
> > > > Now, ceph -w getting
> > > > 2011-07-08 15:52:39.702881 =A0 =A0pg v1602: 602 pgs: 49 active+degr=
aded, 553
> > > > active+clean+degraded; 349 MB data, 333 MB used, 566 MB / 1023 MB a=
vail;
> > > > 167/224 degraded (74.554%); 55/112 unfound (49.107%)
> > > >=20
> > > > and a copy operation hang on the ceph client forever. I cannot kill=
 (-9)
> > > > the
> > > > cp process. Is there any hope to recover my ceph filesystem?
> > >=20
> > > I'm pretty sure that the cp is hanging because Ceph chooses to wait i=
n
> > > case the unfound objects do come back (e.g. an OSD comes back online)=
=2E
> > >=20
> > > Now, in the default configuration, losing a single OSD should not hav=
e
> > > caused unfound objects in the first place. Can you provide any more
> > > information on how you got to that point?
> > >=20
> > > > My general question is: How are objects distributed among OSDs? Doe=
s
> > > > duplication (2x) guarantee that a failure of a single OSD would not=
 lose
> > > > data? =A0It appears to me that the objects are statistically redist=
ributed
> > > > and
> > > > does not guarantee physical separation of replication data location=
=2E
> > >=20
> > > The CRUSH logic has a special case for that: when picking replicas, i=
f
> > > it would pick an already used bucket, it tries again.
> > >=20
> > > My understanding is that with the default crushmap, replicas will go
> > > to different OSDs, and this is what I see in practice. If you did
> > > construct your crushmap, it's possible that you made one that allows
> > > multiple replicas on the same drive. Or even configured Ceph to
> > > maintain no replicas.
> > >=20
> > > It is also possible you got hit by a bug, most likely one not in the
> > > placement rules but in the OSDs code.
> > >=20
> > > Can you provide more information on your setup and the steps you took=
?
> > >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1676533080-1310486774=:30805--
