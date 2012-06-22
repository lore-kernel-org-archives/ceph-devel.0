From: John Axel Eriksson <john@insane.se>
Subject: Rolling upgrades possible?
Date: Fri, 22 Jun 2012 11:23:13 +0200
Message-ID: <CAMmJxt+2YZBCTZ_W7xuk8HHnqfTUUuxFGtT_AoaJYqsvjB0niw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64143 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758199Ab2FVJXN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 05:23:13 -0400
Received: by obbuo13 with SMTP id uo13so1690283obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 02:23:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I guess this has been asked before, I'm just new to the list and
wondered whether it's possible to do
rolling upgrades of mons, osds and radosgw? We will soon be in the
process of migrating from our current
storage solution to Ceph/RGW. We will only use the object storage,
actually mainly the S3-interface radosgw
supplies.

Right now we have a very small test-installation - 1 mon, 2 osds where
the mon also runs rgw. Next week I've
heard that 0.48 might be released, if we upgrade to that, do we have
to shut down the cluster during the upgrade
or can we do a rolling upgrade while still responding to PUTs and
GETs? If not possible yet, is this in the pipeline?

Best,
John
