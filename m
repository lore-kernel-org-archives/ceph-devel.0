From: Shubhendu Tripathi <shtripat@redhat.com>
Subject: Feeding pool utilization data to time series for trending
Date: Tue, 20 Dec 2016 09:49:03 +0530
Message-ID: <aa72804e-767e-aaba-a2a8-e6df0e0a0536@redhat.com>
References: <0dafd5ff-1ed6-cb05-05d3-dff3afb43c44@redhat.com>
 <c0ef7893-2bd2-d11f-b008-db566145ce84@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbcLTETG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Dec 2016 23:19:06 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81107804F5
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2016 04:19:06 +0000 (UTC)
Received: from dhcp35-52.lab.eng.blr.redhat.com (dhcp-0-79.blr.redhat.com [10.70.1.79])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBK4J4xg029418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2016 23:19:05 -0500
In-Reply-To: <c0ef7893-2bd2-d11f-b008-db566145ce84@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Team,

Our team is currently working on project named "tendrl" [1][2].
Tendrl is a management platform for software defined storage system like 
Ceph, Gluster etc.

As part of tendrl we are integrating with collectd to collect 
performance data and we maintain the time series data in graphite.

I have a question at this juncture regarding pool utilization data.
As our thought process goes, we think of using output from command "ceph 
df" and parse it to figure out pool utilization data and push it to 
graphite using collectd.
The question here is what is/would be performance impact of running 
"ceph df" command on ceph nodes. We should be running this command only 
on mon nodes I feel.

Wanted to verify with the team here if this thought process is in right 
direction and if so what ideally should be frequency of running the 
command "ceph df" from collectd.

This is just from our point of view and we are open to any other 
foolproof solution (if any).

Kindly guide us.

Regards,
Shubhendu Tripathi

[1] http://tendrl.org/
[2] https://github.com/tendrl/
