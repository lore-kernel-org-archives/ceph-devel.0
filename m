From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Error in dd arguments for cephtool-test-rados
Date: Wed, 28 Dec 2016 10:49:33 +0100
Message-ID: <de519f1e-a4e8-1a47-bd71-d2755b424958@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:33531 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbcL1Jts (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Dec 2016 04:49:48 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 182BC346F1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Dec 2016 10:49:35 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

My FreeBSD jenkins complains since 2 builds about:

========
6: + /home/jenkins/workspace/ceph-master/build/bin/rados -p trs_pool rm
test_rados_obj
6: 2016-12-28 10:43:46.981189 817a16000 -1 WARNING: the following
dangerous and experimental features are enabled: *
6: 2016-12-28 10:43:46.982043 817a16000 -1 WARNING: the following
dangerous and experimental features are enabled: *
6: 2016-12-28 10:43:46.988431 817a16000 -1 WARNING: the following
dangerous and experimental features are enabled: *
6: error removing trs_pool>test_rados_obj: (2) No such file or directory
6: + true
6: + dd if=/dev/urandom of=rados_object_10k bs=1KB count=10
6: dd: bs: illegal numeric value
6: rm -rf /tmp/test_rados_tool.XXXXXXXXXX.CXnpsJcw; exit
6: + rm -rf /tmp/test_rados_tool.XXXXXXXXXX.CXnpsJcw
6: + exit
1/1 Test #6: cephtool-test-rados.sh ...........***Failed  436.87 sec

0% tests passed, 1 tests failed out of 1

Total Test time (real) = 436.90 sec

The following tests FAILED:
          6 - cephtool-test-rados.sh (Failed)
=========

http://www.unix.com/man-page/posix/1posix/dd/
It will accept: 1K as option, but not 1KB.

--WjW
