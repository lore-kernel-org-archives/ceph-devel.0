From: Patrick Donnelly <pdonnell@redhat.com>
Subject: MultiMDS Test Progress
Date: Thu, 4 Aug 2016 23:54:31 -0400
Message-ID: <CA+2bHPamkv7Qa5M3FhYuFRg5cJuO4aq8e_04XmvRmir4va1t6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36780 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759213AbcHEDzE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2016 23:55:04 -0400
Received: by mail-qk0-f180.google.com with SMTP id v123so119934923qkh.3
        for <ceph-devel@vger.kernel.org>; Thu, 04 Aug 2016 20:55:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all,

For the past two weeks I've been in the process of resurrecting the multimds
test suite which has not be regularly exercised in some time. This is part of
the initial work to have multiple active metadata server configurations
regularly tested and supported. Recent multimds test runs can be viewed (as
always) at [1].

The first stage of this work is to organize and process the current failures
into bug reports [2-8]. These are just the currently known failures we have
coming from our tests. Some failures like #16926 [8] are particularly
widespread and probably masking many other failures.

As the team works on these bugs, the next steps are to expand our test coverage
of the multimds suite. So far we have planned:

o [9] Testing MDS cluster size changes under load.

o [10] Testing directory fragmentation and inode export under load. This test
  will be exercising the balancer in the MDS.

o [11] Testing cluster recovery during failures migration/fragmentation.

o [To Be Filed] Testing rename with authoritative inodes/directories varying
  across multiple MDSs.

o [To Be Filed] Integrate recently added tests in the fs suite into the
  multimds suite.

Please let us know if you have any comments or questions.

[1] http://pulpito.ceph.com/?suite=multimds
[2] http://tracker.ceph.com/issues/16768
[3] http://tracker.ceph.com/issues/16807
[4] http://tracker.ceph.com/issues/16886
[5] http://tracker.ceph.com/issues/16914
[6] http://tracker.ceph.com/issues/16913
[7] http://tracker.ceph.com/issues/16925
[8] http://tracker.ceph.com/issues/16926
[9] http://tracker.ceph.com/issues/10792
[10] http://tracker.ceph.com/issues/7320
[11] http://tracker.ceph.com/issues/4492

-- 
Patrick Donnelly
