From: Sage Weil <sweil@redhat.com>
Subject: RE: Deadlock in ceph journal
Date: Tue, 19 Aug 2014 20:55:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408192052530.28244@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-711013184-1408506790=:28244"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38129 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaHTDzI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 23:55:08 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com>
Content-ID: <alpine.DEB.2.00.1408192053170.26283@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, ceph-devel@vger.kernel.org, Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, jianpeng.ma@intel.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-711013184-1408506790=:28244
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.DEB.2.00.1408192053171.26283@cobra.newdream.net>
Content-Transfer-Encoding: quoted-printable

[Copying ceph-devel, dropping ceph-users]

Yeah, that looks like a bug.  I pushed wip-filejournal that reapplies=20
Jianpeng's original patch and this one.  I'm not certain about last other=
=20
suggested fix, though, but I'm hoping that this fix explains the strange=20
behavior Jianpeng and Mark have seen?

sage


On Wed, 20 Aug 2014, Somnath Roy wrote:
>=20
> I think this is the issue..
>=20
> =A0
>=20
> http://tracker.ceph.com/issues/9073
>=20
> =A0
>=20
> Thanks & Regards
>=20
> Somnath
>=20
> =A0
>=20
> From: Somnath Roy
> Sent: Tuesday, August 19, 2014 6:25 PM
> To: Sage Weil (sage@inktank.com); Samuel Just (sam.just@inktank.com)
> Cc: ceph-users@lists.ceph.com
> Subject: Deadlock in ceph journal
>=20
> =A0
>=20
> Hi Sage/Sam,
>=20
> During our testing we found a potential deadlock scenario in the filest=
ore
> journal code base. This is happening because of two reason.
>=20
> =A0
>=20
> 1.=A0=A0=A0=A0=A0=A0 This is because code is not signaling aio_cond fro=
m
> check_aio_completion() in case seq =3D 0
>=20
> 2.=A0=A0=A0=A0=A0=A0 Following changes in the write_thread_entry() is a=
llowing a very
> first header write with seq =3D 0.
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (writeq.empty() && !must_=
write_header) {
>=20
> =A0
>=20
> =A0
>=20
> Now, during ceph-deploy activate this is what happening.
>=20
> =A0
>=20
> 1. The very first write of header with seq =3D 0 issued and it is waiti=
ng for
> aio completion. So, aio_num =3D 1.
>=20
> 2. superblock write came in and got into while (aio_num > 0) block of
> write_thread_entry() and waiting on the aio_cond
>=20
> 3. The seq =3D 0 aio completed but not setting completed_something =3D =
true and
> as a result aio_cond is not signaled.
>=20
> 4. write_thread_entry() is getting into deadlock.
>=20
> =A0
>=20
> This is a timing problem and if header write is returned before superbl=
ock
> write this will not happen and will be happening in case of block journ=
al
> device only (aio is enabled).
>=20
> =A0
>=20
> Here is the log snippet we are getting.
>=20
> =A0
>=20
> 2014-08-19 12:59:10.029363 7f60fa33b700 10 journal write_thread_entry s=
tart
>=20
> 2014-08-19 12:59:10.029395 7f60fa33b700 20 journal prepare_multi_write
> queue_pos now 4096
>=20
> 2014-08-19 12:59:10.029427 7f60fa33b700 15 journal do_aio_write writing
> 4096~0 + header
>=20
> 2014-08-19 12:59:10.029439 7f60fa33b700 20 journal write_aio_bl 0~4096 =
seq 0
>=20
> 2014-08-19 12:59:10.029442 7f60f9339700 10 journal write_finish_thread_=
entry
> enter
>=20
> 2014-08-19 12:59:10.029466 7f60fa33b700 20 journal write_aio_bl .. 0~40=
96 in
> 1
>=20
> 2014-08-19 12:59:10.029498 7f60fa33b700 20 journal write_aio_bl 4096~0 =
seq 0
>=20
> 2014-08-19 12:59:10.029505 7f60fa33b700=A0 5 journal put_throttle finis=
hed 0
> ops and 0 bytes, now 0 ops and 0 bytes
>=20
> 2014-08-19 12:59:10.029510 7f60fa33b700 20 journal write_thread_entry g=
oing
> to sleep
>=20
> 2014-08-19 12:59:10.029538 7f60ff178800 10 journal journal_start
>=20
> 2014-08-19 12:59:10.029566 7f60f9339700 20 journal write_finish_thread_=
entry
> waiting for aio(s)
>=20
> 2014-08-19 12:59:10.029726 7f60ff178800 15
> filestore(/var/lib/ceph/tmp/mnt.NKfs2R) read
> meta/23c2fcde/osd_superblock/0//-1 0~0
>=20
> 2014-08-19 12:59:10.029793 7f60ff178800 -1
> filestore(/var/lib/ceph/tmp/mnt.NKfs2R) could not find
> 23c2fcde/osd_superblock/0//-1 in index: (2) No such file or directory
>=20
> 2014-08-19 12:59:10.029815 7f60ff178800 10
> filestore(/var/lib/ceph/tmp/mnt.NKfs2R)
> FileStore::read(meta/23c2fcde/osd_superblock/0//-1) open error: (2) No =
such
> file or directory
>=20
> 2014-08-19 12:59:10.029892 7f60ff178800=A0 5
> filestore(/var/lib/ceph/tmp/mnt.NKfs2R) queue_transactions new osr(defa=
ult
> 0x42ea9f0)/0x42ea9f0
>=20
> 2014-08-19 12:59:10.029922 7f60ff178800 10 journal op_submit_start 2
>=20
> 2014-08-19 12:59:10.030009 7f60ff178800=A0 5
> filestore(/var/lib/ceph/tmp/mnt.NKfs2R) queue_transactions (writeahead)=
 2
> 0x7fff6e817080
>=20
> 2014-08-19 12:59:10.030028 7f60ff178800 10 journal op_journal_transacti=
ons 2
> 0x7fff6e817080
>=20
> 2014-08-19 12:59:10.030039 7f60ff178800=A0 5 journal submit_entry seq 2=
 len
> 505 (0x42a76f0)
>=20
> 2014-08-19 12:59:10.030065 7f60fa33b700 20 journal write_thread_entry w=
oke
> up
>=20
> 2014-08-19 12:59:10.030070 7f60fa33b700 20 journal write_thread_entry a=
io
> throttle: aio num 1 bytes 4096 ... exp 2 min_new 4 ... pending 0
>=20
> 2014-08-19 12:59:10.030076 7f60fa33b700 20 journal write_thread_entry
> deferring until more aios complete: 1 aios with 4096 bytes needs 4 byte=
s to
> start a new aio (currently 0 pending)
>=20
> 2014-08-19 12:59:10.030084 7f60ff178800 10 journal op_submit_finish 2
>=20
> 2014-08-19 12:59:10.030389 7f60f9339700 10 journal write_finish_thread_=
entry
> aio 0~4096 done
>=20
> 2014-08-19 12:59:10.030402 7f60f9339700 20 journal check_aio_completion
>=20
> 2014-08-19 12:59:10.030406 7f60f9339700 20 journal check_aio_completion
> completed seq 0 0~4096
>=20
> 2014-08-19 12:59:10.030412 7f60f9339700 20 journal write_finish_thread_=
entry
> sleeping
>=20
> 2014-08-19 12:59:15.026609 7f60fab3c700 20
> filestore(/var/lib/ceph/tmp/mnt.NKfs2R) sync_entry woke after 5.000459
>=20
> 2014-08-19 12:59:15.026659 7f60fab3c700 10 journal commit_start
> max_applied_seq 1, open_ops 0
>=20
> 2014-08-19 12:59:15.026665 7f60fab3c700 10 journal commit_start blocked=
, all
> open_ops have completed
>=20
> 2014-08-19 12:59:15.026670 7f60fab3c700 10 journal commit_start nothing=
 to
> do
>=20
> 2014-08-19 12:59:15.026676 7f60fab3c700 10 journal commit_start
>=20
> 2014-08-19 12:59:15.026691 7f60fab3c700 20
> filestore(/var/lib/ceph/tmp/mnt.NKfs2R) sync_entry waiting for max_inte=
rval
> 5.000000
>=20
> 2014-08-19 12:59:20.026826 7f60fab3c700 20
> filestore(/var/lib/ceph/tmp/mnt.NKfs2R) sync_entry woke after 5.000135
>=20
> 2014-08-19 12:59:20.026870 7f60fab3c700 10 journal commit_start
> max_applied_seq 1, open_ops 0
>=20
> 2014-08-19 12:59:20.026876 7f60fab3c700 10 journal commit_start blocked=
, all
> open_ops have completed
>=20
> 2014-08-19 12:59:20.026879 7f60fab3c700 10 journal commit_start nothing=
 to
> do
>=20
> 2014-08-19 12:59:20.026891 7f60fab3c700 10 journal commit_start
>=20
> =A0
>=20
> =A0
>=20
> Could you please confirm this as a valid defect ?
>=20
> =A0
>=20
> If so, sending a signal on aio_cond in case of seq =3D 0, could be the
> solution ?
>=20
> =A0
>=20
> Please let me know if there is any potential workaround for this while
> deploying with ceph-deploy. Will ceph-deploy accept file path as journa=
l ?
>=20
> =A0
>=20
> Thanks & Regards
>=20
> Somnath
>=20
>=20
> _______________________________________________________________________=
_____
>=20
> PLEASE NOTE: The information contained in this electronic mail message =
is
> intended only for the use of the designated recipient(s) named above. I=
f the
> reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any revi=
ew,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please no=
tify
> the sender by telephone or e-mail (as shown above) immediately and dest=
roy
> any and all copies of this message in your possession (whether hard cop=
ies
> or electronically stored copies).
>=20
>=20
>=20
--557981400-711013184-1408506790=:28244--
