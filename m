From: Sylar <kimulaaa@gmail.com>
Subject: Proporttions of each role in a cluster
Date: Mon, 07 Mar 2011 21:59:01 +0800
Message-ID: <1299506341.17468.2.camel@ceph>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39998 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab1CGOAZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2011 09:00:25 -0500
Received: by vws12 with SMTP id 12so3655590vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Mar 2011 06:00:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
Recently I want to build an environment of 20 servers(2U) to test Ceph.
Each 2U server has 4 cores, 16GB RAM and 4 TeraBytes for storage.
I would like to know how many MDSs, OSDes and MONs should I set for the
best performance?
Now I set 1 MDS, 19 OSDes and 5 MONs out of 19 OSDes.
I am not sure whether 1 MDS is enough for 19 OSDes or not, maybe I need
to set 2 MDSs?
As for the Monitors, I am not sure whether 5 is OK or not.(Maybe I need
to set more to ensure that the environment is always being monitored?)

And I would like to know the proportions of each role(MDS,OSD,MON) in a
cluster. Because in the future, we will have more servers to build and
test.
Thanks in advance!
--
Best Regards,
Sylar Shen

