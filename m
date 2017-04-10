From: Loic Dachary <loic@dachary.org>
Subject: OSD creation and device class
Date: Mon, 10 Apr 2017 12:56:00 +0200
Message-ID: <9c19c5c5-8640-63d3-debd-7105e16ceb75@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38661 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbdDJK4F (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Apr 2017 06:56:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

When the OSD is prepared, we add a --device-class option to ceph-disk that creates a device_class file and activate can use it use when creating the the OSD[1]. The ceph osd create command is given an additional optional argument (device class). If the device class argument is present, ceph osd create[2] creates a device entry in the crushmap (it currently does nothing with the crushmap) so that the corresponding device class can be preserved. This happens before update_crush_location[3] is called and since the device is not included in any crush tree it won't be used.

I'm not happy about adding an argument to osd create. We could instead have a new dedicated command create-with-device-class but I like that even less. We could also add a "ceph osd crush create-device" and have ceph-disk call it right after "ceph osd create", followed by "ceph osd crush set-device-class". That would be my second favorite: the only drawback is having a multi-step device creation during activation but all steps are idempotents that should not be a problem.

What do you think ?

Cheers

[1] https://github.com/ceph/ceph/blob/master/src/ceph-disk/ceph_disk/main.py#L1055
[2] https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L7604 
[3] https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L3024
-- 
Loïc Dachary, Artisan Logiciel Libre
