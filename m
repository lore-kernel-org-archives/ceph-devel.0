From: Sage Weil <sweil@redhat.com>
Subject: mon config update
Date: Fri, 5 Jan 2018 17:35:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801051716570.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752038AbeAERfD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 12:35:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 727D881DE2
        for <ceph-devel@vger.kernel.org>; Fri,  5 Jan 2018 17:35:03 +0000 (UTC)
Received: from ovpn-112-43.rdu2.redhat.com (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAB316A02D
        for <ceph-devel@vger.kernel.org>; Fri,  5 Jan 2018 17:35:02 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

My mon-based config branch is coming together.  The last bit I did was the 
CLI commands to set and show config.  It didn't come out quite like I 
expected it would.  Here's what there is:

config dump                                     Show all configuration option(s)
config get <who> {<key>}                        Show configuration option(s) for an entity
config rm <who> <name>                          Clear a configuration option for one or more 
                                                 entities
config set <who> <name> <value>                 Cet a configuration option for one or more 
                                                 entities
config show <who>                               Show running configuration

The show command is the oddball here: it reports what the *daemon* reports 
as the running config, which includes other inputs (conf file, overrides, 
etc.), while the 'get' and 'dump' are just what the mon stores.  I wonder 
if there is a better command than 'show'?  Maybe 'running' or 'active' or 
'report' or something?

A sample from my vstart cluster (vstart is only putting some of its 
options in the mon so far, so this shows both conf and mon as sources):

gnit:build (wip-config) 11:28 AM $ bin/ceph config dump
WHO    MASK OPTION                                VALUE                                                                   
global      crush_chooseleaf_type                 0                                                                       
global      mon_pg_warn_min_per_osd               3                                                                       
global      osd_pool_default_min_size             1                                                                       
global      osd_pool_default_size                 1                                                                       
mds         mds_debug_auth_pins                   true                                                                    
mds         mds_debug_frag                        true                                                                    
mds         mds_debug_subtrees                    true                                                                    
mon         mon_allow_pool_deletes                true                                                                    
mon         mon_data_avail_crit                   1                                                                       
mon         mon_data_avail_warn                   2                                                                       
mon         mon_osd_reporter_subtree_level        osd                                                                     
mon         osd_pool_default_erasure_code_profile plugin=jerasure technique=reed_sol_van k=2 m=1 crush-failure-domain=osd 
osd         osd_copyfrom_max_chunk                524288                                                                  
osd         osd_debug_misdirected_ops             true                                                                    
osd         osd_debug_op_order                    true                                                                    
osd         osd_scrub_load_threshold              2000                                                                    
gnit:build (wip-config) 11:28 AM $ bin/ceph config get osd.0
WHO    MASK OPTION                    VALUE  
global      crush_chooseleaf_type     0      
global      mon_pg_warn_min_per_osd   3      
osd         osd_copyfrom_max_chunk    524288 
osd         osd_debug_misdirected_ops true   
osd         osd_debug_op_order        true   
global      osd_pool_default_min_size 1      
global      osd_pool_default_size     1      
osd         osd_scrub_load_threshold  2000   
gnit:build (wip-config) 11:28 AM $ bin/ceph config set osd.0 debug_osd 33
gnit:build (wip-config) 11:28 AM $ bin/ceph config get osd.0 
WHO    MASK OPTION                    VALUE  
global      crush_chooseleaf_type     0      
osd.0       debug_osd                 33/33  
global      mon_pg_warn_min_per_osd   3      
osd         osd_copyfrom_max_chunk    524288 
osd         osd_debug_misdirected_ops true   
osd         osd_debug_op_order        true   
global      osd_pool_default_min_size 1      
global      osd_pool_default_size     1      
osd         osd_scrub_load_threshold  2000   
gnit:build (wip-config) 11:28 AM $ bin/ceph config get osd.0 debug_osd
WHO   MASK OPTION    VALUE 
osd.0      debug_osd 33/33 
gnit:build (wip-config) 11:29 AM $ bin/ceph config set host:gnit debug_monc 15
gnit:build (wip-config) 11:29 AM $ bin/ceph config get osd.0
WHO    MASK      OPTION                    VALUE  
global           crush_chooseleaf_type     0      
global host:gnit debug_monc                15/15  
osd.0            debug_osd                 33/33  
global           mon_pg_warn_min_per_osd   3      
osd              osd_copyfrom_max_chunk    524288 
osd              osd_debug_misdirected_ops true   
osd              osd_debug_op_order        true   
global           osd_pool_default_min_size 1      
global           osd_pool_default_size     1      
osd              osd_scrub_load_threshold  2000   
gnit:build (wip-config) 11:29 AM $ bin/ceph config show osd.0
NAME                                                       VALUE                                                SOURCE   OVERRIDES 
admin_socket                                               /tmp/ceph-asok.r90bKw/$name.asok                     file               
bluestore_block_create                                     1                                                    file               
bluestore_block_db_create                                  1                                                    file               
bluestore_block_db_path                                    /home/sage/src/ceph6/build/dev/osd$id/block.db.file  file               
bluestore_block_db_size                                    67108864                                             file               
bluestore_block_wal_create                                 1                                                    file               
bluestore_block_wal_path                                   /home/sage/src/ceph6/build/dev/osd$id/block.wal.file file               
bluestore_block_wal_size                                   1048576000                                           file               
bluestore_fsck_on_mount                                    1                                                    file               
chdir                                                                                                           file               
debug_bdev                                                 20/20                                                file               
debug_bluefs                                               20/20                                                file               
debug_bluestore                                            30/30                                                file               
debug_filestore                                            20/20                                                file               
debug_journal                                              20/20                                                file               
debug_mgrc                                                 20/20                                                file               
debug_monc                                                 20/20                                                file               
debug_ms                                                   1/1                                                  file               
debug_objclass                                             20/20                                                file               
debug_objecter                                             20/20                                                file               
debug_osd                                                  25/25                                                file     mon       
debug_reserver                                             10/10                                                file               
debug_rocksdb                                              10/10                                                file               
enable_experimental_unrecoverable_data_corrupting_features *                                                    file               
erasure_code_dir                                           /home/sage/src/ceph6/build/lib                       file               
filestore_fd_cache_size                                    32                                                   file               
filestore_wbthrottle_btrfs_inodes_hard_limit               30                                                   file               
filestore_wbthrottle_btrfs_ios_hard_limit                  20                                                   file               
filestore_wbthrottle_btrfs_ios_start_flusher               10                                                   file               
filestore_wbthrottle_xfs_inodes_hard_limit                 30                                                   file               
filestore_wbthrottle_xfs_ios_hard_limit                    20                                                   file               
filestore_wbthrottle_xfs_ios_start_flusher                 10                                                   file               
heartbeat_file                                             /home/sage/src/ceph6/build/out/$name.heartbeat       file               
keyring                                                    $osd_data/keyring                                    default            
leveldb_log                                                                                                     default            
lockdep                                                    1                                                    file               
log_file                                                   /home/sage/src/ceph6/build/out/$name.log             file               
mon_osd_backfillfull_ratio                                 0.99                                                 file               
mon_osd_full_ratio                                         0.99                                                 file               
mon_osd_nearfull_ratio                                     0.99                                                 file               
mon_pg_warn_min_per_osd                                    3                                                    mon                
osd_check_max_object_name_len_on_startup                   0                                                    file               
osd_class_default_list                                     *                                                    file               
osd_class_dir                                              /home/sage/src/ceph6/build/lib                       file               
osd_class_load_list                                        *                                                    file               
osd_copyfrom_max_chunk                                     524288                                               mon                
osd_data                                                   /home/sage/src/ceph6/build/dev/osd$id                file               
osd_debug_misdirected_ops                                  1                                                    mon                
osd_debug_op_order                                         1                                                    mon                
osd_failsafe_full_ratio                                    0.99                                                 file               
osd_journal                                                /home/sage/src/ceph6/build/dev/osd$id/journal        file               
osd_journal_size                                           100                                                  file               
osd_objectstore                                            bluestore                                            override file      
osd_pool_default_min_size                                  1                                                    mon                
osd_pool_default_size                                      1                                                    mon                
osd_scrub_load_threshold                                   2000                                                 mon                
pid_file                                                   /home/sage/src/ceph6/build/out/$name.pid             file               
plugin_dir                                                 /home/sage/src/ceph6/build/lib                       file               
run_dir                                                    /home/sage/src/ceph6/build/out                       file               
gnit:build (wip-config) 11:29 AM $ bin/ceph config set osd/host:gnit debug_filestore 20
gnit:build (wip-config) 11:32 AM $ bin/ceph config get osd.0
WHO    MASK      OPTION                    VALUE  
global           crush_chooseleaf_type     0      
osd    host:gnit debug_filestore           20/20  
global host:gnit debug_monc                15/15  
osd.0            debug_osd                 33/33  
global           mon_pg_warn_min_per_osd   3      
osd              osd_copyfrom_max_chunk    524288 
osd              osd_debug_misdirected_ops true   
osd              osd_debug_op_order        true   
global           osd_pool_default_min_size 1      
global           osd_pool_default_size     1      
osd              osd_scrub_load_threshold  2000   
gnit:build (wip-config) 11:32 AM $ bin/ceph config set osd/class:ssd debug_bluestore 0
gnit:build (wip-config) 11:33 AM $ bin/ceph config set osd/class:hdd debug_bluestore 20
gnit:build (wip-config) 11:33 AM $ bin/ceph config get osd.0
WHO    MASK      OPTION                    VALUE  
global           crush_chooseleaf_type     0      
osd    class:ssd debug_bluestore           0/0    
osd    host:gnit debug_filestore           20/20  
global host:gnit debug_monc                15/15  
osd.0            debug_osd                 33/33  
global           mon_pg_warn_min_per_osd   3      
osd              osd_copyfrom_max_chunk    524288 
osd              osd_debug_misdirected_ops true   
osd              osd_debug_op_order        true   
global           osd_pool_default_min_size 1      
global           osd_pool_default_size     1      
osd              osd_scrub_load_threshold  2000   

(osd.0 is an ssd)

Thoughts?
sage
