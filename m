From: Nathan Cutler <ncutler@suse.cz>
Subject: Jewel regression (not released, but still serious)
Date: Tue, 18 Apr 2017 23:03:23 +0200
Message-ID: <012d38c3-3347-e62e-3fcd-83be48bfe842@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37891 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753561AbdDRVDb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Apr 2017 17:03:31 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8499DABBD
        for <ceph-devel@vger.kernel.org>; Tue, 18 Apr 2017 21:03:29 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Somehow, something got merged to jewel recently that caused a regression 
which showed up in 10.2.8 integration testing. Bisect is ongoing at 
http://tracker.ceph.com/issues/19538#note-30

NOTE: no released versions are affected - not even v10.2.7.

Please refrain from merging anything to jewel until the issue is resolved.

Cheers,
Nathan
