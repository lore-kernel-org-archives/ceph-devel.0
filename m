From: Nathan Cutler <ncutler@suse.cz>
Subject: Seeking approval for 10.2.6 - CephFS
Date: Tue, 21 Feb 2017 12:41:34 +0100
Message-ID: <3049e8c4-d207-0c62-c6cb-6a7c1d5f871e@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdBULli (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 21 Feb 2017 06:41:38 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi John:

A number of CephFS backports have been merged into jewel in preparation 
for the 10.2.6 release. For a list, see:

http://tracker.ceph.com/projects/cephfs/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=9&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=529&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=

These include http://tracker.ceph.com/issues/18708 which you mentioned 
was a blocker.

Do you think 10.2.6 can now go to QE for further testing ahead of release?

Thanks,
Nathan
