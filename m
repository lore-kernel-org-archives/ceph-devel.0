From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: mon config commands
Date: Fri, 12 Jan 2018 15:17:51 -0800
Message-ID: <CAJ4mKGbpTo_B3XghsLHzXki_RhCLbikiRKcw9bGV6TpPCFxEqw@mail.gmail.com>
References: <alpine.DEB.2.11.1801112044230.23413@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:46647 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965236AbeALXRw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jan 2018 18:17:52 -0500
Received: by mail-it0-f45.google.com with SMTP id c16so10877625itc.5
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jan 2018 15:17:52 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801112044230.23413@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The rest looks good, but I don't understand this thing about "RO"
values at all. Based on what's here, it represents options that aren't
live yet, but will be on reboot?

On Thu, Jan 11, 2018 at 1:21 PM, Sage Weil <sage@redhat.com> wrote:
> If I try to set something that can't be changed at runtime (say, ms_type),
> you get:
>
> gnit:build (wip-config) 02:47 PM $ bin/ceph config set mon.a ms_type
> simple
> gnit:build (wip-config) 02:48 PM $ bin/ceph config get mon.a
> WHO    MASK LEVEL    OPTION                         VALUE  RO
> mon         unknown  mon_allow_pool_deletes         true   *
> mon         advanced mon_data_avail_crit            1
> mon         advanced mon_data_avail_warn            2
> mon         advanced mon_osd_reporter_subtree_level osd
> global      advanced mon_pg_warn_min_per_osd        3
> mon.a       advanced ms_type                        simple *
> global      advanced osd_crush_chooseleaf_type      0
> global      advanced osd_pool_default_min_size      1
> global      advanced osd_pool_default_size          1
>
> You can then see this by checking the *running* config (this is what the
> daemon has reported as it's actually config to the manager):
>
> gnit:build (wip-config) 02:48 PM $ bin/ceph config show mon.a
> NAME                                                       VALUE                                              SOURCE  OVERRIDES IGNORES
> admin_socket                                               /tmp/ceph-asok.GBZTV0/$name.asok                   file
> chdir                                                                                                         file
> debug_auth                                                 20/20                                              file
> debug_mgrc                                                 20/20                                              file
> debug_mon                                                  20/20                                              file
> debug_ms                                                   1/1                                                file
> debug_paxos                                                20/20                                              file
> enable_experimental_unrecoverable_data_corrupting_features *                                                  file
> erasure_code_dir                                           /home/sage/src/ceph6/build/lib                     file
> filestore_fd_cache_size                                    32                                                 file
> heartbeat_file                                             /home/sage/src/ceph6/build/out/$name.heartbeat     file
> leveldb_block_size                                         65536                                              default
> leveldb_cache_size                                         536870912                                          default
> leveldb_compression                                        0                                                  default
> leveldb_log                                                                                                   default
> leveldb_write_buffer_size                                  33554432                                           default
> lockdep                                                    1                                                  file
> log_file                                                   /home/sage/src/ceph6/build/out/$name.log           file
> mgr_initial_modules                                        restful status dashboard balancer                  file
> mon_cluster_log_file                                       /home/sage/src/ceph6/build/out/cluster.mon.$id.log file
> mon_data                                                   /home/sage/src/ceph6/build/dev/mon.a               file
> mon_data_avail_crit                                        1                                                  mon
> mon_data_avail_warn                                        2                                                  mon
> mon_osd_backfillfull_ratio                                 0.99                                               file
> mon_osd_full_ratio                                         0.99                                               file
> mon_osd_nearfull_ratio                                     0.99                                               file
> mon_osd_reporter_subtree_level                             osd                                                mon
> mon_pg_warn_min_per_osd                                    3                                                  mon
> ms_type                                                    async+posix                                        default           mon
> osd_crush_chooseleaf_type                                  0                                                  mon
> osd_failsafe_full_ratio                                    0.99                                               file
> osd_pool_default_min_size                                  1                                                  mon
> osd_pool_default_size                                      1                                                  mon
> pid_file                                                   /home/sage/src/ceph6/build/out/mon.a.pid           cmdline file
> plugin_dir                                                 /home/sage/src/ceph6/build/lib                     file
> run_dir                                                    /home/sage/src/ceph6/build/out                     file
>
> (sorry for the wide table)
>
> A few things to note: SOURCE can be any of default, file, mon, env,
> cmdline, or override.  You'll notice that ms_type SOURCE is 'default' and
> IGNORES is 'mon', because the daemon is ignoring the mon value--this
> option can only be set during startup.

I also don't get how one mon having a different setting means that all
mons are marked as ignoring it.

Putting them right next to each other also makes it clear in my mind
that people are going to be confused about "config get" versus "config
show". Perhaps it should be "get_stored" and "show_running" or
something? I don't like those names, but they need to be clearer. And
now I've got a new feature request: a command that outputs the
difference between those two. Or perhaps that goes through *all* the
configs and dumps any daemons whose running config differs from their
stored ones.

On Fri, Jan 12, 2018 at 10:57 AM, Sage Weil <sweil@redhat.com> wrote:
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

Count me as a vote for "assimilate-conf" over "assimilate".
Specificity is easier to search for help on, and easier to understand.
-Greg
