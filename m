From: Dan van der Ster <dan@vanderster.com>
Subject: throttling reweight-by-utilization
Date: Mon, 18 Jan 2016 11:35:10 +0100
Message-ID: <CABZ+qqmnOCvGa_=XRowxHy=Q-wRihxiTs2=bX1AsDuymvOUd3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33373 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbcARKfx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jan 2016 05:35:53 -0500
Received: by mail-lf0-f53.google.com with SMTP id m198so169316953lfm.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jan 2016 02:35:52 -0800 (PST)
Received: from mail-lb0-f175.google.com (mail-lb0-f175.google.com. [209.85.217.175])
        by smtp.gmail.com with ESMTPSA id r63sm3077926lfe.38.2016.01.18.02.35.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jan 2016 02:35:50 -0800 (PST)
Received: by mail-lb0-f175.google.com with SMTP id x4so88230625lbm.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jan 2016 02:35:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'd like to propose a few changes to reweight-by-utilization which
will make it significantly less scary:

1. Change reweight-by-utilization to run in "dry run" -- display only
-- mode unless an admin runs with  --yes-i-really-really-mean-it. This
way admins can see what will be reweighted before committing to any
changes.

2. Add a configurable to limit the number of OSDs changed per execution:
  mon_reweight_max_osds_changed (default 4)

3. Add a configurable to limit the weight changed per OSD:
  mon_reweight_max_weight_change (default 0.05)

Along with (2) and (3), the main loop in reweight_by_utilization:
  https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L568
needs to sort the OSDs by utilization.

4. Make adjusting weights up optional with a new CLI option
--adjust-up. This is useful because if you have nearly full OSDs you
want to prioritize making space on those OSDs.

I have already been running with these options in a python prototype:
  https://github.com/cernceph/ceph-scripts/blob/master/tools/crush-reweight-by-utilization.py

If you agree I'll port these changes to OSDMonitor.cc and send a PR.

Best Regards,
Dan
