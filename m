From: Patrick McGarry <pmcgarry@redhat.com>
Subject: Ceph Infrastructure Downtime
Date: Fri, 18 Nov 2016 11:26:01 -0500
Message-ID: <CAAZbbf0C2HYXsgneUbW2+OKz=2xnFJooOZQ5vj-BvRq4ARBVVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33938 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbcKRQ0C (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Nov 2016 11:26:02 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so269827821qke.1
        for <ceph-devel@vger.kernel.org>; Fri, 18 Nov 2016 08:26:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-User <ceph-users@ceph.com>, Ceph Devel <ceph-devel@vger.kernel.org>

Hey Cephers,

Due to Dreamhost shutting down the old DreamCompute cluster in their
US-East 1 region, we are in the process of beginning the migration of
Ceph infrastructure.  We will need to move download.ceph.com,
tracker.ceph.com, and docs.ceph.com to their US-East 2 region.

The current plan is to move the VMs on 25 NOV 2016 throughout the day.
Expect them to be down intermittently.

Ceph.com will remain up for migration at a later date, and already has
a message in the banner about the outage. Expect to see
notifications/banners on some of the other sites as well, but this
should serve as your main notification.

If you have any questions or concerns feel free to send them my way
and I can put you in touch with the right resource. Thanks.

-- 

Best Regards,

Patrick McGarry
Director Ceph Community || Red Hat
http://ceph.com  ||  http://community.redhat.com
@scuttlemonkey || @ceph
