From: Alyona Kiseleva <akiselyova@mirantis.com>
Subject: Standardization of perf counters comments
Date: Wed, 11 Feb 2015 17:33:30 +0000 (UTC)
Message-ID: <loom.20150211T183150-492@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43421 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783AbbBKRkU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Feb 2015 12:40:20 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YLbGf-0006gT-3j
	for ceph-devel@vger.kernel.org; Wed, 11 Feb 2015 18:40:05 +0100
Received: from 91.218.144.129 ([91.218.144.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 18:40:05 +0100
Received: from akiselyova by 91.218.144.129 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 18:40:05 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I would like to propose something.

There are a lot of perf counters in different places in code, but the most
of them are undocumented. I found only one commented counter in OSD.cc code,
but not for all metrics. Name of counter is not very clear as it's
description, sometimes isn't at all.

So, I have an idea, that it would be great, if perf schema would contain not
only the counter type, but some description too. It can be added in
PerfCountersBuilder methods - at first as optional parameter with empty
string by default, later, may be, as required parameter. This short
description could be saved in perf_counter_data_any_d struct together with
other counter properties and appear in perf schema as the second counter
property.
It is more useful, than just comment all counters in code, because in this
case we would be able to get counter's description outside ceph in any
analize program, which will use counter's values for any performance reports.

I can implement it, if it would be interesting.

-------------------------------
Best regards,
Alyona Kiseleva 

