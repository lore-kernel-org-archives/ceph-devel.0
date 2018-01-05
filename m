From: Sage Weil <sweil@redhat.com>
Subject: Re: mon config update
Date: Fri, 5 Jan 2018 18:24:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801051815380.24931@piezo.novalocal>
References: <alpine.DEB.2.11.1801051716570.24931@piezo.novalocal> <CAJ4mKGbbp8x+vru-eFgpVCuXZarqwwRtWVb3sBtU=Jgx5Z9Uuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-746976893-1515176642=:24931"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752450AbeAESYD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 13:24:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E385876545
        for <ceph-devel@vger.kernel.org>; Fri,  5 Jan 2018 18:24:02 +0000 (UTC)
In-Reply-To: <CAJ4mKGbbp8x+vru-eFgpVCuXZarqwwRtWVb3sBtU=Jgx5Z9Uuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-746976893-1515176642=:24931
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 5 Jan 2018, Gregory Farnum wrote:
> On Fri, Jan 5, 2018 at 9:35 AM, Sage Weil <sweil@redhat.com> wrote:
> > My mon-based config branch is coming together.  The last bit I did was the
> > CLI commands to set and show config.  It didn't come out quite like I
> > expected it would.  Here's what there is:
> >
> > config dump                                     Show all configuration option(s)
> > config get <who> {<key>}                        Show configuration option(s) for an entity
> > config rm <who> <name>                          Clear a configuration option for one or more
> >                                                  entities
> > config set <who> <name> <value>                 Cet a configuration option for one or more
> >                                                  entities
> > config show <who>                               Show running configuration
> >
> > The show command is the oddball here: it reports what the *daemon* reports
> > as the running config, which includes other inputs (conf file, overrides,
> > etc.), while the 'get' and 'dump' are just what the mon stores.  I wonder
> > if there is a better command than 'show'?  Maybe 'running' or 'active' or
> > 'report' or something?
> 
> I don't have a good suggestion for this name, but I was a little
> puzzled until I realized it seems to only show the options which are
> non-default? Given that defaults can change across software versions,
> I'm not sure that's a feasible long-term strategy. (In addition to
> dealing with whether we're comparing against the defaults on the OSD
> version or the monitor version, if I get a dump of options from
> somebody to do debugging with I'm not going to remember that a timeout
> changed between point releases and they're operating differently!)
> 
> Although I definitely get the desire to make the config legible when
> dumped, I'm not sure there's much utility there as a default anyway —
> won't admins mostly be querying for a specific value or else running
> diffs between different dumps? Perhaps we can deal with the bad naming
> by having "ceph config show non-default <who>", "ceph config show
> current <who>", and whatever else we like.

Yeah, defaults are excluded because there are 1000+ options and the output 
becomes unusable.  I'd prefer to make the less-standard command the one 
that dumps everything (including defaults), like show-all, or similar.  
Note though that currently the daemons aren't reporting their default 
values to the mgr at all--this keeps the MMgrReport message smaller.

> (Maybe options for showing configs under USER, ADVANCED, and DEV?)

Oh yeah, I forgot about these!  I guess I should add columns for these for 
both 'dump' and 'get'?

Also, I guess the other main missing piece is 'ceph config help <option>', 
which should present a friendly summary of the option, its description, 
defaults, and so on?

> Looking at the output, the WHO versus MASK bit is a little thorny. Can
> you show what it looks like when there are multiple masks on the same
> option?

gnit:build (wip-config) 12:15 PM $ bin/ceph config set osd/class:ssd/host:gnit debug_bluestore 20
gnit:build (wip-config) 12:15 PM $ bin/ceph config get osd.0 debug_bluestore
WHO MASK                OPTION          VALUE 
osd host:gnit/class:ssd debug_bluestore 20/20 
gnit:build (wip-config) 12:15 PM $ bin/ceph config set osd.0/class:ssd/host:gnit debug_bluestore 21
gnit:build (wip-config) 12:15 PM $ bin/ceph config get osd.0 debug_bluestore
WHO   MASK                OPTION          VALUE 
osd.0 host:gnit/class:ssd debug_bluestore 21/21 

> It looks like things are dumped in config declaration order, right?
> Given that, maybe OPTION should be the "top" (leftmost) column and
> then WHO and MASK can be filed underneath it, with nicely indented
> output to make it more like a tree.
> Or else make it more like a tree in the other direction, with either
> WHO or MASK as the root and with output order controlled that way. But
> that probably involved a lot more repetition of the output.

They're sorted by section (global, type, daemon), then by option name.  
Indenting is a great idea... I'd probably indent just the 'who' portion, 
like so?  Is that what you mean?

WHO            MASK                OPTION                                       VALUE                                                                                                         
global                             crush_chooseleaf_type                        0                                                                                                             
global                             mon_pg_warn_min_per_osd                      3                                                                                                             
global                             osd_pool_default_min_size                    1                                                                                                             
global                             osd_pool_default_size                        1                                                                                                             
  client                           admin_socket                                 /tmp/ceph-asok.A5CIZs/$name.$pid.asok                                                                         
  client                           log_file                                     /home/sage/src/ceph6/build/out/$name.$pid.log                                                                 
    client.rgw                     rgw_crypt_require_ssl                        false                                                                                                         
    client.rgw                     rgw_crypt_s3_kms_encryption_keys             testkey-1=YmluCmJvb3N0CmJvb3N0LWJ1aWxkCmNlcGguY29uZgo= testkey-2=aWIKTWFrZWZpbGUKbWFuCm91dApzcmMKVGVzdGluZwo= 
    client.rgw                     rgw_frontends                                civetweb port=8000                                                                                            
    client.rgw                     rgw_lc_debug_interval                        10                                                                                                            
  mds                              debug_mds                                    20/20                                                                                                         
  mds                              debug_mgrc                                   20/20                                                                                                         
  osd                              bluestore_block_create                       true                                                                                                          
  osd                              bluestore_block_db_create                    true                                                                                                          
  osd                              debug_bluestore                              30/30                                                                                                         
  osd          host:gnit/class:hdd debug_bluestore                              20/20                                                                                                         
  osd          host:gnit/class:ssd debug_bluestore                              20/20                                                                                                         
    osd.0      host:gnit/class:ssd debug_bluestore                              21/21                                                                                                         

I'm not sure sorting by the option name would work well here since you'd 
have, say, all of the debug_* options grouped together but applying to 
different things.  The idea was to easily see what the osd configs are, 
similar to what you get when looking at the old ini file.  And then also 
see any specializations per daemon below it.

sage


> -Greg
> 
> >
> > A sample from my vstart cluster (vstart is only putting some of its
> > options in the mon so far, so this shows both conf and mon as sources):
> >
> > gnit:build (wip-config) 11:28 AM $ bin/ceph config dump
> > WHO    MASK OPTION                                VALUE
> > global      crush_chooseleaf_type                 0
> > global      mon_pg_warn_min_per_osd               3
> > global      osd_pool_default_min_size             1
> > global      osd_pool_default_size                 1
> > mds         mds_debug_auth_pins                   true
> > mds         mds_debug_frag                        true
> > mds         mds_debug_subtrees                    true
> > mon         mon_allow_pool_deletes                true
> > mon         mon_data_avail_crit                   1
> > mon         mon_data_avail_warn                   2
> > mon         mon_osd_reporter_subtree_level        osd
> > mon         osd_pool_default_erasure_code_profile plugin=jerasure technique=reed_sol_van k=2 m=1 crush-failure-domain=osd
> > osd         osd_copyfrom_max_chunk                524288
> > osd         osd_debug_misdirected_ops             true
> > osd         osd_debug_op_order                    true
> > osd         osd_scrub_load_threshold              2000
> > gnit:build (wip-config) 11:28 AM $ bin/ceph config get osd.0
> > WHO    MASK OPTION                    VALUE
> > global      crush_chooseleaf_type     0
> > global      mon_pg_warn_min_per_osd   3
> > osd         osd_copyfrom_max_chunk    524288
> > osd         osd_debug_misdirected_ops true
> > osd         osd_debug_op_order        true
> > global      osd_pool_default_min_size 1
> > global      osd_pool_default_size     1
> > osd         osd_scrub_load_threshold  2000
> > gnit:build (wip-config) 11:28 AM $ bin/ceph config set osd.0 debug_osd 33
> > gnit:build (wip-config) 11:28 AM $ bin/ceph config get osd.0
> > WHO    MASK OPTION                    VALUE
> > global      crush_chooseleaf_type     0
> > osd.0       debug_osd                 33/33
> > global      mon_pg_warn_min_per_osd   3
> > osd         osd_copyfrom_max_chunk    524288
> > osd         osd_debug_misdirected_ops true
> > osd         osd_debug_op_order        true
> > global      osd_pool_default_min_size 1
> > global      osd_pool_default_size     1
> > osd         osd_scrub_load_threshold  2000
> > gnit:build (wip-config) 11:28 AM $ bin/ceph config get osd.0 debug_osd
> > WHO   MASK OPTION    VALUE
> > osd.0      debug_osd 33/33
> > gnit:build (wip-config) 11:29 AM $ bin/ceph config set host:gnit debug_monc 15
> > gnit:build (wip-config) 11:29 AM $ bin/ceph config get osd.0
> > WHO    MASK      OPTION                    VALUE
> > global           crush_chooseleaf_type     0
> > global host:gnit debug_monc                15/15
> > osd.0            debug_osd                 33/33
> > global           mon_pg_warn_min_per_osd   3
> > osd              osd_copyfrom_max_chunk    524288
> > osd              osd_debug_misdirected_ops true
> > osd              osd_debug_op_order        true
> > global           osd_pool_default_min_size 1
> > global           osd_pool_default_size     1
> > osd              osd_scrub_load_threshold  2000
> > gnit:build (wip-config) 11:29 AM $ bin/ceph config show osd.0
> > NAME                                                       VALUE                                                SOURCE   OVERRIDES
> > admin_socket                                               /tmp/ceph-asok.r90bKw/$name.asok                     file
> > bluestore_block_create                                     1                                                    file
> > bluestore_block_db_create                                  1                                                    file
> > bluestore_block_db_path                                    /home/sage/src/ceph6/build/dev/osd$id/block.db.file  file
> > bluestore_block_db_size                                    67108864                                             file
> > bluestore_block_wal_create                                 1                                                    file
> > bluestore_block_wal_path                                   /home/sage/src/ceph6/build/dev/osd$id/block.wal.file file
> > bluestore_block_wal_size                                   1048576000                                           file
> > bluestore_fsck_on_mount                                    1                                                    file
> > chdir                                                                                                           file
> > debug_bdev                                                 20/20                                                file
> > debug_bluefs                                               20/20                                                file
> > debug_bluestore                                            30/30                                                file
> > debug_filestore                                            20/20                                                file
> > debug_journal                                              20/20                                                file
> > debug_mgrc                                                 20/20                                                file
> > debug_monc                                                 20/20                                                file
> > debug_ms                                                   1/1                                                  file
> > debug_objclass                                             20/20                                                file
> > debug_objecter                                             20/20                                                file
> > debug_osd                                                  25/25                                                file     mon
> > debug_reserver                                             10/10                                                file
> > debug_rocksdb                                              10/10                                                file
> > enable_experimental_unrecoverable_data_corrupting_features *                                                    file
> > erasure_code_dir                                           /home/sage/src/ceph6/build/lib                       file
> > filestore_fd_cache_size                                    32                                                   file
> > filestore_wbthrottle_btrfs_inodes_hard_limit               30                                                   file
> > filestore_wbthrottle_btrfs_ios_hard_limit                  20                                                   file
> > filestore_wbthrottle_btrfs_ios_start_flusher               10                                                   file
> > filestore_wbthrottle_xfs_inodes_hard_limit                 30                                                   file
> > filestore_wbthrottle_xfs_ios_hard_limit                    20                                                   file
> > filestore_wbthrottle_xfs_ios_start_flusher                 10                                                   file
> > heartbeat_file                                             /home/sage/src/ceph6/build/out/$name.heartbeat       file
> > keyring                                                    $osd_data/keyring                                    default
> > leveldb_log                                                                                                     default
> > lockdep                                                    1                                                    file
> > log_file                                                   /home/sage/src/ceph6/build/out/$name.log             file
> > mon_osd_backfillfull_ratio                                 0.99                                                 file
> > mon_osd_full_ratio                                         0.99                                                 file
> > mon_osd_nearfull_ratio                                     0.99                                                 file
> > mon_pg_warn_min_per_osd                                    3                                                    mon
> > osd_check_max_object_name_len_on_startup                   0                                                    file
> > osd_class_default_list                                     *                                                    file
> > osd_class_dir                                              /home/sage/src/ceph6/build/lib                       file
> > osd_class_load_list                                        *                                                    file
> > osd_copyfrom_max_chunk                                     524288                                               mon
> > osd_data                                                   /home/sage/src/ceph6/build/dev/osd$id                file
> > osd_debug_misdirected_ops                                  1                                                    mon
> > osd_debug_op_order                                         1                                                    mon
> > osd_failsafe_full_ratio                                    0.99                                                 file
> > osd_journal                                                /home/sage/src/ceph6/build/dev/osd$id/journal        file
> > osd_journal_size                                           100                                                  file
> > osd_objectstore                                            bluestore                                            override file
> > osd_pool_default_min_size                                  1                                                    mon
> > osd_pool_default_size                                      1                                                    mon
> > osd_scrub_load_threshold                                   2000                                                 mon
> > pid_file                                                   /home/sage/src/ceph6/build/out/$name.pid             file
> > plugin_dir                                                 /home/sage/src/ceph6/build/lib                       file
> > run_dir                                                    /home/sage/src/ceph6/build/out                       file
> > gnit:build (wip-config) 11:29 AM $ bin/ceph config set osd/host:gnit debug_filestore 20
> > gnit:build (wip-config) 11:32 AM $ bin/ceph config get osd.0
> > WHO    MASK      OPTION                    VALUE
> > global           crush_chooseleaf_type     0
> > osd    host:gnit debug_filestore           20/20
> > global host:gnit debug_monc                15/15
> > osd.0            debug_osd                 33/33
> > global           mon_pg_warn_min_per_osd   3
> > osd              osd_copyfrom_max_chunk    524288
> > osd              osd_debug_misdirected_ops true
> > osd              osd_debug_op_order        true
> > global           osd_pool_default_min_size 1
> > global           osd_pool_default_size     1
> > osd              osd_scrub_load_threshold  2000
> > gnit:build (wip-config) 11:32 AM $ bin/ceph config set osd/class:ssd debug_bluestore 0
> > gnit:build (wip-config) 11:33 AM $ bin/ceph config set osd/class:hdd debug_bluestore 20
> > gnit:build (wip-config) 11:33 AM $ bin/ceph config get osd.0
> > WHO    MASK      OPTION                    VALUE
> > global           crush_chooseleaf_type     0
> > osd    class:ssd debug_bluestore           0/0
> > osd    host:gnit debug_filestore           20/20
> > global host:gnit debug_monc                15/15
> > osd.0            debug_osd                 33/33
> > global           mon_pg_warn_min_per_osd   3
> > osd              osd_copyfrom_max_chunk    524288
> > osd              osd_debug_misdirected_ops true
> > osd              osd_debug_op_order        true
> > global           osd_pool_default_min_size 1
> > global           osd_pool_default_size     1
> > osd              osd_scrub_load_threshold  2000
> >
> > (osd.0 is an ssd)
> >
> > Thoughts?
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-746976893-1515176642=:24931--
