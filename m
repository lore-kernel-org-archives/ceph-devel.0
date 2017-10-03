From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Multisite 3+ zones
Date: Tue, 3 Oct 2017 15:52:43 +0300
Message-ID: <CABo9giS0K_2U-TdP-H-tVcA494jynf-NmzHeoXxO5a2DF4payA@mail.gmail.com>
References: <CAKRxpusXtf+Xj9+nsbN_GP7CmeqF09vMZnMnM7wA-JvvuJypYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:56879 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdJCMwp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Oct 2017 08:52:45 -0400
Received: by mail-qt0-f171.google.com with SMTP id e19so8859233qta.13
        for <ceph-devel@vger.kernel.org>; Tue, 03 Oct 2017 05:52:44 -0700 (PDT)
In-Reply-To: <CAKRxpusXtf+Xj9+nsbN_GP7CmeqF09vMZnMnM7wA-JvvuJypYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: Casey Bodley <cbodley@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Mon, Oct 2, 2017 at 11:41 PM, Two Spirit <twospirit6905@gmail.com> wrote:
> The documenation I saw talked about multi-zones, but seems to stop in
> the details at 2 zones whereas,  before, Jewel's Master zone(RW) wrote
> to Slave Zone(RO), and now after Jewel, writing to the Slave is doable
> (implying RW) to either zone. and didn't address the case of 3 or more
> zones. I thought the Master/Slave architecture implied it was limited
> to 2 zones.
>
In the new multisite (from Jewel) the default is RW but it is possible to set a
zone to be read only (slave).

> Is RW to any zone supported in 3+ zone configurations? The whole
> master/slave idea doesn't seem to make sense when talking about 3+
> zones. I'm taking a guess that this must be fully meshed, and RW to
> any modifications in one zone replicates to *all* other zones
> (independent on the number of replicas specified in any cluster)
>

Yes, we support 3+ zones configuration. All the zones in the zonegroup
replicated to each other , so yes it is a mesh. the Read Only zones only
read from the other zones.

> If this is supported, what happens if zone1 data is modified, while at
> the same time a zone2 modifies the same data but the data was not yet
> copied from the zone1 to zone2. How is this conflict handled? Does
> last write win?
>
Yes the last write will win (in the end)

> Is the RADOS "primary copy", "Chain", and "Splay" replication strategy
> also used in multisite traffic?
don't think those are related to multisite traffic which is based on REST API

Regards,
Orit
