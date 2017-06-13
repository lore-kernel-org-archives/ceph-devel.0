From: Sage Weil <sweil@redhat.com>
Subject: cluster health checks
Date: Tue, 13 Jun 2017 19:34:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706131928320.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10237 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752168AbdFMTeC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Jun 2017 15:34:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD9DD145F94
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 19:34:01 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jspray@redhat.com
Cc: ceph-devel@vger.kernel.org

I've put together a rework of the cluster health checks at

	https://github.com/ceph/ceph/pull/15643

based on John's original proposal in

	http://tracker.ceph.com/issues/7192

(with a few changes).  I think it's pretty complete except that the 
MDSMonitor new-style checks aren't implemented yet.

This would be a semi-incompatible change with pre-luminous ceph in that

 - the structured (json/xml) health output is totally different
 - the plaintext health *detail* output is different
 - specific error messages are a bit different.  I was reimplementing them 
and took the liberty of revising what information was in the 
summary and detail in several cases.

Let me know what you think!

Thanks-
sage


$ ceph -s
  cluster:
    id:     9ee7f49c-57c3-4686-afd1-75b3a8f08c73
    health: HEALTH_WARN
            2 osds down
            1 host (2 osds) down
            1 root (2 osds) down
            8 pgs stale

  services:
    mon: 3 daemons, quorum a,b,c
    mgr: x(active)
    osd: 2 osds: 0 up, 2 in

  data:
    pools:   1 pools, 8 pgs
    objects: 0 objects, 0 bytes
    usage:   414 GB used, 330 GB / 744 GB avail
    pgs:     8 stale+active+clean

$ ceph health detail -f json-pretty
{
    "checks": {
        "OSD_DOWN": {
            "severity": "HEALTH_WARN",
            "message": "2 osds down"
        },
        "OSD_HOST_DOWN": {
            "severity": "HEALTH_WARN",
            "message": "1 host (2 osds) down"
        },
        "OSD_ROOT_DOWN": {
            "severity": "HEALTH_WARN",
            "message": "1 root (2 osds) down"
        },
        "PG_STALE": {
            "severity": "HEALTH_WARN",
            "message": "8 pgs stale"
        }
    },
    "status": "HEALTH_WARN",
    "detail": {
        "OSD_DOWN": [
            "osd.0 (root=default,host=gnit) is down",
            "osd.1 (root=default,host=gnit) is down"
        ],
        "OSD_HOST_DOWN": [
            "host gnit (root=default) (2 osds) is down"
        ],
        "OSD_ROOT_DOWN": [
            "root default (2 osds) is down"
        ],
        "PG_STALE": [
            "pg 0.7 is stale+active+clean, acting [1,0]",
            "pg 0.6 is stale+active+clean, acting [0,1]",
            "pg 0.5 is stale+active+clean, acting [0,1]",
            "pg 0.4 is stale+active+clean, acting [0,1]",
            "pg 0.0 is stale+active+clean, acting [0,1]",
            "pg 0.1 is stale+active+clean, acting [1,0]",
            "pg 0.2 is stale+active+clean, acting [0,1]",
            "pg 0.3 is stale+active+clean, acting [0,1]"
        ]
    }
}

$ ceph health detail
HEALTH_WARN 2 osds down; 1 host (2 osds) down; 1 root (2 osds) down; 8 pgs stale
OSD_DOWN 2 osds down
    osd.0 (root=default,host=gnit) is down
    osd.1 (root=default,host=gnit) is down
OSD_HOST_DOWN 1 host (2 osds) down
    host gnit (root=default) (2 osds) is down
OSD_ROOT_DOWN 1 root (2 osds) down
    root default (2 osds) is down
PG_STALE 8 pgs stale
    pg 0.7 is stale+active+clean, acting [1,0]
    pg 0.6 is stale+active+clean, acting [0,1]
    pg 0.5 is stale+active+clean, acting [0,1]
    pg 0.4 is stale+active+clean, acting [0,1]
    pg 0.0 is stale+active+clean, acting [0,1]
    pg 0.1 is stale+active+clean, acting [1,0]
    pg 0.2 is stale+active+clean, acting [0,1]
    pg 0.3 is stale+active+clean, acting [0,1]

