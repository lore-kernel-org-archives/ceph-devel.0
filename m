From: Nathan Cutler <ncutler@suse.cz>
Subject: Drop upgrade/jewel-x/point-to-point-x in luminous and master
Date: Thu, 1 Feb 2018 12:39:00 +0100
Message-ID: <910ece94-b940-23ed-e2ba-a1204796dfa9@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751909AbeBALjC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:39:02 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E23A9AD72
        for <ceph-devel@vger.kernel.org>; Thu,  1 Feb 2018 11:39:00 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ceph devs and testers:

AIUI the purpose of the point-to-point-x upgrade subsuites is to test 
upgrades from one point release to another. That would seem to imply 
that these tests would be expected to produce meaningful results only 
when testing upgrades within a major release. Correct?

If so, then we could drop the entire upgrade/jewel-x/point-to-point-x 
subsuite in the luminous and master branches?

Thanks,
Nathan
