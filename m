From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/4] config: Update sample configuration to new naming
 scheme
Date: Mon, 18 Apr 2011 10:14:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104181012320.9282@cobra.newdream.net>
References: <1303032724-13456-1-git-send-email-wido@widodh.nl>
 <1303032724-13456-2-git-send-email-wido@widodh.nl>
 <BANLkTikdn5JmByEum8Phz_0nK0G7f5W7vQ@mail.gmail.com>
 <1303110111.5322.223.camel@wido-laptop.pcextreme.nl>
 <BANLkTimLYdfzV3Jodyy8HLtm0VosKRd5tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1557915082-1303146885=:9282"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34770 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420Ab1DRRLA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 13:11:00 -0400
In-Reply-To: <BANLkTimLYdfzV3Jodyy8HLtm0VosKRd5tQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1557915082-1303146885=:9282
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 18 Apr 2011, Colin McCabe wrote:
> On Mon, Apr 18, 2011 at 12:01 AM, Wido den Hollander <wido@widodh.nl> wro=
te:
> > Hi,
> >
> > On Sun, 2011-04-17 at 17:37 -0700, Colin McCabe wrote:
> >> I don't think we want log to syslog to be in the sample configuration
> >> file. Maybe we could include it, but commented out. Most users will
> >> want to enable logging to a file or to syslog, but not both.
> >>
> >
> > Ah yes, I see. The syslog was my bad, my idea was to have it commented
> > out, but have it just as a reference in there, didn't check that good
> > enough.
> >
> > But right now you can only disable logging to a file by setting:
> >
> > log file =3D
> >
> > That seems a bit odd, "log file =3D false" would be easier.
>=20
> Disabling the log file with an empty string seems pretty intuitive to
> me. We used to have a separate boolean controlling this, and it was
> very confusing to users.
>=20
> >
> > Imho the current sample config is still broken.
> >
> > Monitors names are only numeric, shouldn't we encourage users to give
> > them a full name? mon.alpha, mon.beta, etc?

Yeah.. I thought they were a, b, c, but if they're not, they should be! =20
Using numbers for the id is a recipe for confusion because they are=20
dynamically assigned numerical ids at runtime irrespective of their=20
alphanumeric id.

> > osd journal =3D /data/osd$id/journal
> >
> > That will result in: /data/osd0/journal
> >
> > When the osd's name is osd.0, that also seems a bit weird, would $name
> > be better there then osd$id (see my patch).
> >
> > Same goes for data btw
>=20
> It would be nice to have all of $name, $type and $id somewhere in
> there so that users know they exist. Aside from that, I don't really
> have a strong opinion...

We should be consistent with the . throughout, whatever we do.  I'm fine=20
with osd.$id or just $name (e.g. /data/$name)...

sage


