From: Sage Weil <sage@newdream.net>
Subject: Re: MDS configuration
Date: Mon, 13 Jun 2011 09:28:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106130927110.27640@cobra.newdream.net>
References: <4DF266B9.3040407@ufm.su> <BANLkTikbpzbuwyBE++amnJj0eN=4k626aA@mail.gmail.com>
 <BANLkTikUXKAgDXz+h0jn5_nCT6dykvdDbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2005919779-1307982495=:27640"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38461 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab1FMQ0H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2011 12:26:07 -0400
In-Reply-To: <BANLkTikUXKAgDXz+h0jn5_nCT6dykvdDbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: djlee064 <djlee064@gmail.com>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2005919779-1307982495=:27640
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 12 Jun 2011, djlee064 wrote:
> ah; previous message was an example of 'during the operation' i.e.,
> randread entire sets;
> sorry about that,
> cmds uses only a tiny MB ~100MB once files stored.
> for cosd, during the operation uses 150-200mb per cosd (both during write=
/read)
>=20
> still, when considering performance, previous message stands or else
> the performance decreases if the minimum amount of RAM isn't there.

Right.  The ~1k/file ratio Greg mentioned is also without any memory=20
optimization work.  There is a huge amount of inode and dentry state=20
associated with modifications that need not consume memory all of the=20
time.  Fixing it up has been low on the priority list.

sage


>=20
> cheers
>=20
> On Sun, Jun 12, 2011 at 20:41, djlee064 <djlee064@gmail.com> wrote:
> > based on the empirical measurement, starting with a set of (real)
> > number of files, focusing mainly on small-files. and found some rough
> > relationship,
> > all filesets with same dist. i.e., ~80% <4MB file, mostly small, all 1x=
=2E replc.
> > For MDS RAM:
> >
> > You need about:
> > 0.6GB RAM to store 0.03million files (fileset vol. 1.2TB)
> > 1.2GB to store=A0 0.065million files (fileset vol. 2.4TB)
> > 1.8GB to store 0.13million files=A0 (fileset vol. 4.8TB)
> >
> > ratio of no.files per GB fortunately increases, (i.e., 0.07million per
> > GB for the 0.13million files), hopefully per-GB will support
> > 0.1million files as more files are stored.
> > then, 18GB =3D 1.8million files,
> > 180GB =3D 18million
> > 1800GB=3D 180million (this is about 6.64PB),
> >
> > So to support that amount,, we need 100 MDS nodes with 18GB purely for
> > cmds, incl mem for OS, etc, maybe 20-24GB per node.
> >
> > Cheers
> >
> > On Sat, Jun 11, 2011 at 06:47, Fyodor Ustinov <ufm@ufm.su> wrote:
> >>
> >> Hi!
> >>
> >> Which configuration would you recommended for cluster with 50-80 milli=
on files?
> >>
> >> WBR,
> >> =A0 =A0Fyodor.
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-2005919779-1307982495=:27640--
