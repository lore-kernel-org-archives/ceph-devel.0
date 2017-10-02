From: Two Spirit <twospirit6905@gmail.com>
Subject: Multisite 3+ zones
Date: Mon, 2 Oct 2017 13:41:16 -0700
Message-ID: <CAKRxpusXtf+Xj9+nsbN_GP7CmeqF09vMZnMnM7wA-JvvuJypYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:52832 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdJBUlU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 16:41:20 -0400
Received: by mail-io0-f181.google.com with SMTP id i197so5843909ioe.9
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 13:41:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Orit Wasserman <owasserm@redhat.com>, Sage Weil <sweil@redhat.com>

The documenation I saw talked about multi-zones, but seems to stop in
the details at 2 zones whereas,  before, Jewel's Master zone(RW) wrote
to Slave Zone(RO), and now after Jewel, writing to the Slave is doable
(implying RW) to either zone. and didn't address the case of 3 or more
zones. I thought the Master/Slave architecture implied it was limited
to 2 zones.

Is RW to any zone supported in 3+ zone configurations? The whole
master/slave idea doesn't seem to make sense when talking about 3+
zones. I'm taking a guess that this must be fully meshed, and RW to
any modifications in one zone replicates to *all* other zones
(independent on the number of replicas specified in any cluster)

If this is supported, what happens if zone1 data is modified, while at
the same time a zone2 modifies the same data but the data was not yet
copied from the zone1 to zone2. How is this conflict handled? Does
last write win?

Is the RADOS "primary copy", "Chain", and "Splay" replication strategy
also used in multisite traffic?
