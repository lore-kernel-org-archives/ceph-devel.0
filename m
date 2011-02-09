From: Sage Weil <sage@newdream.net>
Subject: Re: Fixing NFS
Date: Wed, 9 Feb 2011 10:52:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102091051350.20825@cobra.newdream.net>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
 <Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net> <20110203175242.GA6348@dreamer>
 <AANLkTi=u6A539u3MV4irCrKG1gYgW+oMq7NoB=k4UxkZ@mail.gmail.com>
 <AANLkTikPRdsNFBws2wY1ZnngOoKLndCYO6Y+N05v01OG@mail.gmail.com>
 <Pine.LNX.4.64.1102071933530.16784@cobra.newdream.net>
 <AANLkTik0jz_RXbrLz2m=+EvBwpBwesQ_Lr_iiCuQJHyF@mail.gmail.com>
 <Pine.LNX.4.64.1102072059260.16784@cobra.newdream.net>
 <AANLkTim=9b3OObGrsRybRNhd2x0-ropnsz-M66QZ_T5Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-120730654-1297277540=:20825"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42584 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1BISvS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Feb 2011 13:51:18 -0500
In-Reply-To: <AANLkTim=9b3OObGrsRybRNhd2x0-ropnsz-M66QZ_T5Y@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-120730654-1297277540=:20825
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 9 Feb 2011, Brian Chrisman wrote:
> On Mon, Feb 7, 2011 at 9:02 PM, Sage Weil <sage@newdream.net> wrote:
> > On Mon, 7 Feb 2011, Brian Chrisman wrote:
> >> My goal is merely to push this problem back on the NFSv4 client. =A0If=
 I
> >> can tell it "your filehandle is expired", it should request a full
> >> path lookup to re-establish the filehandle, as far as I can tell from
> >> the specs.
> >
> > Oh I see...
> >
> >> I converted the ESTALE returns to NFS4ERR_FHEXPIRED in export.c to
> >> take a stab at accomplishing this, but there are still ESTALEs coming
> >> across the wire to the client. =A0That's why I was looking to see wher=
e
> >> other things could be going wrong.
> >
> > Hmm. =A0Generally speaking, the inode is in the ceph client's cache _on=
ly_
> > if it has an MDS capability, and as long as it holds the capability it =
has
> > a stateful handle on it and will never get ESTALE. =A0So my guess is it=
's
> > coming from somewhere else in export.c. =A0Can you crank up client debu=
gging
> > (see below) and reproduce?
> >
> > sage
> >
> >
> >
> > Crank up debugging on just about everything. =A0Or you can just turn up
> > export.c...
> >
> > $ cat /home/sage/ceph/src/script/kcon_most.sh
> > #!/bin/sh -x
>=20
> Cranking up only export.c, I see mds communication troubles when I get
> the NFS stale fh.
> I also used your full-debug script and ran the same test (copying over
> my build environment, building, deleting), but the copy operation
> hosed the cluster with osds going down and all kinds of other stuff
> (this is probably an artifact of the kernel client being on the same
> node as osds etc).
> The previous messages (just export.c debugging):
>=20
> ceph:         export.c:171  : __cfh_to_dentry 10000005a56
> ffff880004176850 dentry ffff88003b788a80
> ceph:         export.c:133  : __cfh_to_dentry 10000005a56 (1000000145a/1c=
60f9f)
> ceph:         export.c:171  : __cfh_to_dentry 10000005a56
> ffff880004176850 dentry ffff88003b788a80
> ceph: mds0 reconnect start
> ceph: mds0 reconnect success
> ceph:         export.c:133  : __cfh_to_dentry 10000005a56 (1000000145a/1c=
60f9f)
> ceph:         export.c:171  : __cfh_to_dentry 10000005a56
> ffff880004176850 dentry ffff88003b788a80
> ceph: mds0 recovery completed
> libceph: mds0 10.200.98.105:6800 socket closed
> libceph: mds0 10.200.98.105:6800 connection failed

Can you look at the mds logs to see why cmds is crashing?  (Or going into=
=20
an infinite loop, or whatever it is it's doing?)

sage



> ceph: mds0 reconnect start
> ceph: mds0 reconnect success
> ceph: mds0 recovery completed
> libceph: mds0 10.200.98.111:6813 socket closed
> libceph: mds0 10.200.98.111:6813 connection failed
> libceph: mds0 10.200.98.111:6813 connection failed
> libceph: mds0 10.200.98.111:6813 connection failed
> libceph: mds0 10.200.98.111:6813 connection failed
> libceph: mds0 10.200.98.111:6813 connection failed
> libceph: mds0 10.200.98.111:6813 connection failed
> ceph:         export.c:133  : __cfh_to_dentry 10000005a56 (1000000145a/1c=
60f9f)
> ceph:         export.c:171  : __cfh_to_dentry 10000005a56
> ffff880004176850 dentry ffff88003b788a80
> libceph: mds0 10.200.98.111:6813 connection failed
> ceph: mds0 caps stale
> ceph: mds0 caps stale
> libceph: mds0 10.200.98.111:6813 connection failed
> ceph:         export.c:133  : __cfh_to_dentry 10000005a56 (1000000145a/1c=
60f9f)
> ceph:         export.c:171  : __cfh_to_dentry 10000005a56
> ffff880004176850 dentry ffff88003b788a80
> libceph: mds0 10.200.98.111:6813 connection failed
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-120730654-1297277540=:20825--
