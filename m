From: Nathan Cutler <ncutler@suse.cz>
Subject: Proposal to rename ceph-qa-suite project in tracker.ceph.com
Date: Mon, 13 Feb 2017 22:43:20 +0100
Message-ID: <d7e1ef80-56ad-63f9-cbf8-a4ef1ada8be8@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752127AbdBMVnY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Feb 2017 16:43:24 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8E885ADAE
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 21:43:22 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Now that ceph-qa-suite has been assimilated into ceph/ceph.git, shall we 
rename http://tracker.ceph.com/projects/ceph-qa-suite ?

If nobody objects, I'd like to rename it to "tests" so it would cover 
both teuthology tests and make check tests.

Nathan
