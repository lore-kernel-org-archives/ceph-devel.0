From: Sage Weil <sage@newdream.net>
Subject: Re: pg 0.xxxx on [] is laggy
Date: Wed, 30 Jun 2010 15:06:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006301424200.29167@cobra.newdream.net>
References: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
 <Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
 <AANLkTini3YGPjANBw-FgWDld2J1cpe2GXsimpMI-0y1Z@mail.gmail.com>
 <Pine.LNX.4.64.1006301104320.29167@cobra.newdream.net>
 <AANLkTikG7OsUyBtXXfO2tI-T2LzwVOlIb32UFtPFs41z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-746065461-1277933124=:29167"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35074 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757210Ab0F3WFV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jun 2010 18:05:21 -0400
In-Reply-To: <AANLkTikG7OsUyBtXXfO2tI-T2LzwVOlIb32UFtPFs41z@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1006301506260.29167@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Paolacci?= <sebastien.paolacci@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-746065461-1277933124=:29167
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1006301506261.29167@cobra.newdream.net>

On Wed, 30 Jun 2010, S=E9bastien Paolacci wrote:
> On 6/30/10, Sage Weil <sage@newdream.net> wrote:
> > Hmm.. is this reproducible?  I just pushed something to ceph.git unstab=
le
> > that prints out useful debugging info when that happens, but the questi=
on
> > remains what is causing it to happen in the first place.  Do you mind
> > giving the latest a go and seeing what it tells us?
> >
> Yes it's definitely reproducible. I gave a try to your last commit
> (that is actually triggered), here is the log output:

Can you do the same, but with

=09debug filestore =3D 20
=09debug journal =3D 20
=09debug osd =3D 20

I'm not sure where that length 5120 write is coming from.

Thanks!
sage

>=20
> 10.06.30_22:49:37.214544 --- opened log /var/log/ceph/debian-vm1.11418 --=
-
> ceph version 0.21~rc (3235abe91863b3bffe5638b2169603f7d89ea375)
> 10.06.30_22:49:37.214655 7fec9a01c720 ---- renamed symlink
> /var/log/ceph/osd0 -> /var/log/ceph/osd0.0 ----
> 10.06.30_22:49:37.214689 7fec9a01c720 ---- created symlink
> /var/log/ceph/osd0 -> debian-vm1.11418 ----
> 10.06.30_22:49:37.214747 7fec9a01c720 -- :/0 register_entity client?
> 10.06.30_22:49:37.214876 7fec9a01c720 -- :/0 register_entity client? at :=
/0
> 10.06.30_22:49:37.214953 7fec9a01c720 -- :/0 ready :/0
> 10.06.30_22:49:37.215019 7fec9a01c720 -- :/11418 messenger.start
> 10.06.30_22:49:37.215076 7fec9a01c720 -- :/11418 shutdown :/11418
> 10.06.30_22:49:37.215091 7fec9a01c720 -- :/11418 shutdown i am not
> dispatch, setting stop flag and joining thread.
> 10.06.30_22:49:37.215107 7fec9a01c720 -- :/11418 wait: still active
> 10.06.30_22:49:37.215145 7fec9a01c720 -- :/11418 wait: woke up
> 10.06.30_22:49:37.215165 7fec9a01c720 -- :/11418 wait: everything stopped
> 10.06.30_22:49:37.215177 7fec9a01c720 -- :/11418 wait: closing pipes
> 10.06.30_22:49:37.215191 7fec9a01c720 -- :/11418 reaper
> 10.06.30_22:49:37.215202 7fec9a01c720 -- :/11418 reaper done
> 10.06.30_22:49:37.215214 7fec9a01c720 -- :/11418 wait: waiting for
> pipes  to close
> 10.06.30_22:49:37.215225 7fec9a01c720 -- :/11418 wait: done.
> 10.06.30_22:49:37.215236 7fec9a01c720 -- :/11418 shutdown complete.
> 10.06.30_22:49:37.215398 7fec9a01c720 filestore(/data/osd0) mkfs in /data=
/osd0
> 10.06.30_22:49:37.215477 7fec9a01c720 filestore(/data/osd0) mkfs
> removing old directory current
> 10.06.30_22:49:37.218588 7fec9a01c720 filestore(/data/osd0) mkfs
> removing old file magic
> 10.06.30_22:49:37.218644 7fec9a01c720 filestore(/data/osd0) mkfs
> removing old file fsid
> 10.06.30_22:49:37.218674 7fec9a01c720 filestore(/data/osd0) mkfs
> removing old file ceph_fsid
> 10.06.30_22:49:37.218703 7fec9a01c720 filestore(/data/osd0) mkfs
> removing old file whoami
> 10.06.30_22:49:37.219248 7fec9a01c720 filestore(/data/osd0) mkjournal
> created journal on /ceph-journal/osd0
> 10.06.30_22:49:37.219279 7fec9a01c720 filestore(/data/osd0) mkfs done
> in /data/osd0
> 10.06.30_22:49:37.219329 7fec9a01c720 filestore(/data/osd0) mount did
> NOT detect btrfs
> 10.06.30_22:49:37.219376 7fec9a01c720 filestore(/data/osd0) mount found s=
naps <>
> 10.06.30_22:49:37.220478 7fec98932710 journal rebuild_page_aligned
> failed, buffer::list(len=3D5120,
>         buffer::ptr(0~5120 0xab3410 in raw 0xab3410 len 5120 nref 1)
> )
> os/FileJournal.cc: In function 'void FileJournal::write_bl(off64_t&,
> ceph::bufferlist&)':
> os/FileJournal.cc:508: FAILED assert((bl.length() & ~ceph::_page_mask) =
=3D=3D 0)
>  1: (FileJournal::do_write(ceph::buffer::list&)+0x2a2) [0x55b362]
>  2: (FileJournal::write_thread_entry()+0x1fa) [0x55da6a]
>  3: (FileJournal::Writer::entry()+0xd) [0x54f04d]
>  4: (Thread::_entry_func(void*)+0x7) [0x46ca97]
>  5: (()+0x68ba) [0x7fec999fe8ba]
>  6: (clone()+0x6d) [0x7fec98c1901d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>=20
> Would you prefer to have the core dump?
>=20
> Sebastien
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-746065461-1277933124=:29167--
