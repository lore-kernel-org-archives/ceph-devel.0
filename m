From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] Ceph Crach at sync_thread_timeout after heavy random
 writes.
Date: Mon, 25 Mar 2013 08:34:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303250828280.10753@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC6228F3@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1940317950-1364225678=:10753"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47926 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758126Ab3CYPej (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 11:34:39 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC6228F3@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1940317950-1364225678=:10753
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Xiaoxi,

On Mon, 25 Mar 2013, Chen, Xiaoxi wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0 From Ceph-w , ceph reports a very high Ops (10=
000+ /s) , but
> technically , 80 spindles can provide up to 150*80/2=3D6000 IOPS for 4K=
 random
> write.
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 When digging into the code, I found that the O=
SD write data to
> Pagecache than returned, although it called ::sync_file_range, but this
> syscall doesn?t actually sync data to disk when it return,it?s an aync =
call.
> So the situation is , the random write will be extremely fast since it =
only
> write to journal and pagecache, but once syncing , it will take very lo=
ng
> time. The speed gap between journal and OSDs exist, the amount of data =
that
> need to be sync keep increasing, and it will certainly exceed 600s.

The sync_file_range is only there to push things to disk sooner, so that=20
the eventual syncfs(2) takes less time.  When the async flushing is=20
enabled, there is a limit to the number of flushes that are in the queue,=
=20
but if it hits the max it just does

    dout(10) << "queue_flusher ep " << sync_epoch << " fd " << fd << " " =
<< off << "~" << len
	     << " qlen " << flusher_queue_len=20
	     << " hit flusher_max_fds " << m_filestore_flusher_max_fds
	     << ", skipping async flush" << dendl;

Can you confirm that the filestore is taking this path?  (debug filestore=
=20
=3D 10 and then reproduce.)

You may want to try

 filestore flusher =3D false
 filestore sync flush =3D true

and see if that changes things--it will make the sync_file_range() happen=
=20
inline after the write.

Anyway, it sounds like you may be queueing up so many random writes that=20
the sync takes forever.  I've never actually seen that happen, so if we=20
can confirm that's what is going on that will be very interesting.

Thanks-
sage


>=20
> =A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 For more information, I have tried to reproduc=
e this by rados
> bench,but failed.
>=20
> =A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 Could you please let me know if you need any m=
ore informations &
> have some solutions? Thanks
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
?? ?=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0
?? ?=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0
?? ?=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0=A0 Xiaoxi
>=20
>=20
>=20
--557981400-1940317950-1364225678=:10753--
