From: Nathan Cutler <ncutler@suse.cz>
Subject: hammer 0.94.10
Date: Sat, 21 Jan 2017 00:02:18 +0100
Message-ID: <1908e8d0-141d-3f7e-f3d1-b9c223f597a8@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbdATXCY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 18:02:24 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi John:

Three cephfs-related bugfixes were backported to hammer. For the first 
two, see [1]. These have passed an fs suite and have been merged. A 
third fix - http://tracker.ceph.com/issues/18602 - is still pending but 
should be merged very soon.

Do you think it's OK for QE to start their own round of testing?

Cheers,
Nathan

[1] 
http://tracker.ceph.com/projects/cephfs/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=525&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=
