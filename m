From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Ceph-deploy for FreeBSD
Date: Thu, 13 Apr 2017 17:34:16 +0200
Message-ID: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:28051 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdDMPeV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Apr 2017 11:34:21 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 374623D8DF
        for <ceph-devel@vger.kernel.org>; Thu, 13 Apr 2017 17:34:18 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm looking for somebody to help me get ceph-deploy running on FreeBSD...

I can get it to install with pip install, and the local part runs.
But then rouble starts already rather fast:

----
 # ceph-deploy -v -v --username wjw install cephtest
.....
[ceph_deploy.install][DEBUG ] Installing stable version jewel on cluster
ceph hosts cephtest
[ceph_deploy.install][DEBUG ] Detecting platform for host cephtest ...
Password for wjw@cephtest:
Password for wjw@cephtest:
[cephtest][DEBUG ] connection detected need for sudo
Password for wjw@cephtest:
[cephtest][DEBUG ] connected to host: wjw@cephtest
[cephtest][DEBUG ] detect platform information from remote host
[ceph_deploy][ERROR ] UnsupportedPlatform: Platform is not supported:
----

Which is due to the fact that python on FreeBSD does not fill the
Linux_distribution info:
>>> print platform.linux_distribution()
('', '', '')

Anybody out there that can help me get my head wrapped around this
remote exec stuff and get  platform_information() to return some
informative info back, like in ceph-detect-init.

After that I'll have to add the FreeBSD pkg package manager, but that
code seems more clear to me. Which would result in largely a copy/modify
exercise.

Thanx,
--WjW
