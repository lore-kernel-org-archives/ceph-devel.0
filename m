From: Shubhendu Tripathi <shtripat@redhat.com>
Subject: Command `rbd ls` hangs if cluster health HEALTH_ERR
Date: Thu, 9 Feb 2017 16:37:29 +0530
Message-ID: <7c376967-0bb3-657a-0020-eb738bd78122@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbdBILSs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 06:18:48 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED64A88E60
        for <ceph-devel@vger.kernel.org>; Thu,  9 Feb 2017 11:07:33 +0000 (UTC)
Received: from dhcp35-52.lab.eng.blr.redhat.com (dhcp-0-79.blr.redhat.com [10.70.1.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 651FB63719
        for <ceph-devel@vger.kernel.org>; Thu,  9 Feb 2017 11:07:33 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Need a help regarding rbd CLI commands hanging if the cluster is in 
error state.
Somehow I ended up having my cluster in HEALTH_ERR by creating a pool 
with huge PGnum whereas cluster has very less no of OSDs.

Now when I run the command `rbd ls` it simply hangs and does not come 
out. It requires a ctrl+C to come back to command line.

What could be a workaround or solution to this?

Regards,
Shubhendu
