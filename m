From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Testing fuse implementation.
Date: Mon, 20 Mar 2017 17:52:19 +0100
Message-ID: <2a2aa01a-4511-1bc2-0575-051f626575ad@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:21654 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755987AbdCTQw1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 20 Mar 2017 12:52:27 -0400
Received: from [192.168.101.70] (vpn.ecoracks.nl [176.74.240.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 362E93CBD2
        for <ceph-devel@vger.kernel.org>; Mon, 20 Mar 2017 17:52:19 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Compiling ceph-fuse-fs on FreeBSD seemed like a few (1)  very tiny
change, and I'll need to update the install-deps for some extra packages.
But when I run the test-set there is not much that I see that gets
tested specifically for the fuse implementation.

So that is hidden somewhere else...
Can somebody give me a pointer?

Thanx,
--WjW
