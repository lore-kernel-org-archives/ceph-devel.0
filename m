From: Willem Jan Withagen <wjw@digiware.nl>
Subject: On FreeBSD: Could not find executable
 /home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
Date: Tue, 27 Jun 2017 11:18:59 +0200
Message-ID: <12a91c7f-df87-9415-8ced-c3928078f4d5@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:31797 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbdF0JTD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Jun 2017 05:19:03 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 7F21043F9F
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 11:19:00 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Something is dire missing to complete the test with success on FreeBSD.
Perhaps because not everything is build that has to do with dmclock?

--WjW

        Start  57: unittest_mclock_priority_queue
Could not find executable
/home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
Looked in the following places:
/home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/Release/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_mclock_priority_queue
/home/jenkins/workspace/ceph-master/build/bin/Development/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/Release/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/Debug/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/MinSizeRel/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/RelWithDebInfo/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/Deployment/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_mclock_priority_queue
home/jenkins/workspace/ceph-master/build/bin/Development/unittest_mclock_priority_queue
Unable to find executable:
/home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
 43/169 Test  #57: unittest_mclock_priority_queue ..........***Not Run
0.00 sec
