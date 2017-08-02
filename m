From: Nathan Cutler <ncutler@suse.cz>
Subject: kraken v11.2.1 cleared for QE
Date: Wed, 2 Aug 2017 15:42:53 +0200
Message-ID: <63000560-73fe-f4e9-a36e-d17d83bf8054@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34267 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751895AbdHBNm4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 2 Aug 2017 09:42:56 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yuri:

kraken v11.2.1 has been cleared for QE, so you can start testing the tip 
of "kraken" branch, whenever you're ready.

There are still three outstanding PRs, all of which are trying to 
mitigate some lingering issues with the upgrade suites: 
http://tracker.ceph.com/issues/19009#note-89

(I'll continue to work on those, but I don't they are serious enough to 
warrant delaying this release any longer.)

Ping me if you have any questions.

Nathan
