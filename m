From: Thomas Mueller <thomas@chaschperli.ch>
Subject: cmds crash on snaptest-2 (ceph.git/unstable)
Date: Wed, 18 Aug 2010 15:53:35 +0000 (UTC)
Message-ID: <i4gvlu$6h8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51089 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab0HRPxp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Aug 2010 11:53:45 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OlkxU-0007es-5X
	for ceph-devel@vger.kernel.org; Wed, 18 Aug 2010 17:53:44 +0200
Received: from 46-127-100-83.dclient.hispeed.ch ([46.127.100.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Aug 2010 17:53:44 +0200
Received: from thomas by 46-127-100-83.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Aug 2010 17:53:44 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

setup: 1x mds, 1x mon, 1x osd , all on the same computer, debian squeeze

the ceph.git/unstable cmds crashes on snaptest-2 while deleting snapshots with rmdir.

Revision now: 6d0ccd9c7e56dc909a0598b480705298f31fc097
Revision last known good: 2921e1350689627d74869b8a593c170ad5515b54

last lines from mds log:

10.08.18_17:35:14.439182 7f610a613710 mds0.tableclient(snaptable) _prepare 266
10.08.18_17:35:14.439196 7f610a613710 -- 127.0.0.1:6802/28872 --> mds0 127.0.0.1:6802/28872 -- mds_table_request(snaptable prepare 266 20 bytes) v1 -- ?+0 0x7a10c00
10.08.18_17:35:14.439228 7f610a613710 -- 127.0.0.1:6802/28872 <== mds0 127.0.0.1:6802/28872 0 ==== mds_table_request(snaptable prepare 266 20 bytes) v1 ==== 0+0+0 (0 0 0) 0x7a10c00
10.08.18_17:35:14.439248 7f610a613710 mds0.tableserver(snaptable) handle_prepare mds_table_request(snaptable prepare 266 20 bytes) v1
10.08.18_17:35:14.439262 7f610a613710 mds0.snap prepare v533 destroy 3e seq 10b
10.08.18_17:35:14.439277 7f610a613710 mds0.log submit_entry 245256152~61 : ETableServer snaptable prepare reqid 266 mds0 tid 533 version 533 mutation=20 bytes
10.08.18_17:35:14.439315 7f610a613710 -- 127.0.0.1:6802/28872 --> osd0 127.0.0.1:6800/28857 -- osd_op(mds0.1:11998 200.0000003a [write 1986475~110] 1.a8f4) v1 -- ?+0 0x71cf240
10.08.18_17:35:14.471583 7f610a613710 -- 127.0.0.1:6802/28872 <== client4102 127.0.0.1:0/2209280843 208178 ==== client_caps(update ino 100000099a1 65386 seq 2 caps=pAsxLsXsxFsxcrwb dirty=- wanted=Fc follows d3 size 62/62 mtime 10.08.18_17:33:28.768020) ==== 176+0+0 (2106424228 0 0) 0x3715d00
10.08.18_17:35:14.471623 7f610a613710 mds0.locker handle_client_caps on 100000099a1 follows d3 op update
10.08.18_17:35:14.471637 7f610a613710 mds0.cache pick_inode_snap follows d3 on [inode 100000099a1 [d4,head] /snaptest-2/291/31 auth v62 s=62 nl=1 n(v0 b62 1=1+0) needsnapflush={d3=4102} (iauth excl) (ilink sync) (iflock sync) (ifile excl) (ixattr excl) (iversion lock) cr={4102=0-4194304@c6} caps={4102=pAsxLsXsxFsxcrwb/pAsxXsxFsxcwb@2},l=4102 | caps needsnapflush dirty 0x27ea8c0]
10.08.18_17:35:14.471669 7f610a613710  mds0.cache.snaprealm(100000091c7 seq 198 0x3f726c0) get_snaps c6 (seq c6 cached_seq d3)
10.08.18_17:35:14.471682 7f610a613710 mds0.cache  realm snaprealm(100000091c7 seq c6 lc c6 cr c6 snaps={c6=snap(c6 100000091c7 'snap-subdir-test' 10.08.18_17:33:24.861940)} 0x3f726c0) [inode 100000091c7 [...d4,head] /snaptest-2/291/ auth v19674 snaprealm=0x3f726c0 anc f(v0 m10.08.18_17:33:28.799765 20=20+0) n(v0 rc10.08.18_17:33:28.799765 b1090 a1 21=20+1) (iauth sync) (ilink sync) (idft sync) (isnap sync) (inest mix) (ifile excl) (ixattr sync) (iversion lock) caps={4102=pAsLsXsFs/-@39},l=4102 | dirfrag caps 0x4ad2c48]
10.08.18_17:35:14.471712 7f610a613710 mds0.cache  snaps c6
10.08.18_17:35:14.471724 7f610a613710 mds0.locker   cap inode [inode 100000099a1 [d4,head] /snaptest-2/291/31 auth v62 s=62 nl=1 n(v0 b62 1=1+0) needsnapflush={d3=4102} (iauth excl) (ilink sync) (iflock sync) (ifile excl) (ixattr excl) (iversion lock) cr={4102=0-4194304@c6} caps={4102=pAsxLsXsxFsxcrwb/pAsxXsxFsxcwb@2},l=4102 | caps needsnapflush dirty 0x27ea8c0]
10.08.18_17:35:14.471753 7f610a613710 mds0.locker  follows d3 retains pAsxLsXsxFsxcrwb dirty pAsxLsXsxFsxcrwb on [inode 100000099a1 [d4,head] /snaptest-2/291/31 auth v62 s=62 nl=1 n(v0 b62 1=1+0) needsnapflush={d3=4102} (iauth excl) (ilink sync) (iflock sync) (ifile excl) (ixattr excl) (iversion lock) cr={4102=0-4194304@c6} caps={4102=pAsxLsXsxFsxcrwb/pAsxXsxFsxcwb@2},l=4102 | caps needsnapflush dirty 0x27ea8c0]
10.08.18_17:35:14.471778 7f610a613710 mds0.locker  doing async NULL snapflush on d3 from client4102
10.08.18_17:35:14.471790 7f610a613710 mds0.cache pick_inode_snap follows d2 on [inode 100000099a1 [d4,head] /snaptest-2/291/31 auth v62 s=62 nl=1 n(v0 b62 1=1+0) needsnapflush={d3=4102} (iauth excl) (ilink sync) (iflock sync) (ifile excl) (ixattr excl) (iversion lock) cr={4102=0-4194304@c6} caps={4102=pAsxLsXsxFsxcrwb/pAsxXsxFsxcwb@2},l=4102 | caps needsnapflush dirty 0x27ea8c0]
10.08.18_17:35:14.471819 7f610a613710  mds0.cache.snaprealm(100000091c7 seq 198 0x3f726c0) get_snaps c6 (seq c6 cached_seq d3)
10.08.18_17:35:14.471833 7f610a613710 mds0.cache  realm snaprealm(100000091c7 seq c6 lc c6 cr c6 snaps={c6=snap(c6 100000091c7 'snap-subdir-test' 10.08.18_17:33:24.861940)} 0x3f726c0) [inode 100000091c7 [...d4,head] /snaptest-2/291/ auth v19674 snaprealm=0x3f726c0 anc f(v0 m10.08.18_17:33:28.799765 20=20+0) n(v0 rc10.08.18_17:33:28.799765 b1090 a1 21=20+1) (iauth sync) (ilink sync) (idft sync) (isnap sync) (inest mix) (ifile excl) (ixattr sync) (iversion lock) caps={4102=pAsLsXsFs/-@39},l=4102 | dirfrag caps 0x4ad2c48]
10.08.18_17:35:14.471860 7f610a613710 mds0.cache  snaps c6
mds/Locker.cc: In function 'void Locker::handle_client_caps(MClientCaps*)':
mds/Locker.cc:1876: FAILED assert(sin != head_in)
 1: (MDS::_dispatch(Message*)+0x2175) [0x49c435]
 2: (MDS::ms_dispatch(Message*)+0x59) [0x49c9f9]
 3: (SimpleMessenger::dispatch_entry()+0x68a) [0x47ddaa]
 4: (SimpleMessenger::DispatchThread::entry()+0x4d) [0x47850d]
 5: (Thread::_entry_func(void*)+0x7) [0x48c6f7]
 6: (()+0x68ba) [0x7f610cd648ba]
 7: (clone()+0x6d) [0x7f610bd1801d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

