From: Michael Sevilla <mikesevilla3@gmail.com>
Subject: MDS has inconsistent performance
Date: Mon, 12 Jan 2015 22:17:26 -0800
Message-ID: <CAD=PzH+UxcrF-0=fpAWrXsv-CB=q1nbAxbBHSn9A_P-hS1-fGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:35646 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbbAMGR2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 01:17:28 -0500
Received: by mail-la0-f48.google.com with SMTP id gf13so926015lab.7
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jan 2015 22:17:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I can't get consistent performance with 1 MDS. I have 2 clients create
100,000 files (separate directories) in a CephFS mount. I ran the
experiment 5 times (deleting the pools/fs and restarting the MDS in
between each run). I graphed the metadata throughput (requests per
second): https://github.com/michaelsevilla/mds/blob/master/graphs/thruput.png

Sometimes (run0, run3), both clients issue 2 lookups per create to the
MDS - this makes throughput high but the runtime long since the MDS
processes many more requests.
Sometimes (run2, run4), 1 client does 2 lookups per create and the
other doesn't do any lookups.
Sometimes (run1), neither client does any lookups - this has the
fastest runtime.

Does anyone know why the client behaves differently for the same exact
experiment? Reading the client logs, it looks like sometimes the
client enters add_update_cap() and clears the inode->flags in
check_cap_issue(), then when a lookup occurs (in _lookup()), the
client can't return ENOENT locally -- forcing it ask the MDS to do the
lookup. But this only happens sometimes (e.g., run0 and run3).

Details of the experiment:
Workload: 2 clients, 100,000 creates in separate directories, using
the FUSE client
MDS config: client_cache_size = 100000000, mds_cache_size = 16384000
Cluster: 18 OSDs, 1 MDS, 1 MON, data/metadata pools have 4096 PGs
Ceph version 0.90-877-gc219c43 (c219c43cc2943c794378214d77566e3f0d3f394a)

Thanks!

Michael
