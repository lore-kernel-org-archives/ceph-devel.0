From: Nathan Cutler <ncutler@suse.cz>
Subject: Are we ready for 10.2.8 - rgw
Date: Fri, 9 Jun 2017 18:17:12 +0200
Message-ID: <ef00f025-27ea-6efa-80db-2ebb15d5b819@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751644AbdFIQRT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Jun 2017 12:17:19 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A084ADB1
        for <ceph-devel@vger.kernel.org>; Fri,  9 Jun 2017 16:17:13 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda:

The following rgw backports have been merged into the jewel branch in 
preparation for the 10.2.8 release.

http://tracker.ceph.com/projects/rgw/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%3D&v%5Bstatus_id%5D%5B%5D=3&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=9&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=537&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=

Do you think it's time for QE to do its testing?

Nathan
