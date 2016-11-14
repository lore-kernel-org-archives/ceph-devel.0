From: Loic Dachary <loic@dachary.org>
Subject: How can OSD udev rules race with lvm at boot time ?
Date: Mon, 14 Nov 2016 11:26:44 +0100
Message-ID: <29b296db-034b-f91d-b7fe-b3f3f86a1df1@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35506 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934138AbcKNK0w (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2016 05:26:52 -0500
Received: from mfilter27-d.gandi.net (mfilter27-d.gandi.net [217.70.178.155])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id 42D17FB910
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 11:26:50 +0100 (CET)
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter27-d.gandi.net (mfilter27-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id fuPNjuec-MqM for <ceph-devel@vger.kernel.org>;
        Mon, 14 Nov 2016 11:26:48 +0100 (CET)
Received: from [192.168.3.3] (x4db3cfd5.dyn.telefonica.de [77.179.207.213])
        (Authenticated sender: loic@dachary.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D5350FB90F
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 11:26:44 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

It looks like OSD udev rules race with LVM at boot time. In a nutshell, if /var/lib/ceph is on a LVM volume different from /, udev may fire events trying to start OSDs before the LVM volume is mounted and fail. This problem has been reported a few times over the past months and I believe it is real.

I don't think there is any safeguard preventing such a race and it makes sense to me that it can happen sometimes. I'd like to reproduce it reliably to assert this is the reason why it happens. And, more importantly, to figure out a fix and verify it works. So far all my attemps have failed: the OSD comes back up every time. The details about this issue are at http://tracker.ceph.com/issues/17889

If someone has ideas about how to handle this, it would be most welcome :-)

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
