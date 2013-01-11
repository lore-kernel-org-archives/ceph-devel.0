From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Subject: Question about configuration
Date: Thu, 10 Jan 2013 16:39:12 -0800 (PST)
Message-ID: <20130110.163912.203671451.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60574 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab3AKAjP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 19:39:15 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so613485pbc.16
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 16:39:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

What will happen when constructing a cluster of 10 host,
but the hosts are gradually removed from the cluster
one by one (in each step waiting Ceph status to become healthy),
and reaches eventually to, say, 3 hosts ?

In other words, is there any problem with having 10 osd configuration
in the ceph.conf, but actually only 3 is up (the 7 are down and out) ?

I assume that if the size of the replication is 3, we can turn off
2 osds at each time, and Ceph can recover itself to the healthy state.
Is it the case ?

Thanks in advance.

regards,
Yasu

