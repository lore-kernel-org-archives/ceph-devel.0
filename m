From: Sage Weil <sweil@redhat.com>
Subject: RE: Deadlock in ceph journal
Date: Tue, 19 Aug 2014 21:50:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408192149330.28244@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408192052530.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38347 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaHTEug (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 00:50:36 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>

On Wed, 20 Aug 2014, Somnath Roy wrote:
> Thanks Sage !
> So, the latest master should have the fix, right ?

The original patch that caused the regression is reverted, but we'd like 
to reapply it if we sort out the issues.  wip-filejournal has the 
offending patch and your fix.. but I'm eager to hear if Jianpeng and Mark 
can confirm it's complete/correct or if there is still a problem.

sage

> 
> Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Tuesday, August 19, 2014 8:55 PM
> To: Somnath Roy
> Cc: Samuel Just (sam.just@inktank.com); ceph-devel@vger.kernel.org; Mark Kirkwood; jianpeng.ma@intel.com
> Subject: RE: Deadlock in ceph journal
> 
> [Copying ceph-devel, dropping ceph-users]
> 
> Yeah, that looks like a bug.  I pushed wip-filejournal that reapplies Jianpeng's original patch and this one.  I'm not certain about last other suggested fix, though, but I'm hoping that this fix explains the strange behavior Jianpeng and Mark have seen?
> 
> sage
> 
> 
> On Wed, 20 Aug 2014, Somnath Roy wrote:
> >
> > I think this is the issue..
> >
> >
> >
> > http://tracker.ceph.com/issues/9073
> >
> >
> >
> > Thanks & Regards
> >
> > Somnath
> >
> >
> >
> > From: Somnath Roy
> > Sent: Tuesday, August 19, 2014 6:25 PM
> > To: Sage Weil (sage@inktank.com); Samuel Just (sam.just@inktank.com)
> > Cc: ceph-users@lists.ceph.com
> > Subject: Deadlock in ceph journal
> >
> >
> >
> > Hi Sage/Sam,
> >
> > During our testing we found a potential deadlock scenario in the
> > filestore journal code base. This is happening because of two reason.
> >
> >
> >
> > 1.       This is because code is not signaling aio_cond from
> > check_aio_completion() in case seq = 0
> >
> > 2.       Following changes in the write_thread_entry() is allowing a
> > very first header write with seq = 0.
> >
> >                if (writeq.empty() && !must_write_header) {
> >
> >
> >
> >
> >
> > Now, during ceph-deploy activate this is what happening.
> >
> >
> >
> > 1. The very first write of header with seq = 0 issued and it is
> > waiting for aio completion. So, aio_num = 1.
> >
> > 2. superblock write came in and got into while (aio_num > 0) block of
> > write_thread_entry() and waiting on the aio_cond
> >
> > 3. The seq = 0 aio completed but not setting completed_something =
> > true and as a result aio_cond is not signaled.
> >
> > 4. write_thread_entry() is getting into deadlock.
> >
> >
> >
> > This is a timing problem and if header write is returned before
> > superblock write this will not happen and will be happening in case of
> > block journal device only (aio is enabled).
> >
> >
> >
> > Here is the log snippet we are getting.
> >
> >
> >
> > 2014-08-19 12:59:10.029363 7f60fa33b700 10 journal write_thread_entry
> > start
> >
> > 2014-08-19 12:59:10.029395 7f60fa33b700 20 journal prepare_multi_write
> > queue_pos now 4096
> >
> > 2014-08-19 12:59:10.029427 7f60fa33b700 15 journal do_aio_write
> > writing
> > 4096~0 + header
> >
> > 2014-08-19 12:59:10.029439 7f60fa33b700 20 journal write_aio_bl 0~4096
> > seq 0
> >
> > 2014-08-19 12:59:10.029442 7f60f9339700 10 journal
> > write_finish_thread_entry enter
> >
> > 2014-08-19 12:59:10.029466 7f60fa33b700 20 journal write_aio_bl ..
> > 0~4096 in
> > 1
> >
> > 2014-08-19 12:59:10.029498 7f60fa33b700 20 journal write_aio_bl 4096~0
> > seq 0
> >
> > 2014-08-19 12:59:10.029505 7f60fa33b700  5 journal put_throttle
> > finished 0 ops and 0 bytes, now 0 ops and 0 bytes
> >
> > 2014-08-19 12:59:10.029510 7f60fa33b700 20 journal write_thread_entry
> > going to sleep
> >
> > 2014-08-19 12:59:10.029538 7f60ff178800 10 journal journal_start
> >
> > 2014-08-19 12:59:10.029566 7f60f9339700 20 journal
> > write_finish_thread_entry waiting for aio(s)
> >
> > 2014-08-19 12:59:10.029726 7f60ff178800 15
> > filestore(/var/lib/ceph/tmp/mnt.NKfs2R) read
> > meta/23c2fcde/osd_superblock/0//-1 0~0
> >
> > 2014-08-19 12:59:10.029793 7f60ff178800 -1
> > filestore(/var/lib/ceph/tmp/mnt.NKfs2R) could not find
> > 23c2fcde/osd_superblock/0//-1 in index: (2) No such file or directory
> >
> > 2014-08-19 12:59:10.029815 7f60ff178800 10
> > filestore(/var/lib/ceph/tmp/mnt.NKfs2R)
> > FileStore::read(meta/23c2fcde/osd_superblock/0//-1) open error: (2) No
> > such file or directory
> >
> > 2014-08-19 12:59:10.029892 7f60ff178800  5
> > filestore(/var/lib/ceph/tmp/mnt.NKfs2R) queue_transactions new
> > osr(default
> > 0x42ea9f0)/0x42ea9f0
> >
> > 2014-08-19 12:59:10.029922 7f60ff178800 10 journal op_submit_start 2
> >
> > 2014-08-19 12:59:10.030009 7f60ff178800  5
> > filestore(/var/lib/ceph/tmp/mnt.NKfs2R) queue_transactions
> > (writeahead) 2
> > 0x7fff6e817080
> >
> > 2014-08-19 12:59:10.030028 7f60ff178800 10 journal
> > op_journal_transactions 2
> > 0x7fff6e817080
> >
> > 2014-08-19 12:59:10.030039 7f60ff178800  5 journal submit_entry seq 2
> > len
> > 505 (0x42a76f0)
> >
> > 2014-08-19 12:59:10.030065 7f60fa33b700 20 journal write_thread_entry
> > woke up
> >
> > 2014-08-19 12:59:10.030070 7f60fa33b700 20 journal write_thread_entry
> > aio
> > throttle: aio num 1 bytes 4096 ... exp 2 min_new 4 ... pending 0
> >
> > 2014-08-19 12:59:10.030076 7f60fa33b700 20 journal write_thread_entry
> > deferring until more aios complete: 1 aios with 4096 bytes needs 4
> > bytes to start a new aio (currently 0 pending)
> >
> > 2014-08-19 12:59:10.030084 7f60ff178800 10 journal op_submit_finish 2
> >
> > 2014-08-19 12:59:10.030389 7f60f9339700 10 journal
> > write_finish_thread_entry aio 0~4096 done
> >
> > 2014-08-19 12:59:10.030402 7f60f9339700 20 journal
> > check_aio_completion
> >
> > 2014-08-19 12:59:10.030406 7f60f9339700 20 journal
> > check_aio_completion completed seq 0 0~4096
> >
> > 2014-08-19 12:59:10.030412 7f60f9339700 20 journal
> > write_finish_thread_entry sleeping
> >
> > 2014-08-19 12:59:15.026609 7f60fab3c700 20
> > filestore(/var/lib/ceph/tmp/mnt.NKfs2R) sync_entry woke after 5.000459
> >
> > 2014-08-19 12:59:15.026659 7f60fab3c700 10 journal commit_start
> > max_applied_seq 1, open_ops 0
> >
> > 2014-08-19 12:59:15.026665 7f60fab3c700 10 journal commit_start
> > blocked, all open_ops have completed
> >
> > 2014-08-19 12:59:15.026670 7f60fab3c700 10 journal commit_start
> > nothing to do
> >
> > 2014-08-19 12:59:15.026676 7f60fab3c700 10 journal commit_start
> >
> > 2014-08-19 12:59:15.026691 7f60fab3c700 20
> > filestore(/var/lib/ceph/tmp/mnt.NKfs2R) sync_entry waiting for
> > max_interval
> > 5.000000
> >
> > 2014-08-19 12:59:20.026826 7f60fab3c700 20
> > filestore(/var/lib/ceph/tmp/mnt.NKfs2R) sync_entry woke after 5.000135
> >
> > 2014-08-19 12:59:20.026870 7f60fab3c700 10 journal commit_start
> > max_applied_seq 1, open_ops 0
> >
> > 2014-08-19 12:59:20.026876 7f60fab3c700 10 journal commit_start
> > blocked, all open_ops have completed
> >
> > 2014-08-19 12:59:20.026879 7f60fab3c700 10 journal commit_start
> > nothing to do
> >
> > 2014-08-19 12:59:20.026891 7f60fab3c700 10 journal commit_start
> >
> >
> >
> >
> >
> > Could you please confirm this as a valid defect ?
> >
> >
> >
> > If so, sending a signal on aio_cond in case of seq = 0, could be the
> > solution ?
> >
> >
> >
> > Please let me know if there is any potential workaround for this while
> > deploying with ceph-deploy. Will ceph-deploy accept file path as journal ?
> >
> >
> >
> > Thanks & Regards
> >
> > Somnath
> >
> >
> > ______________________________________________________________________
> > ______
> >
> > PLEASE NOTE: The information contained in this electronic mail message
> > is intended only for the use of the designated recipient(s) named
> > above. If the reader of this message is not the intended recipient,
> > you are hereby notified that you have received this message in error
> > and that any review, dissemination, distribution, or copying of this
> > message is strictly prohibited. If you have received this
> > communication in error, please notify the sender by telephone or
> > e-mail (as shown above) immediately and destroy any and all copies of
> > this message in your possession (whether hard copies or electronically stored copies).
> >
> >
> >
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
