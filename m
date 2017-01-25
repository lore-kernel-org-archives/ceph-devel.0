From: Wido den Hollander <wido@42on.com>
Subject: osd_heartbeat_grace read by MON and OSD?
Date: Wed, 25 Jan 2017 11:51:05 +0100 (CET)
Message-ID: <1359383871.8147.1485341465123@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:42728 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdAYKvJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jan 2017 05:51:09 -0500
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 5A8C83FCE6
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jan 2017 11:51:05 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Looking at the code I see that the MON (mon/OSDMonitor.cc) and OSD (osd/OSD.cc) use the configuration setting osd_heartbeat_grace.

The name *osd* suggest that it's only read by the OSDs, but according to the source it doesn't seem to be the case.

bool OSDMonitor::check_failure(utime_t now, int target_osd, failure_info_t& fi)
{
  ...
  utime_t orig_grace(g_conf->osd_heartbeat_grace, 0);
  ...
}

bool OSDMonitor::prepare_failure(MonOpRequestRef op)
{
  ...
  utime_t failed_since =
    m->get_recv_stamp() -
    utime_t(m->failed_for ? m->failed_for : g_conf->osd_heartbeat_grace, 0);
  ...
}

Before I submit a PR to update the docs, am I reading the code correctly?

Wido
