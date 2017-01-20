From: Nathan Cutler <ncutler@suse.cz>
Subject: hammer 0.94.10 approval
Date: Fri, 20 Jan 2017 23:43:28 +0100
Message-ID: <1864f77e-ab28-8d1b-97d1-a81a3ee38005@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55303 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752058AbdATWnb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 17:43:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Orit Wasserman <owasserm@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Yehuda:

Several bugfixes have been backported to hammer, after passing the rgw 
suite. See [1] for a list.

Do you think it is ready for QE to start their own round of testing ?

Cheers,
Nathan

[1] 
http://tracker.ceph.com/projects/rgw/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=*&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=525&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=
