From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: mon config update
Date: Mon, 8 Jan 2018 10:02:21 +0100
Message-ID: <2b36d420-2646-4955-24ae-ed4a3688c094@corp.ovh.com>
References: <alpine.DEB.2.11.1801051716570.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 10.mo301.mail-out.ovh.net ([137.74.110.73]:45309 "EHLO
        10.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755969AbeAHJCU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 04:02:20 -0500
In-Reply-To: <alpine.DEB.2.11.1801051716570.24931@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 18-01-05 06:35 PM, Sage Weil wrote:
> My mon-based config branch is coming together.  The last bit I did was the
> CLI commands to set and show config.  It didn't come out quite like I
> expected it would.  Here's what there is:
> 
> config dump                                     Show all configuration option(s)
> config get <who> {<key>}                        Show configuration option(s) for an entity
> config rm <who> <name>                          Clear a configuration option for one or more
>                                                   entities
> config set <who> <name> <value>                 Cet a configuration option for one or more
>                                                   entities
> config show <who>                               Show running configuration
> 
> The show command is the oddball here: it reports what the *daemon* reports
> as the running config, which includes other inputs (conf file, overrides,
> etc.), while the 'get' and 'dump' are just what the mon stores.  I wonder
> if there is a better command than 'show'?  Maybe 'running' or 'active' or
> 'report' or something?

Shouldn't "config get <key>" work like a subset of "config show" (output a 
specified <key> from daemon's running config)? Or, have "config show" accept 
specific key. Both are fine for with me.

> A sample from my vstart cluster (vstart is only putting some of its
> options in the mon so far, so this shows both conf and mon as sources):
> 
> gnit:build (wip-config) 11:28 AM $ bin/ceph config dump
> WHO    MASK OPTION                                VALUE
> global      crush_chooseleaf_type                 0
> global      mon_pg_warn_min_per_osd               3
> global      osd_pool_default_min_size             1
> global      osd_pool_default_size                 1
> mds         mds_debug_auth_pins                   true
> mds         mds_debug_frag                        true
> mds         mds_debug_subtrees                    true
> mon         mon_allow_pool_deletes                true
> [..]
> gnit:build (wip-config) 11:33 AM $ bin/ceph config get osd.0
> WHO    MASK      OPTION                    VALUE
> global           crush_chooseleaf_type     0
> osd    class:ssd debug_bluestore           0/0
> osd    host:gnit debug_filestore           20/20
> global host:gnit debug_monc                15/15
> osd.0            debug_osd                 33/33
> global           mon_pg_warn_min_per_osd   3
> osd              osd_copyfrom_max_chunk    524288
> osd              osd_debug_misdirected_ops true
> osd              osd_debug_op_order        true
> global           osd_pool_default_min_size 1
> global           osd_pool_default_size     1
> osd              osd_scrub_load_threshold  2000
> 
> (osd.0 is an ssd)
> 
> Thoughts?

I assume that this will support json output.
Wouldn't mind having a "changeable in runtime" column in these outputs. I 
know it's semi-reliable, but it's still better than experimenting or 
searching for it in code (which may be difficult for non-devs).

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
