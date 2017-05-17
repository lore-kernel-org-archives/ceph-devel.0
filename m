From: Tim Serong <tserong@suse.com>
Subject: ceph-mgr REST API
Date: Wed, 17 May 2017 16:29:04 +1000
Message-ID: <6c4ce752-4594-aa31-9d0e-35985e379c5a@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:51697 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdEQG3O (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 17 May 2017 02:29:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, openattic-users@googlegroups.com, tendrl-devel@redhat.com

Hi All,

There's a PR that's been open for a while to add a new pecan-based REST
API to ceph-mgr:

  https://github.com/ceph/ceph/pull/14457

This is intended to be consumed internally by management tools such as
openATTIC[1] and Tendrl[2] (and anything else that wants to manage a
Ceph cluster via a REST API).

There's been quite some discussion on the PR, and we also spoke about it
at the May CDM, but I don't think much mention has occurred on the
various mailing lists, so I'm writing this to raise awareness and
solicit feedback.

There's a desire to get this PR merged for the Luminous release, but
possibly marked "experimental", so that at least we have something out
there that people can start using.

I had volunteered to document the delta between this ceph-mgr REST API
and the Ceph REST API currently present in openATTIC, to attempt to
gauge the effort involved in making openATTIC use the ceph-mgr REST API,
but Sebastian Wagner has beaten me to it with some good details[3]
(thanks!), so I'll just try to summarise here for the record:

- Both APIs provide:
  - For OSDs: list, get details, modify (reweight, up/in state)
  - For Pools: list, get details, modify, delete
  - A means of handling long running requests (although AIUI these
    work somewhat differently)

- The openATTIC API provides in addition:
  - For PGs: list (can be filtered by pool, osd), get details
  - For RBD volumes: list, create, delete, modify
  - For CephFS: list
  - For EC Profiles: list, create, delete
  - Pagination of lists (important for non-small clusters)

- The ceph-mgr REST API provides in addition:
  - For cluster config options: list, get value
  - For CRUSH rules: list
  - For MONs: list, get details
  - For OSDs: run commands (scrub, deep_scrub, repair)
  - For Servers: list, get details

There are also some differences in naming and which fields are
exposed[4], but hopefully this is enough to give a general idea.  My
apologies to Boris Ranto (ceph-mgr REST API) and the openATTIC folks if
I've gotten anything wrong here.

Regards,

Tim

[1] https://www.openattic.org/
[2] http://tendrl.org/
[3] https://github.com/ceph/ceph/pull/14457#issuecomment-301954323
[4] For example, compare:

GET /openattic/api/ceph/80b30fd5-e0b2-363e-9ddd-63e87bac02c6/osds/0

{
    "id": 0,
    "crush_weight": 0.018494,
    "exists": 1,
    "name": "osd.0",
    "primary_affinity": 1.0,
    "reweight": 1.0,
    "status": "up",
    "type": "osd",
    "hostname": "ses4-5",
    "in_state": 1,
    "kb": 19911660,
    "kb_used": 35792,
    "kb_avail": 19875868
}

GET https://localhost:8002/osd/0

{
    "cluster_addr": "192.168.12.150:6801/1861",
    "down_at": 29,
    "heartbeat_back_addr": "192.168.12.150:6802/1861",
    "heartbeat_front_addr": "192.168.12.150:6803/1861",
    "in": 1,
    "last_clean_begin": 6,
    "last_clean_end": 26,
    "lost_at": 0,
    "osd": 0,
    "pools": [
        0
    ],
    "primary_affinity": 1.0,
    "public_addr": "192.168.12.150:6800/1861",
    "reweight": 1.0,
    "server": "ses4-5",
    "state": [
        "exists",
        "up"
    ],
    "up": 1,
    "up_from": 30,
    "up_thru": 42,
    "uuid": "fd129a52-0448-4e04-b41d-680e796f2731",
    "valid_commands": [
        "scrub",
        "deep_scrub",
        "repair"
    ],
    "weight": 1.0
}


-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
