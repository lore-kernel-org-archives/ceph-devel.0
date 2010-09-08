From: Nat N <phenisha@gmail.com>
Subject: MDS crashing
Date: Wed, 8 Sep 2010 14:45:04 +1000
Message-ID: <AANLkTinOE+zRi_UHq33xPkADp-xavEbxgiW+ezUhVciT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34200 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab0IHEpH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Sep 2010 00:45:07 -0400
Received: by wwi17 with SMTP id 17so993722wwi.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Sep 2010 21:45:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi I am testing the ceph file system, all has been going OK but now it
seems my cmds is crasing with the following error

.... <snip> ...
10.09.08_13:48:40.146886 419dc940 -- 172.17.8.3:6802/8771 <== osd8
172.17.8.11:6800/8930 7 ==== osd_op_reply(28 200.00000ef9 [read
0~4194304] = 0) v1 ==== 98+0+4194304 (1203150032 0 2774819477)
0xa22080
10.09.08_13:48:40.147220 44e45940 mds0.cache creating system inode with ino:100
10.09.08_13:48:41.293977 4333f940 -- 172.17.8.3:6802/8771 --> mon2
172.17.8.4:6789/0 -- mdsbeacon(8900/thorium003 up:replay seq 34 v212)
v1 -- ?+0 0x2145500
10.09.08_13:48:41.295762 419dc940 -- 172.17.8.3:6802/8771 <== mon2
172.17.8.4:6789/0 48 ==== mdsbeacon(8900/thorium003 up:replay seq 34
v212) v2 ==== 112+0+0 (2962285251 0 0) 0x2145500
./include/interval_set.h: In function 'void interval_set<T>::insert(T,
T) [with T = inodeno_t]':
./include/interval_set.h:202: FAILED assert(0)
 1: (EMetaBlob::replay(MDS*, LogSegment*)+0x3f75) [0x691625]
 2: (EUpdate::replay(MDS*)+0x38) [0x694d28]
 3: (MDLog::_replay_thread()+0x68e) [0x68801e]
 4: (MDLog::ReplayThread::entry()+0xd) [0x4bb3cd]
 5: (Thread::_entry_func(void*)+0xa) [0x49c71a]
 6: /lib64/libpthread.so.0 [0x31d960673d]
 7: (clone()+0x6d) [0x31d8ed3d1d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.


I am using the unstable git branch as well as kernel .35, one mds and
3 monitors with around 10 osds

unfortuantely I do not have access to the core files but please find
the objdump cmds here:
http://www.geopersonalassistant.com/dump/cmds.dump.gz


Regards.
