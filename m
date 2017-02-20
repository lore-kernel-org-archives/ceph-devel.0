From: Nathan Cutler <ncutler@suse.cz>
Subject: Seeking approval for 10.2.6 - RGW
Date: Mon, 20 Feb 2017 22:56:12 +0100
Message-ID: <808b405f-3243-c69d-eedd-f8f42ed55065@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58957 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdBTV4R (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 20 Feb 2017 16:56:17 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda,

A number of RGW backports have been merged into jewel in preparation for 
the 10.2.6 release. For a list, see:

http://tracker.ceph.com/projects/rgw/issues?c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&f%5B%5D=status_id&f%5B%5D=tracker_id&f%5B%5D=fixed_version_id&f%5B%5D=&group_by=&op%5Bfixed_version_id%5D=%3D&op%5Bstatus_id%5D=%2A&op%5Btracker_id%5D=%3D&per_page=100&set_filter=1&t%5B%5D=&utf8=%E2%9C%93&v%5Bfixed_version_id%5D%5B%5D=529&v%5Btracker_id%5D%5B%5D=9

Do you think 10.2.6 can go to QE for further testing ahead of release?

Thanks,
Nathan
