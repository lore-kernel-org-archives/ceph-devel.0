From: Alfredo Deza <adeza@redhat.com>
Subject: Re: mon config commands
Date: Mon, 15 Jan 2018 07:37:16 -0500
Message-ID: <CAC-Np1yDSAeYKXvqdfE-ZabJAMkjZ77m6jyDFAZT45i_TmwZ7A@mail.gmail.com>
References: <alpine.DEB.2.11.1801112044230.23413@piezo.novalocal>
 <CAC-Np1wJsDu8EgdGQLxeE9inh8eq0cU6aA4mccScC_O8qp4X5g@mail.gmail.com> <alpine.DEB.2.11.1801121849300.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:42042 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934371AbeAOMhR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 07:37:17 -0500
Received: by mail-qk0-f169.google.com with SMTP id k201so1578500qke.9
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jan 2018 04:37:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801121849300.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jan 12, 2018 at 1:57 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 12 Jan 2018, Alfredo Deza wrote:
>> On Thu, Jan 11, 2018 at 4:21 PM, Sage Weil <sage@redhat.com> wrote:
>> > Hi everyone,
>> >
>> > Here's the current state of the mon config commands for mimic.  These are
>> > pretty close to being "done" so please review carefully!
>> >
>> > config assimilate-conf                  Assimilate options from a conf, and
>> >                                          return a new, minimal conf file
>>
>> I think this would still be fine as `config assimilate`. The `-conf`
>> reads a bit redundant, and it wouldn't be terribly obscure to leave it
>> as plain `assimilate`
>
> Works for me  :)
>
>> > config dump                             Show all configuration option(s)
>> > config get <who> {<key>}                Show configuration option(s) for an
>> >                                          entity
>>
>> Is this output from help? Because "who" is not used anywhere in
>> configuration, and generally, it is used as "section", "daemon",
>> "type", or "process".
>>
>> Using any of the ones we currently describe would be good, "who" is too
>> vague.
>
> It can be any of the above, which is why it's vague... it might be
> "global", it might be a daemon type, it might be a daemon name, and it
> might be a combination of any of those and a mask (or masks) (e.g.,
> "osd/rack:foo/class:ssd").

I see a couple of options here.

1. If we insist on using 'who', then our docs need to be updated to
use this new terminology. There are lots of places where the vagueness
is present and we would need to use this so that
a user can correlate the terminology.

2. Use some other, preexisting term like 'type', which is already
present in multiple places, and is still suitable for
defining a process, daermon, or group

3. Not use it at all, and instead make that item the heading for each
group in the output (just like the JSON output doesn't
have a 'who' key)

