From: Wido den Hollander <wido@42on.com>
Subject: Staggered failing of OSDs and mon_osd_down_out_subtree_limit
Date: Thu, 16 Feb 2017 11:20:12 +0100 (CET)
Message-ID: <432482903.10105.1487240412669@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48571 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbdBPKUR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 05:20:17 -0500
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id E4DAA762EA
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 11:20:12 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm looking to implement a additional config setting which goes together with mon_osd_down_out_subtree_limit.

In this case I have 'mon_osd_down_out_subtree_limit' set to 'host' to prevent a whole host from being marked as out when it fails.

I ran in to the situation where not all OSDs failed at the same time, but staggered. The disk controller was giving issues and slowly on OSD after the other started to fail. This meant that they were not all being marked as out in the same window of mon_osd_down_out_interval (3600), but after that.

When the whole host fails at once none of the OSDs are marked as out. This is very easy to reproduce on VMs. Just stop the OSDs on by one with a interval in between.

Only the last OSD was not marked as out since that meant the whole subtree would be marked as out.

I am thinking of mon_osd_down_out_subtree_max_osd

The default would be zero, but anything greater then zero would mean the MON would check if there are not already X OSDs out in the same subtree before marking it as out.

It would log to clog with a WRN message saying it will not mark these OSDs as out since it would go over the limit of OSDs inside that subtree.

Does this sound like a sane thing to implement?

Wido
