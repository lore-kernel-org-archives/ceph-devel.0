From: Travis Nielsen <Travis.Nielsen@Quantum.com>
Subject: Independent instances of rgw
Date: Wed, 30 Aug 2017 19:56:36 +0000
Message-ID: <D5CC636A.98182%travis.nielsen@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:47232
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751347AbdH3T4i (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Aug 2017 15:56:38 -0400
Content-Language: en-US
Content-ID: <8BD83AC6B300644A954174DDE57FCE25@namprd14.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have a scenario where I'd like to create multiple independent object
stores. Think of a multi-tenant system where you'd want independent sets
of object store users.  Is there a way to do this inside a single Ceph
cluster?=20

For example, could multiple zones be hosted in the same cluster without
actually hooking them up for replication? Each zone would have its
independent set of pools, and be completely unaware of the other zones.
Each rgw daemon started could be pointed at a different zone with the
rgw_zone and related settings. This isn't how zones were designed to be
used, but is this possible?

The multi-site documentation indicates that "Each zone is backed by its
own Ceph Storage Cluster." I'm wondering if that statement might be out of
date since the pool names include the zone name in the name of the pool.
In my prototyping efforts I have not been successful thus far starting
multiple zones, however. Would be great to get your perspective on whether
this is possible.

Thanks,
Travis


