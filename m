From: Nathan Cutler <ncutler@suse.cz>
Subject: Are we ready for Jewel v10.2.10?
Date: Thu, 7 Sep 2017 11:13:04 +0200
Message-ID: <b0dc8c09-b2d3-6b38-8afd-2cf2ae48c2e9@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754986AbdIGJNG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 7 Sep 2017 05:13:06 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>

Hi Josh, Patrick, Yehuda, Jason:

A number of backports have been merged for Jewel v10.2.10:

http://tracker.ceph.com/projects/ceph/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%3D&v%5Bstatus_id%5D%5B%5D=3&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=9&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=543&f%5B%5D=&c%5B%5D=tracker&c%5B%5D=relations&c%5B%5D=cf_2&c%5B%5D=subject&c%5B%5D=assigned_to&group_by=project&t%5B%5D=

All the last-minute backports people asked for should already be listed, 
or are undergoing testing right now in the current integration branch:

http://tracker.ceph.com/issues/20613#note-47

Please take a look and let me know if you think we can hand v10.2.10 
over to QE after the present integration round.

Thanks!

Nathan
