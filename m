From: Willem Jan Withagen <wjw@digiware.nl>
Subject: FreeBSD crushtool crashing while checking a crushmap
Date: Sat, 6 Feb 2016 23:12:16 +0100
Message-ID: <56B66FC0.70409@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:44367 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbcBFWM2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 6 Feb 2016 17:12:28 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 56AF3153413
	for <ceph-devel@vger.kernel.org>; Sat,  6 Feb 2016 23:12:25 +0100 (CET)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 2128C1534E3
	for <ceph-devel@vger.kernel.org>; Sat,  6 Feb 2016 23:12:16 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

While running run-cli-tests one of the tests dumps while checking if the
previous command has build the correct crushmap.
I've verified the actual crushmap against one build on CentOS, and they
are byte for byte equal.

Before I rebased (from beginning of januari) all these tests completed
just fine.

During checking I get the following dump:

# src/crushtool -i
src/tes/cli/crushtool/check-overlapped-rules.crushmap.ref --check
Assertion failed: (this->_map.find(inter_val) == this->_map.end()),
function gap_insert, file
/usr/local/include/boost/icl/interval_base_map.hpp, line 555.
*** Caught signal (Abort trap) **
 in thread 803e15000
 ceph version Development (no_version)
 1: 0x86f865 <_ZN4ceph9BackTraceC2Ei+0x35> at
/usr/srcs/Ceph/work/ceph/src/crushtool
 2: 0x86e5f9 <_ZL19handle_fatal_signali+0xa9> at
/usr/srcs/Ceph/work/ceph/src/crushtool
 3: 0x801811c7d <pthread_sigmask+0x50d> at /lib/libthr.so.3
 4: 0x8018112b2 <pthread_getspecific+0xe22> at /lib/libthr.so.3
2016-02-06 22:55:09.075189 803e15000 -1

Deleted remainder of the output....

And I appreciate any pointers in helping me debugging this.

--WjW
