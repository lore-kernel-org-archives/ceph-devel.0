From: Loic Dachary <loic@dachary.org>
Subject: Comparing straw2 and CARP
Date: Wed, 19 Apr 2017 12:21:13 +0200
Message-ID: <a4765385-bde7-0117-7baa-3fc80041c20b@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33698 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762155AbdDSKVR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Apr 2017 06:21:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I recently discovered CARP[1] which is implemented in Squid[2] and provides the same features as straw2:

- stable placement when a device is added or removed
- weighted devices
- given enough objects their distribution is uniform

The differences are:

- the hash function:
  - bit rotation based on the name of the item / object for CARP[3]
  - Robert J. Jenkins hash on the PG id for CRUSH[4] and no hashing for the item id

- the combination of the item hash and the object hash
  - XOR for CARP[5]
  - Robert J. Jenkins hash on the PG id hash and the item id for CRUSH[6]

- applying the weight to the the combination of the item hash and the object hash
  - the multiplier is calculated per device for CARP[7] and the combined hash is multiplied by it to get the score[8]
  - the weight is multiplied with the log of the combined hash for CRUSH[9]

I'd like to setup a simulation that shows the effect of these differences. I tried a few but the results are roughly the same wether I use CRUSH or CARP. Any idea ?

Cheers

[1] CARP https://tools.ietf.org/html/draft-vinod-carp-v1-03
[2] CARP in squid http://bazaar.launchpad.net/~squid/squid/trunk/view/head:/src/carp.cc#L198
[3] CARP hash http://bazaar.launchpad.net/~squid/squid/trunk/view/head:/src/carp.cc#L96
[4] CRUSH hash https://github.com/ceph/ceph/blob/master/src/osd/osd_types.cc#L1357
[5] CARP combination http://bazaar.launchpad.net/~squid/squid/trunk/view/head:/src/carp.cc#L200
[6] CRUSH combination https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L313
[7] CARP multiplier http://bazaar.launchpad.net/~squid/squid/trunk/view/head:/src/carp.cc#L133
[8] CARP score http://bazaar.launchpad.net/~squid/squid/trunk/view/head:/src/carp.cc#L203
[9] CRUSH score https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L335

-- 
Loïc Dachary, Artisan Logiciel Libre
