From: Nathan Cutler <ncutler@suse.cz>
Subject: Seeking approval for 10.2.6 - core
Date: Wed, 22 Feb 2017 23:02:25 +0100
Message-ID: <fcc7bf79-dbee-03ad-9f50-3609dcddc63c@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932247AbdBVWC3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 22 Feb 2017 17:02:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Durgin, Josh" <jdurgin@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Josh:

A number of core backports have been merged into jewel in preparation 
for the 10.2.6 release. For a list, see:

http://tracker.ceph.com/projects/ceph/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=9&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=529&f%5B%5D=subproject_id&op%5Bsubproject_id%5D=%21*&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=

Do you think 10.2.6 can now go to QE for further testing ahead of release?

Thanks,
Nathan
