From: Willem Jan Withagen <wjw@digiware.nl>
Subject: OSD has the store locked???
Date: Tue, 14 Feb 2017 14:56:06 +0100
Message-ID: <557f1d59-33c5-3da3-926e-f87160da272b@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:21396 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbdBNN4U (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 14 Feb 2017 08:56:20 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 3F275384E8
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 14:56:15 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Running ceph_objectstore_tool.py just about all command get the
complaint that "OSD has the store locked".

Like:
Test --op list variants
OSD has the store locked
ERROR:Bad exit status 1 from
/home/jenkins/workspace/ceph-master/build/bin/ceph-objectstore-tool
--data-path /home/jenkins/workspace/ceph-master/build/cot_dir/dev/osd0
--op list --format json

Why would I get "the store locked"??

Thanx,
--WjW