>=20
> cheers,
> Colin
>=20
> >
> > Wido
> >
> >> Colin
> >>
> >>
> >> On Sun, Apr 17, 2011 at 2:32 AM, Wido den Hollander <wido@widodh.nl> w=
rote:
> >> >
> >> > Signed-off-by: Wido den Hollander <wido@widodh.nl>
> >> > ---
> >> > =A0src/sample.ceph.conf | =A0 23 +++++++++++++----------
> >> > =A01 files changed, 13 insertions(+), 10 deletions(-)
> >> >
> >> > diff --git a/src/sample.ceph.conf b/src/sample.ceph.conf
> >> > index bb874e7..31674f6 100644
> >> > --- a/src/sample.ceph.conf
> >> > +++ b/src/sample.ceph.conf
> >> > @@ -24,6 +24,9 @@
> >> > =A0 =A0 =A0 =A0 ; set up pid files
> >> > =A0 =A0 =A0 =A0 pid file =3D /var/run/ceph/$name.pid
> >> >
> >> > + =A0 =A0 =A0 =A0; Also log to syslog
> >> > + =A0 =A0 =A0 =A0log to syslog =3D true
> >> > +
> >> > =A0; monitors
> >> > =A0; =A0You need at least one. =A0You need at least three if you wan=
t to
> >> > =A0; =A0tolerate any node failures. =A0Always create an odd number.
> >> > @@ -37,15 +40,15 @@
> >> > =A0 =A0 =A0 =A0;debug paxos =3D 20
> >> > =A0 =A0 =A0 =A0;debug auth =3D 20
> >> >
> >> > -[mon0]
> >> > +[mon.alpha]
> >> > =A0 =A0 =A0 =A0host =3D alpha
> >> > =A0 =A0 =A0 =A0mon addr =3D 192.168.0.10:6789
> >> >
> >> > -[mon1]
> >> > +[mon.beta]
> >> > =A0 =A0 =A0 =A0host =3D beta
> >> > =A0 =A0 =A0 =A0mon addr =3D 192.168.0.11:6789
> >> >
> >> > -[mon2]
> >> > +[mon.gamma]
> >> > =A0 =A0 =A0 =A0host =3D gamma
> >> > =A0 =A0 =A0 =A0mon addr =3D 192.168.0.12:6789
> >> >
> >> > @@ -70,16 +73,16 @@
> >> > =A0; =A0Define as many as you like.
> >> > =A0[osd]
> >> > =A0 =A0 =A0 =A0; This is where the btrfs volume will be mounted.
> >> > - =A0 =A0 =A0 osd data =3D /data/osd$id
> >> > + =A0 =A0 =A0 osd data =3D /data/$name
> >> >
> >> > =A0 =A0 =A0 =A0; Ideally, make this a separate disk or partition. =
=A0A few
> >> > =A0 =A0 =A0 =A0; hundred MB should be enough; more if you have fast =
or many
> >> > =A0 =A0 =A0 =A0; disks. =A0You can use a file under the osd data dir=
 if need be
> >> > - =A0 =A0 =A0 ; (e.g. /data/osd$id/journal), but it will be slower t=
han a
> >> > + =A0 =A0 =A0 ; (e.g. /data/$name/journal), but it will be slower th=
an a
> >> > =A0 =A0 =A0 =A0; separate disk or partition.
> >> >
> >> > =A0 =A0 =A0 =A0 ; This is an example of a file-based journal.
> >> > - =A0 =A0 =A0 osd journal =3D /data/osd$id/journal
> >> > + =A0 =A0 =A0 osd journal =3D /data/$name/journal
> >> > =A0 =A0 =A0 =A0osd journal size =3D 1000 ; journal size, in megabyte=
s
> >> >
> >> > =A0 =A0 =A0 =A0; osd logging to debug osd issues, in order of likeli=
hood of being
> >> > @@ -89,7 +92,7 @@
> >> > =A0 =A0 =A0 =A0;debug filestore =3D 20
> >> > =A0 =A0 =A0 =A0;debug journal =3D 20
> >> >
> >> > -[osd0]
> >> > +[osd.0]
> >> > =A0 =A0 =A0 =A0host =3D delta
> >> >
> >> > =A0 =A0 =A0 =A0; if 'btrfs devs' is not specified, you're responsibl=
e for
> >> > @@ -98,14 +101,14 @@
> >> > =A0 =A0 =A0 =A0; usually fine for basic testing).
> >> > =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdx
> >> >
> >> > -[osd1]
> >> > +[osd.1]
> >> > =A0 =A0 =A0 =A0host =3D epsilon
> >> > =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdy
> >> >
> >> > -[osd2]
> >> > +[osd.2]
> >> > =A0 =A0 =A0 =A0host =3D zeta
> >> > =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdx
> >> >
> >> > -[osd3]
> >> > +[osd.3]
> >> > =A0 =A0 =A0 =A0host =3D eta
> >> > =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdy
> >> > --
> >> > 1.7.0.4
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >> >
> >
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1557915082-1303146885=:9282--
