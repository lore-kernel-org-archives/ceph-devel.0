From: Sage Weil <sage@redhat.com>
Subject: mon config commands
Date: Thu, 11 Jan 2018 21:21:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801112044230.23413@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbeAKVV4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 11 Jan 2018 16:21:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D3B78B114
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jan 2018 21:21:56 +0000 (UTC)
Received: from piezo.us.to (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1E63F909B
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jan 2018 21:21:55 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

Here's the current state of the mon config commands for mimic.  These are 
pretty close to being "done" so please review carefully!

config assimilate-conf                  Assimilate options from a conf, and 
                                         return a new, minimal conf file
config dump                             Show all configuration option(s)
config get <who> {<key>}                Show configuration option(s) for an 
                                         entity
config help <key>                       Describe a configuration option
config rm <who> <name>                  Clear a configuration option for one or 
                                         more entities
config set <who> <name> <value>         Cet a configuration option for one or 
                                         more entities
config show <who> {<key>}               Show running configuration
config show-with-defaults <who>         Show running configuration (including 
                                         compiled-in defaults)
---

First, let's dump everything:

$ bin/ceph config dump
WHO    MASK LEVEL     OPTION                         VALUE  RO 
global      advanced  mon_pg_warn_min_per_osd        3         
global      advanced  osd_crush_chooseleaf_type      0         
global      advanced  osd_pool_default_min_size      1         
global      advanced  osd_pool_default_size          1         
mds         advanced  debug_mds                      20/20     
mds         advanced  debug_mgrc                     20/20     
mds         advanced  debug_monc                     20/20     
mds         advanced  debug_ms                       1/1       
mds         developer mds_debug_auth_pins            true      
mds         developer mds_debug_frag                 true      
mds         developer mds_debug_scatterstat          true      
mds         developer mds_debug_subtrees             true      
mds         developer mds_verify_scatter             true      
mgr         advanced  debug_mgr                      20/20     
mgr         advanced  debug_mon                      20/20     
mgr         advanced  debug_monc                     20/20     
mgr         advanced  debug_ms                       1/1       
mon         unknown   mon_allow_pool_deletes         true   *  
mon         advanced  mon_data_avail_crit            1         
mon         advanced  mon_data_avail_warn            2         
...

Note the one RO item here is also 'unknown'.. that's because it's not a 
valid config option (there's no 's').. it was injected directly into 
config-key.

For a single daemon,

gnit:build (wip-config) 02:47 PM $ bin/ceph config get mon.a
WHO    MASK LEVEL    OPTION                         VALUE RO 
mon         unknown  mon_allow_pool_deletes         true  *  
mon         advanced mon_data_avail_crit            1        
mon         advanced mon_data_avail_warn            2        
mon         advanced mon_osd_reporter_subtree_level osd      
global      advanced mon_pg_warn_min_per_osd        3        
global      advanced osd_crush_chooseleaf_type      0        
global      advanced osd_pool_default_min_size      1        
global      advanced osd_pool_default_size          1        

If I try to set something that can't be changed at runtime (say, ms_type), 
you get:

gnit:build (wip-config) 02:47 PM $ bin/ceph config set mon.a ms_type 
simple
gnit:build (wip-config) 02:48 PM $ bin/ceph config get mon.a
WHO    MASK LEVEL    OPTION                         VALUE  RO 
mon         unknown  mon_allow_pool_deletes         true   *  
mon         advanced mon_data_avail_crit            1         
mon         advanced mon_data_avail_warn            2         
mon         advanced mon_osd_reporter_subtree_level osd       
global      advanced mon_pg_warn_min_per_osd        3         
mon.a       advanced ms_type                        simple *  
global      advanced osd_crush_chooseleaf_type      0         
global      advanced osd_pool_default_min_size      1         
global      advanced osd_pool_default_size          1         

You can then see this by checking the *running* config (this is what the 
daemon has reported as it's actually config to the manager):

gnit:build (wip-config) 02:48 PM $ bin/ceph config show mon.a
NAME                                                       VALUE                                              SOURCE  OVERRIDES IGNORES 
admin_socket                                               /tmp/ceph-asok.GBZTV0/$name.asok                   file                      
chdir                                                                                                         file                      
debug_auth                                                 20/20                                              file                      
debug_mgrc                                                 20/20                                              file                      
debug_mon                                                  20/20                                              file                      
debug_ms                                                   1/1                                                file                      
debug_paxos                                                20/20                                              file                      
enable_experimental_unrecoverable_data_corrupting_features *                                                  file                      
erasure_code_dir                                           /home/sage/src/ceph6/build/lib                     file                      
filestore_fd_cache_size                                    32                                                 file                      
heartbeat_file                                             /home/sage/src/ceph6/build/out/$name.heartbeat     file                      
leveldb_block_size                                         65536                                              default                   
leveldb_cache_size                                         536870912                                          default                   
leveldb_compression                                        0                                                  default                   
leveldb_log                                                                                                   default                   
leveldb_write_buffer_size                                  33554432                                           default                   
lockdep                                                    1                                                  file                      
log_file                                                   /home/sage/src/ceph6/build/out/$name.log           file                      
mgr_initial_modules                                        restful status dashboard balancer                  file                      
mon_cluster_log_file                                       /home/sage/src/ceph6/build/out/cluster.mon.$id.log file                      
mon_data                                                   /home/sage/src/ceph6/build/dev/mon.a               file                      
mon_data_avail_crit                                        1                                                  mon                       
mon_data_avail_warn                                        2                                                  mon                       
mon_osd_backfillfull_ratio                                 0.99                                               file                      
mon_osd_full_ratio                                         0.99                                               file                      
mon_osd_nearfull_ratio                                     0.99                                               file                      
mon_osd_reporter_subtree_level                             osd                                                mon                       
mon_pg_warn_min_per_osd                                    3                                                  mon                       
ms_type                                                    async+posix                                        default           mon     
osd_crush_chooseleaf_type                                  0                                                  mon                       
osd_failsafe_full_ratio                                    0.99                                               file                      
osd_pool_default_min_size                                  1                                                  mon                       
osd_pool_default_size                                      1                                                  mon                       
pid_file                                                   /home/sage/src/ceph6/build/out/mon.a.pid           cmdline file              
plugin_dir                                                 /home/sage/src/ceph6/build/lib                     file                      
run_dir                                                    /home/sage/src/ceph6/build/out                     file                      

(sorry for the wide table)

A few things to note: SOURCE can be any of default, file, mon, env, 
cmdline, or override.  You'll notice that ms_type SOURCE is 'default' and 
IGNORES is 'mon', because the daemon is ignoring the mon value--this 
option can only be set during startup.

Similarly, if I try to override something else manually,

gnit:build (wip-config) 02:50 PM $ bin/ceph daemon mon.a config set mon_data_avail_warn 3
{
    "success": ""
}
gnit:build (wip-config) 02:50 PM $ bin/ceph config show mon.a
NAME                                                       VALUE                                              SOURCE   OVERRIDES IGNORES 
...
mon_data_avail_warn                                        3                                                  override mon               
...

we see that the currently value is an override, and OVERRIDES the mon 
value.  As far as I can tel this is a pretty complete view of what is 
going on.  The JSON form has a bit more info, like what the mon value that 
was override was:

...
    {
        "name": "mon_data_avail_warn",
        "value": "3",
        "source": "override",
        "overrides": [
            {
                "source": "mon",
                "value": "2"
            }
        ]
    },
...

Anyway, moving on...

You can also 'get' and 'show' specific values, making this useful from a 
script:

gnit:build (wip-config) 02:52 PM $ bin/ceph config get mon.a ms_type
simple
gnit:build (wip-config) 02:52 PM $ bin/ceph config show mon.a ms_type
async+posix

This will return valid results for defaults, too:

gnit:build (wip-config) 02:52 PM $ bin/ceph config show mon.a osd_data
/var/lib/ceph/osd/$cluster-$id

...although the result has not has substitutions processed yet (should 
it?).

You can get help:

gnit:build (wip-config) 02:54 PM $ bin/ceph config help 
bluestore_cache_size
bluestore_cache_size - Cache size (in bytes) for BlueStore
  (uint64_t, advanced)
  Default: 0
  Can update at runtime: true

This includes data and metadata cached by BlueStore as well as memory devoted to rocksdb's cache(s).

I mostly hate how the above looks, BTW--suggestions welcome!  In JSON 
form,

gnit:build (wip-config) 02:54 PM $ bin/ceph config help bluestore_cache_size -f json-pretty

{
    "name": "bluestore_cache_size",
    "type": "uint64_t",
    "level": "advanced",
    "desc": "Cache size (in bytes) for BlueStore",
    "long_desc": "This includes data and metadata cached by BlueStore as 
well as memory devoted to rocksdb's cache(s).",
    "default": 0,
    "daemon_default": "",
    "tags": [],
    "services": [],
    "see_also": [],
    "min": "",
    "max": "",
    "can_update_at_runtime": true
}

The 'config set' has basic validation:

gnit:build (wip-config) 03:07 PM $ bin/ceph config set osd.0 foo bar
Error EINVAL: unrecognized config option 'foo'
gnit:build (wip-config) 03:07 PM $ bin/ceph config set osd.0 osd_tier_default_cache_mode bar
Error EINVAL: error parsing value: 'bar' is not one of the permitted values: none, writeback, forward, readonly, readforward, readproxy, proxy
gnit:build (wip-config) 03:08 PM $ bin/ceph config set osd.0 
osd_tier_default_cache_mode writeback

and you can clear an option:

gnit:build (wip-config) 03:08 PM $ bin/ceph config get mon.a
WHO    MASK LEVEL    OPTION                         VALUE  RO 
mon         unknown  mon_allow_pool_deletes         true   *  
mon         advanced mon_data_avail_crit            1         
mon         advanced mon_data_avail_warn            2         
mon         advanced mon_osd_reporter_subtree_level osd       
global      advanced mon_pg_warn_min_per_osd        3         
mon.a       advanced ms_type                        simple *  
global      advanced osd_crush_chooseleaf_type      0         
global      advanced osd_pool_default_min_size      1         
global      advanced osd_pool_default_size          1         
gnit:build (wip-config) 03:08 PM $ bin/ceph config rm mon.a ms_type
gnit:build (wip-config) 03:09 PM $ bin/ceph config get mon.a
WHO    MASK LEVEL    OPTION                         VALUE RO 
mon         unknown  mon_allow_pool_deletes         true  *  
mon         advanced mon_data_avail_crit            1        
mon         advanced mon_data_avail_warn            2        
mon         advanced mon_osd_reporter_subtree_level osd      
global      advanced mon_pg_warn_min_per_osd        3        
global      advanced osd_crush_chooseleaf_type      0        
global      advanced osd_pool_default_min_size      1        
global      advanced osd_pool_default_size          1        


The last one is 'assimilate-conf' and is meant to help transition from 
a ceph.conf world to a mon config world.  This is a vstart cluster, so all 
of the paths are all wonky and there's lots of specialness that you 
wouldn't see in the real world.  It still imports most stuff:

gnit:build (wip-config) 03:09 PM $ wc -l ceph.conf
115 ceph.conf
gnit:build (wip-config) 03:09 PM $ bin/ceph config assimilate-conf -i ceph.conf -o new.conf
2018-01-11 15:09:55.390 7f5a3cff9700 -1 set_mon_vals failed to set admin_socket = /tmp/ceph-asok.GBZTV0/$name.$pid.asok: Configuration option 'admin_socket' may not be modified at runtime

(That warning appears because the CLI process observed the config change 
as it happened, and isn't able to update the admin_socket setting at 
runtime.)

What's left is stuff flagged NO_MON_CONFIG or unrecognized as a valid 
option:

gnit:build (wip-config) 03:09 PM $ wc -l new.conf
46 new.conf
gnit:build (wip-config) 03:10 PM $ cat new.conf

[client]
        keyring = /home/sage/src/ceph6/build/keyring

[client.vstart.sh]
        num_mds = 0
        num_mgr = 1
        num_mon = 1
        num_osd = 1
        num_rgw = 0

[global]
        fsid = 9dbd93f7-635a-4734-bc29-448a2305af7f
        lockdep = true
        mon_osd_backfillfull_ratio = .99
        mon_osd_full_ratio = .99
        mon_osd_nearfull_ratio = .99

[mds]
        chdir = 
        mds_data = /home/sage/src/ceph6/build/dev/mds.$id

[mgr]
        chdir = 
        mgr_data = /home/sage/src/ceph6/build/dev/mgr.$id

[mgr.x]
        host = gnit

[mon]
        chdir = 
        mgr_initial_modules = restful status dashboard balancer

[mon.a]
        host = gnit
        mon_addr = 127.0.0.1:40948
        mon_data = /home/sage/src/ceph6/build/dev/mon.a

[osd]
        chdir = 
        osd_class_tmp = out
        osd_data = /home/sage/src/ceph6/build/dev/osd$id
        osd_journal = /home/sage/src/ceph6/build/dev/osd$id/journal

[osd.0]
        host = gnit

This command isn't as smart as it maybe could be.  It doesn't try to do 
anything clever for ceph.conf's with conflicting values from different 
hosts... so if host A has debug_ms=1 and host B has debug_ms=2, the mon 
will keep whichever was imported last.  In general, though, if the config 
options are restricted to [type.id] per-daemon sections then things will 
work just fine.

We *could* have tools try to look at the result in the mon and simplify or 
rearrange, by (for example) moving osd-specific options under [osd] so 
that they don't pollute other daemons' configs.  I leave this to future 
work...

Anyway, please let me know if there is anything ugly or unintuitive or 
wrong here.  If this looks sane I'll finally write up the docs!

sage
