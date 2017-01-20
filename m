From: Nathan Cutler <ncutler@suse.cz>
Subject: hammer 0.94.10
Date: Sat, 21 Jan 2017 00:10:46 +0100
Message-ID: <51657470-5f41-356a-63c3-5064a8abda62@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58125 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbdATXKs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 18:10:48 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Durgin, Josh" <jdurgin@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Josh:

A number of bugfixes have been merged into hammer after passing a rados 
suite - see [1] for a list.

Do you think it's OK for QE to start their own round of testing?

Cheers,
Nathan

[1] 
http://tracker.ceph.com/projects/ceph/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=525&f%5B%5D=subproject_id&op%5Bsubproject_id%5D=%21*&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=