>
>> > config help <key>                       Describe a configuration option
>> > config rm <who> <name>                  Clear a configuration option for one or
>> >                                          more entities
>> > config set <who> <name> <value>         Cet a configuration option for one or
>> >                                          more entities
>> > config show <who> {<key>}               Show running configuration
>> > config show-with-defaults <who>         Show running configuration (including
>> >                                          compiled-in defaults)
>> > ---
>> >
>> > First, let's dump everything:
>> >
>> > $ bin/ceph config dump
>> > WHO    MASK LEVEL     OPTION                         VALUE  RO
>> > global      advanced  mon_pg_warn_min_per_osd        3
>> > global      advanced  osd_crush_chooseleaf_type      0
>> > global      advanced  osd_pool_default_min_size      1
>> > global      advanced  osd_pool_default_size          1
>> > mds         advanced  debug_mds                      20/20
>> > mds         advanced  debug_mgrc                     20/20
>> > mds         advanced  debug_monc                     20/20
>> > mds         advanced  debug_ms                       1/1
>> > mds         developer mds_debug_auth_pins            true
>> > mds         developer mds_debug_frag                 true
>> > mds         developer mds_debug_scatterstat          true
>> > mds         developer mds_debug_subtrees             true
>> > mds         developer mds_verify_scatter             true
>> > mgr         advanced  debug_mgr                      20/20
>> > mgr         advanced  debug_mon                      20/20
>> > mgr         advanced  debug_monc                     20/20
>> > mgr         advanced  debug_ms                       1/1
>> > mon         unknown   mon_allow_pool_deletes         true   *
>> > mon         advanced  mon_data_avail_crit            1
>> > mon         advanced  mon_data_avail_warn            2
>> > ...
>> >
>> > Note the one RO item here is also 'unknown'.. that's because it's not a
>> > valid config option (there's no 's').. it was injected directly into
>> > config-key.
>>
>> Is there a JSON flag for the above output? How does that look?
>
> [
>     {
>         "section": "global",
>         "name": "enable_experimental_unrecoverable_data_corrupting_features",
>         "value": "*"
>     },
>     {
>         "section": "global",
>         "name": "erasure_code_dir",
>         "value": "/home/sage/src/ceph6/build/lib"
>     },
>
> Hmm, here I call it "section," which is probably not ideal.  In the mask
> case, though, it's something like
>
>     {
>         "section": "osd.1",
>         "name": "debug_osd",
>         "value": "11/11",
>         "location_type": "rack",
>         "location_value": "foo",
>         "device_class": "ssd"
>     }

This is exactly what I am going for. It is going to be tricky to get
'WHO' to stick everywhere and make sense.

On the consumer side, a client would need to understand that human
readable output with WHO might map to 'section' , and if
something else decides this is not a 'section' but a 'daemon', then
'WHO' becomes less meaningful and more confusing.

>
>> The plain output here could be really long, and although one can
>> probably 'grep' at will, would it be overkill to filter or sort
>> this so that we can easily pick 'unknown' for example?
>>
>> For plain (not JSON) the output could be structured in at least two
>> levels that would make it easier on an admin:
>>
>> <section>
>>     <level>
>>         <option> <value> <permissions>
>>     <unknown>
>>         <option> <value> <permissions>
>>
>> That way, it is easier to spot unknown items, or if that is not
>> desirable, then at least it would be easier to go through them
>> visually
>
> We talked about doing indentation before but I wasn't sure I liked it.
> Here's the output:
>
> WHO            MASK LEVEL     OPTION                                                     VALUE                                                                                                         RO
> global              advanced  enable_experimental_unrecoverable_data_corrupting_features *                                                                                                             *
> global              advanced  erasure_code_dir                                           /home/sage/src/ceph6/build/lib                                                                                *
> global              developer filestore_fd_cache_size                                    32
> global              advanced  mon_pg_warn_min_per_osd                                    3
> global              advanced  osd_crush_chooseleaf_type                                  0
> global              advanced  osd_failsafe_full_ratio                                    .99
> global              advanced  osd_pool_default_min_size                                  1
> global              advanced  osd_pool_default_size                                      1
> global              advanced  plugin_dir                                                 /home/sage/src/ceph6/build/lib                                                                                *
> global              advanced  run_dir                                                    /home/sage/src/ceph6/build/out                                                                                *
>   client            advanced  admin_socket                                               /tmp/ceph-asok.GBZTV0/$name.$pid.asok                                                                         *
>   client            basic     log_file                                                   /home/sage/src/ceph6/build/out/$name.$pid.log                                                                 *
>     client.rgw      advanced  rgw_crypt_require_ssl                                      false
>     client.rgw      developer rgw_crypt_s3_kms_encryption_keys                           testkey-1=YmluCmJvb3N0CmJvb3N0LWJ1aWxkCmNlcGguY29uZgo= testkey-2=aWIKTWFrZWZpbGUKbWFuCm91dApzcmMKVGVzdGluZwo= *
>     client.rgw      basic     rgw_frontends                                              civetweb port=8000                                                                                            *
>     client.rgw      developer rgw_lc_debug_interval                                      10
>   mds               advanced  admin_socket                                               /tmp/ceph-asok.GBZTV0/$name.asok                                                                              *
>   mds               advanced  debug_mds                                                  20/20
>   mds               advanced  debug_mgrc                                                 20/20
>   mds               advanced  debug_monc                                                 20/20
>   mds               advanced  debug_ms                                                   1/1
>   mds               advanced  heartbeat_file                                             /home/sage/src/ceph6/build/out/$name.heartbeat                                                                *
>   mds               basic     log_file                                                   /home/sage/src/ceph6/build/out/$name.log                                                                      *
>   mds               developer mds_debug_auth_pins                                        true
>   mds               developer mds_debug_frag                                             true
>   mds               developer mds_debug_scatterstat                                      true
>   mds               developer mds_debug_subtrees                                         true
>   mds               advanced  mds_root_ino_gid                                           1031
>   mds               advanced  mds_root_ino_uid                                           1031
>   mds               developer mds_verify_scatter                                         true
>   mds               advanced  pid_file                                                   /home/sage/src/ceph6/build/out/$name.pid                                                                      *
>   mgr               advanced  admin_socket                                               /tmp/ceph-asok.GBZTV0/$name.asok                                                                              *
>   mgr               advanced  debug_mgr                                                  20/20
>   mgr               advanced  debug_mon                                                  20/20
>   mgr               advanced  debug_monc                                                 20/20
>   mgr               advanced  debug_ms                                                   1/1
>   mgr               advanced  heartbeat_file                                             /home/sage/src/ceph6/build/out/$name.heartbeat                                                                *
>   mgr               basic     log_file                                                   /home/sage/src/ceph6/build/out/$name.log                                                                      *
>   mgr               advanced  mgr_module_path                                            /home/sage/src/ceph6/src/pybind/mgr                                                                           *
>   mgr               advanced  pid_file                                                   /home/sage/src/ceph6/build/out/$name.pid                                                                      *
>     mgr.x           advanced  mgr_stats_threshold                                        -2
>   mon               advanced  admin_socket                                               /tmp/ceph-asok.GBZTV0/$name.asok                                                                              *
>   mon               advanced  debug_auth                                                 20/20
>   mon               advanced  debug_mgrc                                                 20/20
>   mon               advanced  debug_mon                                                  20/20
>   mon               advanced  debug_ms                                                   1/1
>   mon               advanced  debug_paxos                                                20/20
>   mon               advanced  heartbeat_file                                             /home/sage/src/ceph6/build/out/$name.heartbeat                                                                *
>   mon               basic     log_file                                                   /home/sage/src/ceph6/build/out/$name.log                                                                      *
>   mon               unknown   mon_allow_pool_deletes                                     true                                                                                                          *
>   mon               advanced  mon_cluster_log_file                                       /home/sage/src/ceph6/build/out/cluster.mon.$id.log                                                            *
>   mon               advanced  mon_data_avail_crit                                        1
>   mon               advanced  mon_data_avail_warn                                        2
>   mon               advanced  mon_osd_reporter_subtree_level                             osd
>   mon               advanced  pid_file                                                   /home/sage/src/ceph6/build/out/$name.pid                                                                      *
>   osd               advanced  admin_socket                                               /tmp/ceph-asok.GBZTV0/$name.asok                                                                              *
>   osd               developer bluestore_block_create                                     true                                                                                                          *
>   osd               developer bluestore_block_db_create                                  true                                                                                                          *
>   osd               developer bluestore_block_db_path                                    /home/sage/src/ceph6/build/dev/osd$id/block.db.file                                                           *
>   osd               developer bluestore_block_db_size                                    67108864                                                                                                      *
>   osd               developer bluestore_block_wal_create                                 true                                                                                                          *
>   osd               developer bluestore_block_wal_path                                   /home/sage/src/ceph6/build/dev/osd$id/block.wal.file                                                          *
>   osd               developer bluestore_block_wal_size                                   1048576000                                                                                                    *
>   osd               developer bluestore_fsck_on_mount                                    true
>   osd               advanced  debug_bdev                                                 20/20
>   osd               advanced  debug_bluefs                                               20/20
>   osd               advanced  debug_bluestore                                            30/30
>   osd               advanced  debug_filestore                                            20/20
>   osd               advanced  debug_journal                                              20/20
>   osd               advanced  debug_mgrc                                                 20/20
>   osd               advanced  debug_monc                                                 20/20
>   osd               advanced  debug_ms                                                   1/1
>   osd               advanced  debug_objclass                                             20/20
>   osd               advanced  debug_objecter                                             20/20
>   osd               advanced  debug_osd                                                  25/25
>   osd               advanced  debug_reserver                                             10/10
>   osd               advanced  debug_rocksdb                                              20/20
>   osd               advanced  filestore_wbthrottle_btrfs_inodes_hard_limit               30
>   osd               advanced  filestore_wbthrottle_btrfs_ios_hard_limit                  20
>   osd               advanced  filestore_wbthrottle_btrfs_ios_start_flusher               10
>   osd               advanced  filestore_wbthrottle_xfs_inodes_hard_limit                 30
>   osd               advanced  filestore_wbthrottle_xfs_ios_hard_limit                    20
>   osd               advanced  filestore_wbthrottle_xfs_ios_start_flusher                 10
>   osd               advanced  heartbeat_file                                             /home/sage/src/ceph6/build/out/$name.heartbeat                                                                *
>   osd               basic     log_file                                                   /home/sage/src/ceph6/build/out/$name.log                                                                      *
>   osd               developer osd_check_max_object_name_len_on_startup                   false
>   osd               advanced  osd_class_default_list                                     *                                                                                                             *
>   osd               advanced  osd_class_dir                                              /home/sage/src/ceph6/build/lib                                                                                *
>   osd               advanced  osd_class_load_list                                        *                                                                                                             *
>   osd               advanced  osd_copyfrom_max_chunk                                     524288
>   osd               developer osd_debug_misdirected_ops                                  true
>   osd               developer osd_debug_op_order                                         true
>   osd               advanced  osd_journal_size                                           100
>   osd               advanced  osd_objectstore                                            bluestore                                                                                                     *
>   osd               advanced  osd_scrub_load_threshold                                   2000
>   osd               advanced  pid_file                                                   /home/sage/src/ceph6/build/out/$name.pid                                                                      *
>     osd.0           advanced  osd_tier_default_cache_mode                                writeback
>
> I'm not sure if your suggestion is to sort by (who,level,option) (which we
> could do with the above without too much effort) or to have extra lines in
> the output so you'd see something along the lines of

Yes to both, they are separate requests. Regardless of output format,
would be nice to say 'give me anything that is RO',
or 'show only advanced and global'.


>
> global
>   advanced
>     debug_ms                  1
>     ms_type                   simple
> osd
>   basic
>     cluster_network           10.0.0.0/8
>   advanced
>     debug_osd                 10
>
> ?

Yes, by indenting, it makes it easier on the eyes when there is more
than a dozen options with different values. One plus here is that you
could
get rid of the 'WHO' labeling

>
> I'm inclined to stick with a table format (both because we do that
> elsewhere and we have the handy TextTable class to make it easy).  With or
> without indentation... what do you think?

The table is fine for short output, it is not going to be nicer on the
user side of things when it is large, and I can see how this can
become
very long. The INI-style ceph.conf files have that indentation, and
when dealing with large configuration files it definitely helps.

I understand though if this would be too much to rework

>
>> > Similarly, if I try to override something else manually,
>> >
>> > gnit:build (wip-config) 02:50 PM $ bin/ceph daemon mon.a config set mon_data_avail_warn 3
>> > {
>> >     "success": ""
>> > }
>>
>> Why is this response JSON? If the response was a success I would
>> expect a "success": true, but if this is coming directly from the
>> monitor I guess
>> we don't have a choice to use it as is?
>
> Good question, it's old code I haven't touched.  I'll clean it up.
>
>
> Thanks for the feedback!
> sage
