From: Sage Weil <sage@newdream.net>
Subject: Re: NFS over Ceph
Date: Tue, 24 Apr 2012 06:29:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204240626450.9820@cobra.newdream.net>
References: <CADxhoDTMQMrNBYE8PykjB4UCkCBmyXcUsKxnaXmfyYNbfr9-7A@mail.gmail.com>
 <Pine.LNX.4.64.1204231958020.9820@cobra.newdream.net>
 <CADxhoDR+WAWAQzS-7DTA5-9dy8sxmQByA2QnhF+CsMVsECBfbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-162571106-1335274197=:9820"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33862 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab2DXNaA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Apr 2012 09:30:00 -0400
In-Reply-To: <CADxhoDR+WAWAQzS-7DTA5-9dy8sxmQByA2QnhF+CsMVsECBfbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Calvin Morrow <calvin.morrow@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-162571106-1335274197=:9820
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 23 Apr 2012, Calvin Morrow wrote:
> On Mon, Apr 23, 2012 at 9:01 PM, Sage Weil <sage@newdream.net> wrote:
> > On Mon, 23 Apr 2012, Calvin Morrow wrote:
> >> I've been testing a couple different use scenarios with Ceph 0.45
> >> (two-node cluster, single mon, active/standby mds). =A0I have a pair o=
f
> >> KVM virtual machines acting as ceph clients to re-export iSCSI over
> >> RBD block devices, and also NFS over a Ceph mount (mount -t ceph).
> >>
> >> The iSCSI re-export is going very well. =A0So far I haven't had any
> >> issues to speak of (even while testing Pacemaker based failover).
> >>
> >> The NFS re-export isn't going nearly as well. =A0I'm running into
> >> several issues with reliability, speed, etc. =A0To start with, file
> >> operations seem painstakingly long. =A0Copying over multiple 20 Kb fil=
es
> >> takes =A0> 10 seconds per file. =A0"dd if=3D/dev/zero of=3D'.... goes =
very
> >> fast once the data transfer starts, but the actual opening of the file
> >> can take nearly as long (or longer depending on size).
> >
> > Can you try with the 'async' option in your exports file? =A0I think th=
e
> > main problem with the slowness is because of what nfsd is doing with
> > syncs, but want to confirm that.
> >
>=20
> async didn't make a difference.  I thought this pretty strange, so I
> decided to try mounting a separate dir with the ceph-fuse client
> instead of the native kernel client.  What amounted was a night and
> day difference.  I pushed a good 79 GB (my home directory) through the
> nfs server (sync) attached to the fuse client at an average speed of
> ~68 MB / sec over consumer gigabit.
>=20
> Just for completeness, I re-exported the native kernel client (after
> verifying it could browse ok, read / write files, etc.) and I was back
> to __very__ slow metadata ops (just a simple `ls` takes > 1 min).

Can you generate an mds log with 'debug ms =3D 1' in the [mds] section of=
=20
your config so we can see which operations are taking so long?

A kernel client log would also be helpful.  If you run the script=20
src/script/kcon_most.sh on the re-exporting host ceph will spam the kernel=
=20
debug log with copious amounts of information that should show up in your=
=20
kern.log.

Thanks!
sage



>=20
> Calvin
>=20
> > Generally speaking, there is an unfortunate disconnect between the NFS =
and
> > Ceph metadata protocols. =A0Ceph tries to do lots of operations and syn=
c
> > periodically and on-demand (e.g., when you fsync() a directory). =A0NFS=
,
> > OTOH, says you should sync every operation, which is usually pretty
> > horrible for performance unless you have NVRAM or an SSD or something.
> >
> > We haven't invested much time/thought into what the best behavior shoul=
d
> > be, here... NFS is pretty far down are list at the moment.
> >
> > sage
> >
> >>
> >> I've also run into cases where the directory mounted as ceph
> >> (/mnt/ceph) "hangs" on the NFS server requiring a reboot of the NFS
> >> server.
> >>
> >> That said, are there any special recommendations regarding exporting
> >> Ceph through NFS? =A0I know that in the wiki and also (still present a=
s
> >> of 3.3.3) kernel source indicates:
> >>
> >> * NFS export support
> >> *
> >> * NFS re-export of a ceph mount is, at present, only semireliable.
> >> * The basic issue is that the Ceph architectures doesn't lend itself
> >> * well to generating filehandles that will remain valid forever.
> >>
> >> Should I be trying this a different way? =A0NFS export of a filesystem
> >> (ext4 / xfs) on RBD? =A0Other options? =A0Also, does the filehandle
> >> limitation specified above apply to more than NFS (such as a KVM image
> >> using a file on a ceph mount for storage backing)?
> >>
> >> Any insight would be appreciated.
> >>
> >> Calvin
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-162571106-1335274197=:9820--
