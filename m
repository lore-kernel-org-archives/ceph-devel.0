From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Fwd: FreeBSD Jenkins build is back to normal : ceph-master #311
Date: Sun, 19 Feb 2017 18:53:37 +0100
Message-ID: <43d460b5-0d61-0c7d-9070-e4b4560744a3@digiware.nl>
References: <1236470344.23.1487517768927.JavaMail.jenkins@cephdev.digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:46441 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdBTBAe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 19 Feb 2017 20:00:34 -0500
Received: from [192.168.10.10] (asus [192.168.10.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 6234E3A25D
        for <ceph-devel@vger.kernel.org>; Sun, 19 Feb 2017 18:53:39 +0100 (CET)
In-Reply-To: <1236470344.23.1487517768927.JavaMail.jenkins@cephdev.digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

 - Fixed the Clang problems in #13523
 - Needed to exclude bluestore references from ceph_test_objectstore
   #13516

--WjW

-------- Forwarded Message --------
Subject: Jenkins build is back to normal : ceph-master #311
Date: Sun, 19 Feb 2017 16:22:48 +0100 (CET)
From: jenkins@digiware.nl
Reply-To: jenkins@digiware.nl
To: wjw@digiware.nl

http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/311/
