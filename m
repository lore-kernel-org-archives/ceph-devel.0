From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Errors in Ceph block \free\bsd jenkins
Date: Fri, 9 Jun 2017 20:17:54 +0200
Message-ID: <838cd04c-d291-42dd-56a1-995f8bd42855@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:49832 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751690AbdFISSG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Jun 2017 14:18:06 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 88F6842095
        for <ceph-devel@vger.kernel.org>; Fri,  9 Jun 2017 20:18:02 +0200 (CEST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

All my jenkins builds on FreeBSD get terminated in errors in
build/bin/ceph, due to faulty command.
Am I the only one being hampered by this?

--Wjw

Starting mgr.x
/home/jenkins/workspace/ceph-master/build/bin/ceph-mgr -i x -c
/home/jenkins/workspace/ceph-master/build/src/test/td/t-7205/ceph.conf
/home/jenkins/workspace/ceph-master/build/bin/ceph -c
/home/jenkins/workspace/ceph-master/build/src/test/td/t-7205/ceph.conf
-k /home/jenkins/workspace/ceph-master/build/src/test/td/t-7205/keyring
tell mgr.x restful create-key admin -o /tmp/tmp.ZrcYS640
no valid command found; 10 closest matches:
osd reweight-by-utilization {<int>} {<float>} {<int>} {--no-increasing}
osd pool stats {<name>}
pg repair <pgid>
pg deep-scrub <pgid>
osd blocked-by
osd perf
pg dump_stuck {inactive|unclean|stale|undersized|degraded
[inactive|unclean|stale|undersized|degraded...]} {<int>}
pg ls {<int>}
{active|clean|down|scrubbing|degraded|inconsistent|peering|repair|recovering|backfill_wait|incomplete|stale|remapped|deep_scrub|backfill|backfill_toofull|recovery_wait|undersized|activating|peered
[active|clean|down|scrubbing|degraded|inconsistent|peering|repair|recovering|backfill_wait|incomplete|stale|remapped|deep_scrub|backfill|backfill_toofull|recovery_wait|undersized|activating|peered...]}
pg scrub <pgid>
pg debug unfound_objects_exist|degraded_pgs_exist
Error EINVAL: invalid command


25% tests passed, 3 tests failed out of 4

Total Test time (real) = 503.43 sec

The following tests FAILED:
	  4 - cephtool-test-mon.sh (Failed)
	  5 - cephtool-test-osd.sh (Failed)
	  6 - cephtool-test-rados.sh (Failed)
