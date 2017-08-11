From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Finding cores in ceph-helper is even more convoluted .....
Date: Fri, 11 Aug 2017 10:51:05 +0200
Message-ID: <56f1b93d-7ec0-2515-e9cf-de5c3a659483@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:38077 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752486AbdHKIvK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Aug 2017 04:51:10 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 621B322DB5
        for <ceph-devel@vger.kernel.org>; Fri, 11 Aug 2017 10:51:08 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

@dzafman
I'm running into a small snag when running a full test:
I've added a line to show what is in the directory
```
6:
/home/jenkins/workspace/ceph-master/qa/standalone/ceph-helpers.sh:172:
teardown:  pwd
6: /home/jenkins/workspace/ceph-master/build/src/test
6:
/home/jenkins/workspace/ceph-master/qa/standalone/ceph-helpers.sh:173:
teardown:  ls .
6: CMakeFiles
6: CTestTestfile.cmake
6: Makefile
6: ObjectMap
6: bench
6: cls_hello
6: cls_lock
6: cls_log
6: cls_lua
6: cls_numops
6: cls_rbd
6: cls_refcount
6: cls_replica_log
6: cls_rgw
6: cls_sdk
6: cls_statelog
6: cls_version
6: cmake_install.cmake
6: common
6: compressor
6: core.ceph_test_objectsto.51398
6: core.unittest_bufferlist.50899
6: core.unittest_signals.50922
6: core.unittest_texttable.51005
```
CWD = build/src/test

So the setup routine already starts to fail in teardown because there
where cores, left from previous tests.
Question is how to find out who generated the cores, and do they
actually belong to the current test.
Complexing problem is that `%N` only uses the first 19 chars of a
process name.

perhaps we should set core-names to something like "core.${testname}"??

--WjW
