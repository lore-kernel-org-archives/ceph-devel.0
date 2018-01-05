From: Sage Weil <sweil@redhat.com>
Subject: mon config storage (config-key vs config)
Date: Fri, 5 Jan 2018 21:13:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbeAEVOA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 16:14:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E724F883AC
        for <ceph-devel@vger.kernel.org>; Fri,  5 Jan 2018 21:14:00 +0000 (UTC)
Received: from ovpn-112-43.rdu2.redhat.com (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EF2B6058D
        for <ceph-devel@vger.kernel.org>; Fri,  5 Jan 2018 21:14:00 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I forgot to bring this up in the other thread, so staring a new one.

Currently the configs are stored in the config-key table, which means you 
can also see the source values with 'ceph config-key dump':

{
    "config/crush_chooseleaf_type": "0",
    "config/mds/debug_mds": "20",
    "config/mds/debug_mgrc": "20",
    "config/mds/debug_monc": "20",
...
    "config/osd/osd_scrub_load_threshold": "2000",
    "config/osd_pool_default_min_size": "1",
    "config/osd_pool_default_size": "1",
    "mgr/dashboard/x/server_port": "41879",
    "mgr/restful/keys/admin": "c28a8d35-282a-4330-aa61-c57e3d7f0ae8",
...
}

This was handy during development before 'ceph config *' were implemented.  
How, I'm not so sure it's the best path.

The first issue is that it's not easy to detect changes directly to 
config-key from the ConfigMonitor code.  (This is an implementation 
artifact; ConfigKeyService is not a normal PaxosService for reasons lost 
of the mists of time.)

More generally, I'm not sure if it *should* be visible and modifiable in a 
separate, different way.  A simple option is to simply move the 
config/* keys into a separate namespace.

On the other hand, config-key so far is only lightly used, by two in-tree 
things:

 - mgr module configs, which look like mgr/$module[/$mgrid]/$option
 - ceph-disk (and soon ceph-volume) put dmcrypt keys in dm-crypt/osd/*

(It's also been around forever, so users might be sticking all kinds of 
other stuff in there, who knows.)

Should we try to unify the general-purpose config-key storage with the 
well-structured config options in config/*?  Or are they simply two 
different things?  It *is* kind of nice that 'ceph config-key dump' shows 
you both mgr module configs and the daemon configs.  

Is the 'config/' prefix for the native ceph config options the part that 
is out of place?  For example, we could have something like

 mgr/dashboard/server_port = 7000
 mgr/debug_mgr = 20
 mgr.x/ms_type = simple

that squishes the ceph configs into the same key space as the module 
options.

This brings up another longstanding issue: most of our config options have 
a daemon type prefix in the name, e.g. osd_objectstore, mds_cache_size, or 
(more confusingly) things like mon_osd_full_ratio and 
osd_crush_chooseleaf_type (both mon options that affect the mon's initial 
OSDMap creation only).  Is there a way we can realistically rename some of 
these options, perhaps as part of the ceph.conf -> mon config transition?  
Then we would end up with configs more like

 mon/crush_chooseleaf_type = foo
 mon/initial_osd_full_ratio = ...
 mds/cache_size = ...
 osd/objectstore = bluestore

and so on.

sage
