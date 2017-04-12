From: Loic Dachary <loic@dachary.org>
Subject: Minimal crush weight_set integration
Date: Wed, 12 Apr 2017 18:42:29 +0200
Message-ID: <fcb0529a-ff48-1e50-5f8a-ad40f73d12c8@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54071 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755180AbdDLQmd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Apr 2017 12:42:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

Assuming the weight set is implemented in crush[1], it could be used with a weight_set matrix for each pool, encoded/decoded with the crushmap[2]. If the weight_set for a given pool does not exist the legacy behavior is preserved. Whenever a pool size, pgp_num changes, the weight_set should also be updated simultaneously.

Currently CrushWrapper re-creates the workspace for each call to crush_do_rule which is expensive. It could instead be cached. The workspace is created with the replication count as an argument and could then be populated with the weight_set for the corresponding pool which is assumed to be in sync with the pool state (size, pgp_num etc).

This would be a very loose implementation of the weight_set relying on external tools to be in sync. The next step would be to add commands on top of that to make it less error prone.

Do you think we should come up with a robust use case / cli / syntax before implementing this first step ? Or does it look like a sound first step ?

Cheers

[1] http://libcrush.org/main/libcrush/merge_requests/30/diffs
[2] https://github.com/ceph/ceph/pull/14486
[3] https://github.com/ceph/ceph/pull/14486/files#diff-215e8db28af558a5e445f6267530c786R1179

-- 
Loïc Dachary, Artisan Logiciel Libre
