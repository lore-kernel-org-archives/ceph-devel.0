From: Sage Weil <sweil@redhat.com>
Subject: Re: osd down when run fio randwrite 4k using bluestore
Date: Mon, 10 Jul 2017 13:22:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707101321230.3424@piezo.novalocal>
References: <F0858C043E80304FBFA0A767AC8DE5E7AEF35580@H3CMLB12-EX.srv.huawei-3com.com> <F0858C043E80304FBFA0A767AC8DE5E7AEF355A2@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1852167317-1499692942=:3424"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753839AbdGJNWX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Jul 2017 09:22:23 -0400
In-Reply-To: <F0858C043E80304FBFA0A767AC8DE5E7AEF355A2@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wangwenfeng <wang.wenfeng@h3c.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1852167317-1499692942=:3424
Content-Type: TEXT/PLAIN; charset=gb2312
Content-Transfer-Encoding: 8BIT

I suspect this is the recent deferred_aggressive deadlock; the fix merged 
last week.  Please try the latest master branch and see if you can 
reproduce.

https://github.com/ceph/ceph/pull/16051

Thanks!
sage


On Mon, 10 Jul 2017, Wangwenfeng wrote:

> 
> Hi, Sage
> 　I setup a Ceph cluster of Luminous 12.0.3, it’s osd use bluestore and I create a cephfs, it’s metadata using replicated and data pool using erasure.
> 　　　pool 1 'metadata' replicated size 2 min_size 1 crush_ruleset 1 object_hash rjenkins pg_num 1024 pgp_num 1024 last_change 52 flags hashpspool stripe_width 0
> 　　　pool 2 'EC_2_1_8' erasure size 3 min_size 2 crush_ruleset 2 object_hash rjenkins pg_num 1024 pgp_num 1024 last_change 56 flags hashpspool,ec_overwrites stripe_width 8192 expected_num_objects 27000000
>   When run fio to test the cluster, which command is
> 　　　fio --numjobs=16 --iodepth=16 --ioengine=libaio --runtime=600 --direct=1 --group_reporting --rw=randwrite --bs=4k --name=aa --filename=/ec/1.txt --size=500G
> 
>   for a while time, some osds is reported down, which also in 12.1.0 and master.
> 
>   I have a question about follow code
> void BlueStore::_deferred_queue(TransContext *txc) {
>   dout(20) << __func__ << " txc " << txc << " osr " << txc->osr << dendl;
>   std::lock_guard<std::mutex> l(deferred_lock);
>   …………………………
>   if (deferred_aggressive &&
>       !txc->osr->deferred_running) {
>     _deferred_submit(txc->osr.get());
>   }
> }
> 
> If I add '!' to deferred_aggressive, the osd will not down. Would you help to point this modify is right or not?
>   if (!deferred_aggressive &&
>       !txc->osr->deferred_running) {
>     _deferred_submit(txc->osr.get());
>   }
> 
> 
> -------------------------------------------------------------------------------------------------------------------------------------
> 本邮件及其附件含有新华三技术有限公司的保密信息，仅限于发送给上面地址中列出
> 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
> 或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
> 邮件！
> This e-mail and its attachments contain confidential information from New H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!
> 
--8323329-1852167317-1499692942=:3424--
