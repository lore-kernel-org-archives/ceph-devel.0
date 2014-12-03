From: Logan Barfield <lbarfield@tqhosting.com>
Subject: Expose pool quota for Libvirt
Date: Wed, 3 Dec 2014 11:39:31 -0500
Message-ID: <CACKLxkC0Xy1AShOK=cfo1F+-OJnus74KPWSgWubduhjY0+YVow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:41089 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbaLCQjc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Dec 2014 11:39:32 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so25046481wiw.15
        for <ceph-devel@vger.kernel.org>; Wed, 03 Dec 2014 08:39:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm not sure if this is already in place, but if not I think pool quotas
should be exposed in the same way as pool size so Libvirt can pick up on
them.

We currently run several KVM hypervisors backed by Ceph RBD.  We have a
CRUSH ruleset that defines SSD backed servers for RBD, and high capacity
HDD backed servers for RadosGW.

Right now when adding our RBD pool via Libvirt it sees the entire cluster's
capacity, even though the actual pool capacity is much lower.  This means
that any deployment tools that look at the available capacity when creating
VMs can't be relied upon, and we have to continually track usage manually
(we audit it anyway, but that should be in addition to built-in checks).
We can currently work around this by manually setting the capacity in the
deployment tool, but fixing it at the source seems like a much better
option.

Obviously capacity can't be automatically estimated from the CRUSH ruleset,
but with the recent addition of pool quotas it would be useful to let
Libvirt (and other clients) pull the quota size so we could set them as
needed.

Some changes will need to be made on the Libvirt side as well, but the
functionality has to be implemented in Ceph first.

I have opened an issue in the tracker for this:
http://tracker.ceph.com/issues/10226

If this functionality already exists I'll close the issue and work on
things from the Libvirt side.


Thank You,

Logan Barfield
Tranquil Hosting
