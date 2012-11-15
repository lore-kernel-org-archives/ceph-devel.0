From: <Eric_YH_Chen@wiwynn.com>
Subject: OSD crash on 0.48.2argonaut
Date: Thu, 15 Nov 2012 07:31:02 +0000
Message-ID: <60E83269D669544E8069A09CB69135EA0CEC66@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw2.wistron.com ([220.128.89.22]:62122 "EHLO
	TWNHUMSW2.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992728Ab2KOHbG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 02:31:06 -0500
Received: from GDC-CLDCAS-P03.whq.wistron (unverified [10.37.38.64]) by TWNHUMSW2.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta8111aa26cc0a816701828@TWNHUMSW2.wistron.com> for <ceph-devel@vger.kernel.org>;
 Thu, 15 Nov 2012 15:31:03 +0800
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear All:

I met this issue on one of osd node. Is this a known issue? Thanks!

ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
 1: /usr/bin/ceph-osd() [0x6edaba]
 2: (()+0xfcb0) [0x7f08b112dcb0]
 3: (gsignal()+0x35) [0x7f08afd09445]
 4: (abort()+0x17b) [0x7f08afd0cbab]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f08b065769d]
 6: (()+0xb5846) [0x7f08b0655846]
 7: (()+0xb5873) [0x7f08b0655873]
 8: (()+0xb596e) [0x7f08b065596e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x1de) [0x7a82fe]
 10: (ReplicatedPG::eval_repop(ReplicatedPG::RepGather*)+0x693) [0x530f83]
 11: (ReplicatedPG::repop_ack(ReplicatedPG::RepGather*, int, int, int, eversion_t)+0x159) [0x531ac9]
 12: (ReplicatedPG::sub_op_modify_reply(std::tr1::shared_ptr<OpRequest>)+0x15c) [0x53251c]
 13: (ReplicatedPG::do_sub_op_reply(std::tr1::shared_ptr<OpRequest>)+0x81) [0x54d241]
 14: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x1e3) [0x600883]
 15: (OSD::dequeue_op(PG*)+0x238) [0x5bfaf8]
 16: (ThreadPool::worker()+0x4d5) [0x79f835]
 17: (ThreadPool::WorkThread::entry()+0xd) [0x5d87cd]
 18: (()+0x7e9a) [0x7f08b1125e9a]
 19: (clone()+0x6d) [0x7f08afdc54bd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.


