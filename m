From: Nathan Cutler <ncutler@suse.cz>
Subject: OSD bug - can fill up cluster to 100%
Date: Tue, 25 Oct 2016 16:23:21 +0200
Message-ID: <2dd0d7a4-8619-ffea-503f-44ba75152a38@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbcJYOXZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 25 Oct 2016 10:23:25 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7130BAC56
        for <ceph-devel@vger.kernel.org>; Tue, 25 Oct 2016 14:23:22 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We have a report that, due to an OSD bug, it is possible to fill a 
cluster (using "rados bench write") to the point that some OSDs reach 
100% full.

The issue is http://tracker.ceph.com/issues/16878

The report came from a cluster that had 24 OSDs, each 1 TB in size and 
with an 87 GB journal on an external partition.

I tried to reproduce this on a much smaller cluster (2 OSDs, 10 GB data 
partition, 1 GB journal partition) using teuthology-openstack. I was 
able to reliably fill this cluster to 98% (past the 95% FULL mark) when 
I constructed the journal partitions so they do not end on 2048-sector 
boundary.

(When the journals are "evenly sized", the cluster fills up to 95% and 
usage does not rise further.)

I would be grateful if someone who is much more familiar with the OSD 
code than I am (and that is not a difficult criterion to meet!) could 
look at the bug report - I have posted logs and a detailed analysis.

Thanks for your time!

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
