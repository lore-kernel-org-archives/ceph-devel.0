From: Nathan Cutler <ncutler@suse.cz>
Subject: hammer 0.94.10
Date: Fri, 20 Jan 2017 23:51:29 +0100
Message-ID: <c422802d-77a7-73ee-c703-0611c3691ec3@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56069 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752110AbdATWve (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 17:51:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dillaman, Jason" <dillaman@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jason:

Several bugfixes have been backported to hammer and passed an rbd suite 
- see [1] for a detailed list.

There is one pending issue - http://tracker.ceph.com/issues/18436 - that 
you earmarked for backport to hammer a couple days ago.

Should we wait for that last issue or is hammer ready for QE to start 
their own round of testing?

Cheers,
Nathan

[1] 
http://tracker.ceph.com/projects/rbd/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=525&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=
