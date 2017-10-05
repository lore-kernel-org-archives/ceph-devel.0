From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Fwd: Build failed in Jenkins: ceph-master #1284
Date: Thu, 5 Oct 2017 11:37:24 +0200
Message-ID: <d5e6320d-11e4-39e8-d359-5f5644ee74c0@digiware.nl>
References: <12802649.0.1507158600434.JavaMail.jenkins@cephdev.digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:30365 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbdJEJhu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 5 Oct 2017 05:37:50 -0400
Received: from [192.168.101.70] (vpn.ecoracks.nl [176.74.240.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id C1C042EB9F
        for <ceph-devel@vger.kernel.org>; Thu,  5 Oct 2017 11:37:29 +0200 (CEST)
In-Reply-To: <12802649.0.1507158600434.JavaMail.jenkins@cephdev.digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Some of the Cmake code has probably changed and now the execs in
    src/test/rgw/CMakeLists.txt
are not being build, BUT they are still being added to the list of
tests to run.
Needless to say that that will not work.

I've spent already quite some time on this, and even ditched the
complete build env.

Before I go into disecting, there might be somebody with a handy
pointer to the commit that got me into trouble?

Thanx,
--WjW


-------- Forwarded Message --------
Subject: Build failed in Jenkins: ceph-master #1284
Date: Thu, 5 Oct 2017 01:09:58 +0200 (CEST)
From: jenkins@digiware.nl
Reply-To: jenkins@digiware.nl
To: wjw@digiware.nl

See
<http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/1284/display/redirect?page=changes>

Changes:

[laurence.liwang] ceph_mon: use default port when not specified

[laurence.liwang] client: assert(false)->ceph_abort()

[gaosb] RGW: Multipart upload may double the quota

[laurence.liwang] common: assert(false)->ceph_abort()

[laurence.liwang] journal: assert(false)->ceph_abort()

[laurence.liwang] key_value_store: assert(false)->ceph_abort()

[laurence.liwang] librbd: assert(false)->ceph_abort()

[laurence.liwang] mgr: assert(false)->ceph_abort()

[laurence.liwang] mon: assert(false)->ceph_abort()

[laurence.liwang] rbd_replay: assert(false)->ceph_abort()

[laurence.liwang] rgw: assert(false)->ceph_abort()

[laurence.liwang] test: assert(false)->ceph_abort()

[laurence.liwang] tools: assert(false)->ceph_abort()

[liuchang0812] os/bluestore: make BlueStore opened by start_kv_only
umountable

[liuchang0812] tool: ceph-kvstore-tool doesn't umount BlueStore properly

[laurence.liwang] ceph_mon: warn on invalid port configuration

[dillaman] librbd: journal should ignore -EILSEQ errors from
compare-and-write

[mgebai] doc: add osd_max_object_size in osd configuration

[chunmei.liu]     fix dpdk build error.     when ./do_cmake.sh add
-DWITH_DPDK=ON

------------------------------------------
[...truncated 3.92 MB...]
        Start 123: unittest_osd_types
123/143 Test #123: unittest_osd_types ......................   Passed
0.13 sec
        Start 124: unittest_ecbackend
124/143 Test #124: unittest_ecbackend ......................   Passed
0.09 sec
        Start 125: unittest_osdscrub
125/143 Test #125: unittest_osdscrub .......................   Passed
0.26 sec
        Start 126: unittest_pglog
126/143 Test #126: unittest_pglog ..........................   Passed
1.93 sec
        Start 127: unittest_hitset
127/143 Test #127: unittest_hitset .........................   Passed
0.06 sec
        Start 128: unittest_osd_osdcap
128/143 Test #128: unittest_osd_osdcap .....................   Passed
0.08 sec
        Start 129: unittest_extent_cache
129/143 Test #129: unittest_extent_cache ...................   Passed
0.06 sec
        Start 130: unittest_pg_transaction
130/143 Test #130: unittest_pg_transaction .................   Passed
0.05 sec
        Start 131: unittest_ec_transaction
131/143 Test #131: unittest_ec_transaction .................   Passed
0.12 sec
        Start 132: unittest_mclock_op_class_queue
132/143 Test #132: unittest_mclock_op_class_queue ..........   Passed
0.12 sec
        Start 133: unittest_mclock_client_queue
133/143 Test #133: unittest_mclock_client_queue ............   Passed
0.12 sec
        Start 134: test_ceph_daemon.py
134/143 Test #134: test_ceph_daemon.py .....................   Passed
0.83 sec
        Start 135: test_ceph_argparse.py
135/143 Test #135: test_ceph_argparse.py ...................   Passed
47.40 sec
        Start 136: unittest_rgw_bencode
Could not find executable
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_bencode
Looked in the following places:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_bencode
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_bencode
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_bencode
Unable to find executable:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_bencode
136/143 Test #136: unittest_rgw_bencode ....................***Not Run
0.00 sec
        Start 137: unittest_rgw_period_history
Could not find executable
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_period_history
Looked in the following places:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_period_history
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_period_history
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_period_history
Unable to find executable:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_period_history
137/143 Test #137: unittest_rgw_period_history .............***Not Run
0.00 sec
        Start 138: unittest_rgw_compression
Could not find executable
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_compression
Looked in the following places:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_compression
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_compression
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_compression
Unable to find executable:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_compression
138/143 Test #138: unittest_rgw_compression ................***Not Run
0.00 sec
        Start 139: unittest_http_manager
Could not find executable
/home/jenkins/workspace/ceph-master/build/bin/unittest_http_manager
Looked in the following places:
/home/jenkins/workspace/ceph-master/build/bin/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_http_manager
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_http_manager
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_http_manager
Unable to find executable:
/home/jenkins/workspace/ceph-master/build/bin/unittest_http_manager
139/143 Test #139: unittest_http_manager ...................***Not Run
0.00 sec
        Start 140: unittest_rgw_crypto
Could not find executable
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_crypto
Looked in the following places:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_crypto
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_crypto
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_crypto
Unable to find executable:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_crypto
140/143 Test #140: unittest_rgw_crypto .....................***Not Run
0.00 sec
        Start 141: unittest_rgw_iam_policy
Could not find executable
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_iam_policy
Looked in the following places:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_iam_policy
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_iam_policy
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_rgw_iam_policy
Unable to find executable:
/home/jenkins/workspace/ceph-master/build/bin/unittest_rgw_iam_policy
141/143 Test #141: unittest_rgw_iam_policy .................***Not Run
0.00 sec
        Start 142: unittest_rgw_string
142/143 Test #142: unittest_rgw_string .....................   Passed
0.18 sec
        Start 143: unittest_rbd_mirror
143/143 Test #143: unittest_rbd_mirror .....................   Passed
193.91 sec

91% tests passed, 13 tests failed out of 143

Total Test time (real) = 2366.78 sec

The following tests FAILED:
	  2 - rbd-ggate.sh (Failed)
	  3 - run-cli-tests (Failed)
	  8 - run-tox-ceph-disk (Failed)
	  9 - run-tox-ceph-detect-init (Failed)
	 90 - readable.sh (Failed)
	114 - mgr-dashboard-smoke.sh (Failed)
	121 - safe-to-destroy.sh (Failed)
	136 - unittest_rgw_bencode (Not Run)
	137 - unittest_rgw_period_history (Not Run)
	138 - unittest_rgw_compression (Not Run)
	139 - unittest_http_manager (Not Run)
	140 - unittest_rgw_crypto (Not Run)
	141 - unittest_rgw_iam_policy (Not Run)
Errors while running CTest
Build step 'Execute shell' marked build as failure
