From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: OSD died
Date: Wed, 25 Apr 2012 11:04:08 +0200
Message-ID: <CAMvP8PD-zKg6OhWEjM4QWSdtXmkdoca-6LghvgTgdHoiOyPPwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58344 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab2DYJE3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Apr 2012 05:04:29 -0400
Received: by yhmm54 with SMTP id m54so957279yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 Apr 2012 02:04:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

After making and removing snapshot from one of the pools, all of the
osd in cluster are dying with log like below:


2012-04-25 11:01:00.938313 7f66694b9700 osd.1 1434  removing old
osdmap epoch 966
2012-04-25 11:01:00.938330 7f66694b9700 osd.1 1434  removing old
osdmap epoch 967
2012-04-25 11:01:00.938348 7f66694b9700 osd.1 1434  advance to epoch
1435 (<= newest 1470)
2012-04-25 11:01:00.939437 7f66694b9700 osd.1 1435 advance_map epoch
1435  1325 pgs
2012-04-25 11:01:00.939455 7f66694b9700 osd.1 1435  pool 0 removed
snaps [], unchanged (snap_epoch = 0)
2012-04-25 11:01:00.939469 7f66694b9700 osd.1 1435  pool 1 removed
snaps [], unchanged (snap_epoch = 0)
2012-04-25 11:01:00.939482 7f66694b9700 osd.1 1435  pool 2 removed
snaps [], unchanged (snap_epoch = 0)
./include/interval_set.h: In function 'void interval_set<T>::erase(T,
T) [with T = snapid_t]' thread 7f66694b9700 time 2012-04-25
11:01:00.939509
./include/interval_set.h: 382: FAILED assert(_size >= 0)
 ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199dee)
 1: (OSD::advance_map(ObjectStore::Transaction&, C_Contexts*)+0x2971) [0x5cfb51]
 2: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
 3: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
 4: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
 5: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
 6: (SimpleMessenger::DispatchThread::entry()+0xd) [0x52124d]
 7: (()+0x7e9a) [0x7f6676226e9a]
 8: (clone()+0x6d) [0x7f66747db4bd]
 ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199dee)
 1: (OSD::advance_map(ObjectStore::Transaction&, C_Contexts*)+0x2971) [0x5cfb51]
 2: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
 3: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
 4: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
 5: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
 6: (SimpleMessenger::DispatchThread::entry()+0xd) [0x52124d]
 7: (()+0x7e9a) [0x7f6676226e9a]
 8: (clone()+0x6d) [0x7f66747db4bd]
*** Caught signal (Aborted) **
 in thread 7f66694b9700
 ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199dee)
 1: /usr/bin/ceph-osd() [0x6fa0c6]
 2: (()+0xfcb0) [0x7f667622ecb0]
 3: (gsignal()+0x35) [0x7f667471f445]
 4: (abort()+0x17b) [0x7f6674722bab]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f667506d69d]
 6: (()+0xb5846) [0x7f667506b846]
 7: (()+0xb5873) [0x7f667506b873]
 8: (()+0xb596e) [0x7f667506b96e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x200) [0x68f420]
 10: (OSD::advance_map(ObjectStore::Transaction&, C_Contexts*)+0x2971)
[0x5cfb51]
 11: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
 12: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
 13: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
 14: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
 15: (SimpleMessenger::DispatchThread::entry()+0xd) [0x52124d]
 16: (()+0x7e9a) [0x7f6676226e9a]
 17: (clone()+0x6d) [0x7f66747db4bd]


-- 
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
