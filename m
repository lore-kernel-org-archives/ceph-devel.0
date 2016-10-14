From: Sage Weil <sage@newdream.net>
Subject: RE: bufferlist rebuild_aligned issue
Date: Fri, 14 Oct 2016 20:33:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610142033100.23131@piezo.us.to>
References: <7BD28126D6935A4498AE6DE60B5D4CAB314E86DD@H3CMLB12-EX.srv.huawei-3com.com> <alpine.DEB.2.11.1610142019370.23150@piezo.us.to> <BY2PR02MB3964BFD0FF2208D82C0DB1DF4DF0@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-851505411-1476477210=:23131"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58567 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753378AbcJNUdm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Oct 2016 16:33:42 -0400
In-Reply-To: <BY2PR02MB3964BFD0FF2208D82C0DB1DF4DF0@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Zhangzengran <zhangzengran@h3c.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-851505411-1476477210=:23131
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Oct 2016, Somnath Roy wrote:
> Sage,
> I am seeing the rebuild bufferlist is happening from KernelDevice::aio_write  write path as well and as a result it is popping up during profiling. Isn't the buffer supposed to aligned in this case as well ?

The bluestore rebuild is fixed as part of wip-denc, which should merge 
soon.. hopefully next week.

s
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Friday, October 14, 2016 1:26 PM
> To: Zhangzengran
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: bufferlist rebuild_aligned issue
> 
> On Fri, 14 Oct 2016, Zhangzengran wrote:
> > Hi Sage,
> >   Recently I tracked some single op, and found that the bufferlist::rebuild_aligned will cost some time that a litte longer.
> > The whole subop spend 7ms,and the pwritev spend 1.2ms, but the
> > rebuild_aligned cost 1.1ms.the test’s object length is 1M, Using rados
> > put. I think the bufferlist rebuild and align should not cost so much time. The os environment have vm.swappiness = 0 and have tcmalloc. Is this normal?
> >
> > 2016-10-14 11:50:48.131103  queue_transactions existing 0x7f8900c302c0
> > osr(134.62s3 0x7f88ff458160)
> > 2016-10-14 11:50:48.132477  queue_transactions (writeahead) 3234
> > [Transaction(0x7f8907736000),Transaction(0x7f89077361c0)]
> > >> cost 1.1ms FileJournal::prepare_entry => bufferlist::
> > >> rebuild_aligned
> 
> This looks like a bug.  In general we should never have to do a rebuild here.  Two things might be going wrong:
> 
> 1- The messenger should be reading the write into aligned memory based on the offset in the ceph_msg_header.  You can compare the buffer pointer (just dout the bufferlist var and you'll see the buffer segments and their actual data pointers) and the write offset and make sure they match up.
> 
> 2- The journal code has some delicate logic to adjust the head and tail padding so that the data buffer remains aligned to the journal blocks as well.  This code is in FileJournal::pre_pad.  It may also be that the alignment is getting clobbered by the ObjectStore::Transaction, which tries to track the largest data buffer in the transaction and note it's alignment.
> 
> I suspect one of those two things is the culprit, though!
> 
> > 2016-10-14 11:50:48.133583  _journaled_ahead 0x7f88ff586ba0 seq 3234 osr(134.62s3 0x7f88ff458160) [Transaction(0x7f8907736000),Transaction(0x7f89077361c0)]
> > 2016-10-14 11:50:48.133620  queue_op 0x7f88ff586ba0 seq 3234 osr(134.62s3 0x7f88ff458160) 1051330 bytes   (queue has 1 ops and 1051330 bytes)
> > 2016-10-14 11:50:48.133630   queueing ondisk 0x7f8903ab77c0
> > 2016-10-14 11:50:48.133654  _do_op 0x7f88ff586ba0 seq 3234
> > osr(134.62s3 0x7f88ff458160)/0x7f88ff458160 start
> > 2016-10-14 11:50:48.133669  _do_transaction on 0x7f8907736000
> > 2016-10-14 11:50:48.133685  remove
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head#298
> > 2016-10-14 11:50:48.133754  lfn_unlink: clearing omap on
> > 3#134:461e3a1c:::testfile_4M:head#298 in cid 134.62s3_head
> > 2016-10-14 11:50:48.134526  remove
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head#298 = 0
> > 2016-10-14 11:50:48.134557  _omap_setkeys
> > 134.62s3_head/3#134:46000000::::head#
> > 2016-10-14 11:50:48.134705  _omap_setkeys
> > 134.62s3_head/3#134:46000000::::head# = 0
> > 2016-10-14 11:50:48.134716  _do_transaction on 0x7f89077361c0
> > 2016-10-14 11:50:48.134723  _collection_move_rename
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head#29a from
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head#
> > 2016-10-14 11:50:48.134736  _set_replay_guard 3234.1.0 START
> > 2016-10-14 11:50:48.135859  _set_replay_guard 3234.1.0 done
> > 2016-10-14 11:50:48.136130  lfn_unlink: clearing omap on
> > 3#134:461e3a1c:::testfile_4M:head# in cid 134.62s3_head
> > 2016-10-14 11:50:48.136305  _close_replay_guard 3234.1.0
> > 2016-10-14 11:50:48.137023  _close_replay_guard 3234.1.0 done
> > 2016-10-14 11:50:48.137039  _collection_move_rename
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head#29a from
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head# = 0
> > 2016-10-14 11:50:48.137057  write
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head# 0~1048576
> > >> cost 1.2ms pwritev
> 
> This doing a buffered write, which copies data into the page cache.  It's not clear we can avoid that unless with do O_DIRECT.. which is tricky because of the way we cache file descriptors.
> 
> sage
> 
> 
> > 2016-10-14 11:50:48.138255  write
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head# 0~1048576 = 1048576
> > 2016-10-14 11:50:48.138291  setattrs
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head#
> > 2016-10-14 11:50:48.138313  setattrs
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head# = 0
> > 2016-10-14 11:50:48.138330  fgetattrs 70 getting 'hinfo_key'
> > 2016-10-14 11:50:48.138337  setattrs
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head#
> > 2016-10-14 11:50:48.138357  setattrs
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head# = 0
> > 2016-10-14 11:50:48.138371  fgetattrs 70 getting '_'
> > 2016-10-14 11:50:48.138376  fgetattrs 70 getting 'snapset'
> > 2016-10-14 11:50:48.138381  fgetattrs 70 getting 'hinfo_key'
> > 2016-10-14 11:50:48.138386  setattrs
> > 134.62s3_head/3#134:461e3a1c:::testfile_4M:head#
> > 2016-10-14 11:50:48.138409  _do_op 0x7f88ff586ba0 seq 3234 r = 0,
> > finisher 0x7f8909398680 0
> > 2016-10-14 11:50:48.138420  _finish_op 0x7f88ff586ba0 seq 3234
> > osr(134.62s3 0x7f88ff458160)/0x7f88ff458160 lat 0.007306
> >
> > Than you, best regards
> > ----------------------------------------------------------------------
> > ---------------------------------------------------------------
> > 本邮件及其附件含有杭州华三通信技术有限公司的保密信息，仅限于发送给上面地址中列出
> > 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
> > 或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
> > 邮件！
> > This e-mail and its attachments contain confidential information from
> > H3C, which is intended only for the person or entity whose address is
> > listed above. Any use of the information contained herein in any way
> > (including, but not limited to, total or partial disclosure,
> > reproduction, or dissemination) by persons other than the intended
> > recipient(s) is prohibited. If you receive this e-mail in error,
> > please notify the sender by phone or email immediately and delete it!
> >
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-851505411-1476477210=:23131--
