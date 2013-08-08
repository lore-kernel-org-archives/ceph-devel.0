From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: still recovery issues with cuttlefish
Date: Thu, 08 Aug 2013 20:13:02 +0200
Message-ID: <5203DFAE.9070100@profihost.ag>
References: <51FA1AC1.8040207@profihost.ag> <CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com> <51FAAED3.3010509@cloudapt.com> <51FAB20F.3030707@profihost.ag> <CA+4uBUY079TZ7sm1EafO1pnXCpKSTkfc15KwqBLi8SyV=Z_29A@mail.gmail.com> <51FB636B.5050301@profihost.ag> <CA+4uBUbye9EOHxFgOYXah8Eg_6ZRtPY_MpgjbnNa=_ZrhFak_w@mail.gmail.com> <51FBF765.9030700@profihost.ag> <CA+4uBUZY-_jsnG+wfE4LXL-Dw2CtRkNuANwPMMJ4JyUU=4tdRQ@mail.gmail.com> <51FBFE85.5040700@profihost.ag> <5203A597.4060701@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:50624 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757978Ab3HHSNE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 14:13:04 -0400
In-Reply-To: <5203A597.4060701@cloudapt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@cloudapt.com>
Cc: Samuel Just <sam.just@inktank.com>, "josh.durgin@inktank.com" <josh.durgin@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi Mike,

Am 08.08.2013 16:05, schrieb Mike Dawson:
> Stefan,
>
> I see the same behavior and I theorize it is linked to an issue detailed
> in another thread [0]. Do your VM guests ever hang while your cluster is
> HEALTH_OK like described in that other thread?
>
> [0] http://comments.gmane.org/gmane.comp.file-systems.ceph.user/2982

mhm no can't see that. All our VMs are working fine even under high load 
while ceph is OK.

> A few observations:
>
> - The VMs that hang do lots of writes (video surveillance).
> - I use rbd and qemu. The problem exists in both qemu 1.4.x and 1.5.2.
> - The problem exists with or without joshd's qemu async flush patch.
> - Windows VMs seem to be more vulnerable than Linux VMs.
> - If I restart the qemu-system-x86_64 process, the guest will come back
> to life.
> - A partial workaround seems to be console input (NoVNC or 'virsh
> screenshot'), but restarting qemu-system-x86_64 works better.
> - The issue of VMs hanging seems worse with RBD writeback cache enabled
> - I typically run virtio, but I believe I've seen it with e1000, too.
> - VM guests hang at different times, not all at once on a host (or
> across all hosts).
> - I co-mingle VM guests on servers that host ceph OSDs.
>
>
>
> Oliver,
>
> If your cluster has to recover/backfill, do your guest VMs hang with
> more frequency than under normal HEALTH_OK conditions, even if you
> prioritize client IO as Sam wrote below?
>
>
> Sam,
>
> Turning down all the settings you mentioned certainly does slow the
> recover/backfill process, but it doesn't prevent the VM guests backed by
> RBD volumes from hanging. In fact, I often try to prioritize
> recovery/backfill because my guests tend to hang until I get back to
> HEALTH_OK. Given this apparent bug, completing recovery/backfill quicker
> leads to less total outage, it seems.
>
>
> Josh,
>
> How can I help you investigate if RBD is the common source of both of
> these issues?
>
>
> Thanks,
> Mike Dawson
>
>
> On 8/2/2013 2:46 PM, Stefan Priebe wrote:
>> Hi,
>>
>>          osd recovery max active = 1
>>          osd max backfills = 1
>>          osd recovery op priority = 5
>>
>> still no difference...
>>
>> Stefan
>>
>> Am 02.08.2013 20:21, schrieb Samuel Just:
>>> Also, you have osd_recovery_op_priority at 50.  That is close to the
>>> priority of client IO.  You want it below 10 (defaults to 10), perhaps
>>> at 1.  You can also adjust down osd_recovery_max_active.
>>> -Sam
>>>
>>> On Fri, Aug 2, 2013 at 11:16 AM, Stefan Priebe <s.priebe@profihost.ag>
>>> wrote:
>>>> I already tried both values this makes no difference. The drives are
>>>> not the
>>>> bottleneck.
>>>>
>>>> Am 02.08.2013 19:35, schrieb Samuel Just:
>>>>
>>>>> You might try turning osd_max_backfills to 2 or 1.
>>>>> -Sam
>>>>>
>>>>> On Fri, Aug 2, 2013 at 12:44 AM, Stefan Priebe <s.priebe@profihost.ag>
>>>>> wrote:
>>>>>>
>>>>>> Am 01.08.2013 23:23, schrieb Samuel Just:> Can you dump your osd
>>>>>> settings?
>>>>>>
>>>>>>> sudo ceph --admin-daemon ceph-osd.<osdid>.asok config show
>>>>>>
>>>>>>
>>>>>> Sure.
>>>>>>
>>>>>>
>>>>>>
>>>>>> { "name": "osd.0",
>>>>>>     "cluster": "ceph",
>>>>>>     "none": "0\/5",
>>>>>>     "lockdep": "0\/0",
>>>>>>     "context": "0\/0",
>>>>>>     "crush": "0\/0",
>>>>>>     "mds": "0\/0",
>>>>>>     "mds_balancer": "0\/0",
>>>>>>     "mds_locker": "0\/0",
>>>>>>     "mds_log": "0\/0",
>>>>>>     "mds_log_expire": "0\/0",
>>>>>>     "mds_migrator": "0\/0",
>>>>>>     "buffer": "0\/0",
>>>>>>     "timer": "0\/0",
>>>>>>     "filer": "0\/0",
>>>>>>     "striper": "0\/1",
>>>>>>     "objecter": "0\/0",
>>>>>>     "rados": "0\/0",
>>>>>>     "rbd": "0\/0",
>>>>>>     "journaler": "0\/0",
>>>>>>     "objectcacher": "0\/0",
>>>>>>     "client": "0\/0",
>>>>>>     "osd": "0\/0",
>>>>>>     "optracker": "0\/0",
>>>>>>     "objclass": "0\/0",
>>>>>>     "filestore": "0\/0",
>>>>>>     "journal": "0\/0",
>>>>>>     "ms": "0\/0",
>>>>>>     "mon": "0\/0",
>>>>>>     "monc": "0\/0",
>>>>>>     "paxos": "0\/0",
>>>>>>     "tp": "0\/0",
>>>>>>     "auth": "0\/0",
>>>>>>     "crypto": "1\/5",
>>>>>>     "finisher": "0\/0",
>>>>>>     "heartbeatmap": "0\/0",
>>>>>>     "perfcounter": "0\/0",
>>>>>>     "rgw": "0\/0",
>>>>>>     "hadoop": "0\/0",
>>>>>>     "javaclient": "1\/5",
>>>>>>     "asok": "0\/0",
>>>>>>     "throttle": "0\/0",
>>>>>>     "host": "cloud1-1268",
>>>>>>     "fsid": "00000000-0000-0000-0000-000000000000",
>>>>>>     "public_addr": "10.255.0.90:0\/0",
>>>>>>     "cluster_addr": "10.255.0.90:0\/0",
>>>>>>     "public_network": "10.255.0.1\/24",
>>>>>>     "cluster_network": "10.255.0.1\/24",
>>>>>>     "num_client": "1",
>>>>>>     "monmap": "",
>>>>>>     "mon_host": "",
>>>>>>     "lockdep": "false",
>>>>>>     "run_dir": "\/var\/run\/ceph",
>>>>>>     "admin_socket": "\/var\/run\/ceph\/ceph-osd.0.asok",
>>>>>>     "daemonize": "true",
>>>>>>     "pid_file": "\/var\/run\/ceph\/osd.0.pid",
>>>>>>     "chdir": "\/",
>>>>>>     "max_open_files": "0",
>>>>>>     "fatal_signal_handlers": "true",
>>>>>>     "log_file": "\/var\/log\/ceph\/ceph-osd.0.log",
>>>>>>     "log_max_new": "1000",
>>>>>>     "log_max_recent": "10000",
>>>>>>     "log_to_stderr": "false",
>>>>>>     "err_to_stderr": "true",
>>>>>>     "log_to_syslog": "false",
>>>>>>     "err_to_syslog": "false",
>>>>>>     "log_flush_on_exit": "true",
>>>>>>     "log_stop_at_utilization": "0.97",
>>>>>>     "clog_to_monitors": "true",
>>>>>>     "clog_to_syslog": "false",
>>>>>>     "clog_to_syslog_level": "info",
>>>>>>     "clog_to_syslog_facility": "daemon",
>>>>>>     "mon_cluster_log_to_syslog": "false",
>>>>>>     "mon_cluster_log_to_syslog_level": "info",
>>>>>>     "mon_cluster_log_to_syslog_facility": "daemon",
>>>>>>     "mon_cluster_log_file": "\/var\/log\/ceph\/ceph.log",
>>>>>>     "key": "",
>>>>>>     "keyfile": "",
>>>>>>     "keyring": "\/etc\/ceph\/osd.0.keyring",
>>>>>>     "heartbeat_interval": "5",
>>>>>>     "heartbeat_file": "",
>>>>>>     "heartbeat_inject_failure": "0",
>>>>>>     "perf": "true",
>>>>>>     "ms_tcp_nodelay": "true",
>>>>>>     "ms_tcp_rcvbuf": "0",
>>>>>>     "ms_initial_backoff": "0.2",
>>>>>>     "ms_max_backoff": "15",
>>>>>>     "ms_nocrc": "false",
>>>>>>     "ms_die_on_bad_msg": "false",
>>>>>>     "ms_die_on_unhandled_msg": "false",
>>>>>>     "ms_dispatch_throttle_bytes": "104857600",
>>>>>>     "ms_bind_ipv6": "false",
>>>>>>     "ms_bind_port_min": "6800",
>>>>>>     "ms_bind_port_max": "7100",
>>>>>>     "ms_rwthread_stack_bytes": "1048576",
>>>>>>     "ms_tcp_read_timeout": "900",
>>>>>>     "ms_pq_max_tokens_per_priority": "4194304",
>>>>>>     "ms_pq_min_cost": "65536",
>>>>>>     "ms_inject_socket_failures": "0",
>>>>>>     "ms_inject_delay_type": "",
>>>>>>     "ms_inject_delay_max": "1",
>>>>>>     "ms_inject_delay_probability": "0",
>>>>>>     "ms_inject_internal_delays": "0",
>>>>>>     "mon_data": "\/var\/lib\/ceph\/mon\/ceph-0",
>>>>>>     "mon_initial_members": "",
>>>>>>     "mon_sync_fs_threshold": "5",
>>>>>>     "mon_compact_on_start": "false",
>>>>>>     "mon_compact_on_bootstrap": "false",
>>>>>>     "mon_compact_on_trim": "true",
>>>>>>     "mon_tick_interval": "5",
>>>>>>     "mon_subscribe_interval": "300",
>>>>>>     "mon_osd_laggy_halflife": "3600",
>>>>>>     "mon_osd_laggy_weight": "0.3",
>>>>>>     "mon_osd_adjust_heartbeat_grace": "true",
>>>>>>     "mon_osd_adjust_down_out_interval": "true",
>>>>>>     "mon_osd_auto_mark_in": "false",
>>>>>>     "mon_osd_auto_mark_auto_out_in": "true",
>>>>>>     "mon_osd_auto_mark_new_in": "true",
>>>>>>     "mon_osd_down_out_interval": "300",
>>>>>>     "mon_osd_down_out_subtree_limit": "rack",
>>>>>>     "mon_osd_min_up_ratio": "0.3",
>>>>>>     "mon_osd_min_in_ratio": "0.3",
>>>>>>     "mon_stat_smooth_intervals": "2",
>>>>>>     "mon_lease": "5",
>>>>>>     "mon_lease_renew_interval": "3",
>>>>>>     "mon_lease_ack_timeout": "10",
>>>>>>     "mon_clock_drift_allowed": "0.05",
>>>>>>     "mon_clock_drift_warn_backoff": "5",
>>>>>>     "mon_timecheck_interval": "300",
>>>>>>     "mon_accept_timeout": "10",
>>>>>>     "mon_pg_create_interval": "30",
>>>>>>     "mon_pg_stuck_threshold": "300",
>>>>>>     "mon_osd_full_ratio": "0.95",
>>>>>>     "mon_osd_nearfull_ratio": "0.85",
>>>>>>     "mon_globalid_prealloc": "100",
>>>>>>     "mon_osd_report_timeout": "900",
>>>>>>     "mon_force_standby_active": "true",
>>>>>>     "mon_min_osdmap_epochs": "500",
>>>>>>     "mon_max_pgmap_epochs": "500",
>>>>>>     "mon_max_log_epochs": "500",
>>>>>>     "mon_max_osd": "10000",
>>>>>>     "mon_probe_timeout": "2",
>>>>>>     "mon_slurp_timeout": "10",
>>>>>>     "mon_slurp_bytes": "262144",
>>>>>>     "mon_client_bytes": "104857600",
>>>>>>     "mon_daemon_bytes": "419430400",
>>>>>>     "mon_max_log_entries_per_event": "4096",
>>>>>>     "mon_health_data_update_interval": "60",
>>>>>>     "mon_data_avail_crit": "5",
>>>>>>     "mon_data_avail_warn": "30",
>>>>>>     "mon_config_key_max_entry_size": "4096",
>>>>>>     "mon_sync_trim_timeout": "30",
>>>>>>     "mon_sync_heartbeat_timeout": "30",
>>>>>>     "mon_sync_heartbeat_interval": "5",
>>>>>>     "mon_sync_backoff_timeout": "30",
>>>>>>     "mon_sync_timeout": "30",
>>>>>>     "mon_sync_max_retries": "5",
>>>>>>     "mon_sync_max_payload_size": "1048576",
>>>>>>     "mon_sync_debug": "false",
>>>>>>     "mon_sync_debug_leader": "-1",
>>>>>>     "mon_sync_debug_provider": "-1",
>>>>>>     "mon_sync_debug_provider_fallback": "-1",
>>>>>>     "mon_debug_dump_transactions": "false",
>>>>>>     "mon_debug_dump_location": "\/var\/log\/ceph\/ceph-osd.0.tdump",
>>>>>>     "mon_sync_leader_kill_at": "0",
>>>>>>     "mon_sync_provider_kill_at": "0",
>>>>>>     "mon_sync_requester_kill_at": "0",
>>>>>>     "mon_leveldb_write_buffer_size": "33554432",
>>>>>>     "mon_leveldb_cache_size": "268435456",
>>>>>>     "mon_leveldb_block_size": "65536",
>>>>>>     "mon_leveldb_bloom_size": "0",
>>>>>>     "mon_leveldb_max_open_files": "0",
>>>>>>     "mon_leveldb_compression": "false",
>>>>>>     "mon_leveldb_paranoid": "false",
>>>>>>     "mon_leveldb_log": "",
>>>>>>     "paxos_stash_full_interval": "25",
>>>>>>     "paxos_max_join_drift": "100",
>>>>>>     "paxos_propose_interval": "1",
>>>>>>     "paxos_min_wait": "0.05",
>>>>>>     "paxos_min": "500",
>>>>>>     "paxos_trim_min": "500",
>>>>>>     "paxos_trim_max": "1000",
>>>>>>     "paxos_trim_disabled_max_versions": "108000",
>>>>>>     "paxos_service_trim_min": "500",
>>>>>>     "paxos_service_trim_max": "1000",
>>>>>>     "clock_offset": "0",
>>>>>>     "auth_cluster_required": "none",
>>>>>>     "auth_service_required": "none",
>>>>>>     "auth_client_required": "none",
>>>>>>     "auth_supported": "none",
>>>>>>     "cephx_require_signatures": "false",
>>>>>>     "cephx_cluster_require_signatures": "false",
>>>>>>     "cephx_service_require_signatures": "false",
>>>>>>     "cephx_sign_messages": "true",
>>>>>>     "auth_mon_ticket_ttl": "43200",
>>>>>>     "auth_service_ticket_ttl": "3600",
>>>>>>     "auth_debug": "false",
>>>>>>     "mon_client_hunt_interval": "3",
>>>>>>     "mon_client_ping_interval": "10",
>>>>>>     "mon_client_max_log_entries_per_message": "1000",
>>>>>>     "mon_max_pool_pg_num": "65536",
>>>>>>     "mon_pool_quota_warn_threshold": "0",
>>>>>>     "mon_pool_quota_crit_threshold": "0",
>>>>>>     "client_cache_size": "16384",
>>>>>>     "client_cache_mid": "0.75",
>>>>>>     "client_use_random_mds": "false",
>>>>>>     "client_mount_timeout": "300",
>>>>>>     "client_tick_interval": "1",
>>>>>>     "client_trace": "",
>>>>>>     "client_readahead_min": "131072",
>>>>>>     "client_readahead_max_bytes": "0",
>>>>>>     "client_readahead_max_periods": "4",
>>>>>>     "client_snapdir": ".snap",
>>>>>>     "client_mountpoint": "\/",
>>>>>>     "client_notify_timeout": "10",
>>>>>>     "client_caps_release_delay": "5",
>>>>>>     "client_oc": "true",
>>>>>>     "client_oc_size": "209715200",
>>>>>>     "client_oc_max_dirty": "104857600",
>>>>>>     "client_oc_target_dirty": "8388608",
>>>>>>     "client_oc_max_dirty_age": "5",
>>>>>>     "client_oc_max_objects": "1000",
>>>>>>     "client_debug_force_sync_read": "false",
>>>>>>     "client_debug_inject_tick_delay": "0",
>>>>>>     "fuse_use_invalidate_cb": "false",
>>>>>>     "fuse_allow_other": "true",
>>>>>>     "fuse_default_permissions": "true",
>>>>>>     "fuse_big_writes": "true",
>>>>>>     "fuse_atomic_o_trunc": "true",
>>>>>>     "fuse_debug": "false",
>>>>>>     "objecter_tick_interval": "5",
>>>>>>     "objecter_timeout": "10",
>>>>>>     "objecter_inflight_op_bytes": "104857600",
>>>>>>     "objecter_inflight_ops": "1024",
>>>>>>     "journaler_allow_split_entries": "true",
>>>>>>     "journaler_write_head_interval": "15",
>>>>>>     "journaler_prefetch_periods": "10",
>>>>>>     "journaler_prezero_periods": "5",
>>>>>>     "journaler_batch_interval": "0.001",
>>>>>>     "journaler_batch_max": "0",
>>>>>>     "mds_data": "\/var\/lib\/ceph\/mds\/ceph-0",
>>>>>>     "mds_max_file_size": "1099511627776",
>>>>>>     "mds_cache_size": "100000",
>>>>>>     "mds_cache_mid": "0.7",
>>>>>>     "mds_mem_max": "1048576",
>>>>>>     "mds_dir_commit_ratio": "0.5",
>>>>>>     "mds_dir_max_commit_size": "90",
>>>>>>     "mds_decay_halflife": "5",
>>>>>>     "mds_beacon_interval": "4",
>>>>>>     "mds_beacon_grace": "15",
>>>>>>     "mds_enforce_unique_name": "true",
>>>>>>     "mds_blacklist_interval": "1440",
>>>>>>     "mds_session_timeout": "60",
>>>>>>     "mds_session_autoclose": "300",
>>>>>>     "mds_reconnect_timeout": "45",
>>>>>>     "mds_tick_interval": "5",
>>>>>>     "mds_dirstat_min_interval": "1",
>>>>>>     "mds_scatter_nudge_interval": "5",
>>>>>>     "mds_client_prealloc_inos": "1000",
>>>>>>     "mds_early_reply": "true",
>>>>>>     "mds_use_tmap": "true",
>>>>>>     "mds_default_dir_hash": "2",
>>>>>>     "mds_log": "true",
>>>>>>     "mds_log_skip_corrupt_events": "false",
>>>>>>     "mds_log_max_events": "-1",
>>>>>>     "mds_log_segment_size": "0",
>>>>>>     "mds_log_max_segments": "30",
>>>>>>     "mds_log_max_expiring": "20",
>>>>>>     "mds_bal_sample_interval": "3",
>>>>>>     "mds_bal_replicate_threshold": "8000",
>>>>>>     "mds_bal_unreplicate_threshold": "0",
>>>>>>     "mds_bal_frag": "false",
>>>>>>     "mds_bal_split_size": "10000",
>>>>>>     "mds_bal_split_rd": "25000",
>>>>>>     "mds_bal_split_wr": "10000",
>>>>>>     "mds_bal_split_bits": "3",
>>>>>>     "mds_bal_merge_size": "50",
>>>>>>     "mds_bal_merge_rd": "1000",
>>>>>>     "mds_bal_merge_wr": "1000",
>>>>>>     "mds_bal_interval": "10",
>>>>>>     "mds_bal_fragment_interval": "5",
>>>>>>     "mds_bal_idle_threshold": "0",
>>>>>>     "mds_bal_max": "-1",
>>>>>>     "mds_bal_max_until": "-1",
>>>>>>     "mds_bal_mode": "0",
>>>>>>     "mds_bal_min_rebalance": "0.1",
>>>>>>     "mds_bal_min_start": "0.2",
>>>>>>     "mds_bal_need_min": "0.8",
>>>>>>     "mds_bal_need_max": "1.2",
>>>>>>     "mds_bal_midchunk": "0.3",
>>>>>>     "mds_bal_minchunk": "0.001",
>>>>>>     "mds_bal_target_removal_min": "5",
>>>>>>     "mds_bal_target_removal_max": "10",
>>>>>>     "mds_replay_interval": "1",
>>>>>>     "mds_shutdown_check": "0",
>>>>>>     "mds_thrash_exports": "0",
>>>>>>     "mds_thrash_fragments": "0",
>>>>>>     "mds_dump_cache_on_map": "false",
>>>>>>     "mds_dump_cache_after_rejoin": "false",
>>>>>>     "mds_verify_scatter": "false",
>>>>>>     "mds_debug_scatterstat": "false",
>>>>>>     "mds_debug_frag": "false",
>>>>>>     "mds_debug_auth_pins": "false",
>>>>>>     "mds_debug_subtrees": "false",
>>>>>>     "mds_kill_mdstable_at": "0",
>>>>>>     "mds_kill_export_at": "0",
>>>>>>     "mds_kill_import_at": "0",
>>>>>>     "mds_kill_link_at": "0",
>>>>>>     "mds_kill_rename_at": "0",
>>>>>>     "mds_kill_openc_at": "0",
>>>>>>     "mds_kill_journal_at": "0",
>>>>>>     "mds_kill_journal_expire_at": "0",
>>>>>>     "mds_kill_journal_replay_at": "0",
>>>>>>     "mds_inject_traceless_reply_probability": "0",
>>>>>>     "mds_wipe_sessions": "false",
>>>>>>     "mds_wipe_ino_prealloc": "false",
>>>>>>     "mds_skip_ino": "0",
>>>>>>     "max_mds": "1",
>>>>>>     "mds_standby_for_name": "",
>>>>>>     "mds_standby_for_rank": "-1",
>>>>>>     "mds_standby_replay": "false",
>>>>>>     "osd_auto_upgrade_tmap": "true",
>>>>>>     "osd_tmapput_sets_uses_tmap": "false",
>>>>>>     "osd_max_backfills": "5",
>>>>>>     "osd_backfill_full_ratio": "0.85",
>>>>>>     "osd_backfill_retry_interval": "10",
>>>>>>     "osd_uuid": "00000000-0000-0000-0000-000000000000",
>>>>>>     "osd_data": "\/ceph\/osd.0\/",
>>>>>>     "osd_journal": "\/dev\/disk\/by-partlabel\/journalosd0",
>>>>>>     "osd_journal_size": "5120",
>>>>>>     "osd_max_write_size": "90",
>>>>>>     "osd_max_pgls": "1024",
>>>>>>     "osd_client_message_size_cap": "524288000",
>>>>>>     "osd_client_message_cap": "100",
>>>>>>     "osd_pg_bits": "6",
>>>>>>     "osd_pgp_bits": "6",
>>>>>>     "osd_crush_chooseleaf_type": "1",
>>>>>>     "osd_min_rep": "1",
>>>>>>     "osd_max_rep": "10",
>>>>>>     "osd_pool_default_crush_rule": "0",
>>>>>>     "osd_pool_default_size": "2",
>>>>>>     "osd_pool_default_min_size": "0",
>>>>>>     "osd_pool_default_pg_num": "8",
>>>>>>     "osd_pool_default_pgp_num": "8",
>>>>>>     "osd_pool_default_flags": "0",
>>>>>>     "osd_map_dedup": "true",
>>>>>>     "osd_map_cache_size": "500",
>>>>>>     "osd_map_message_max": "100",
>>>>>>     "osd_map_share_max_epochs": "100",
>>>>>>     "osd_op_threads": "2",
>>>>>>     "osd_peering_wq_batch_size": "20",
>>>>>>     "osd_op_pq_max_tokens_per_priority": "4194304",
>>>>>>     "osd_op_pq_min_cost": "65536",
>>>>>>     "osd_disk_threads": "1",
>>>>>>     "osd_recovery_threads": "2",
>>>>>>     "osd_recover_clone_overlap": "true",
>>>>>>     "osd_backfill_scan_min": "64",
>>>>>>     "osd_backfill_scan_max": "512",
>>>>>>     "osd_op_thread_timeout": "15",
>>>>>>     "osd_recovery_thread_timeout": "30",
>>>>>>     "osd_snap_trim_thread_timeout": "3600",
>>>>>>     "osd_scrub_thread_timeout": "60",
>>>>>>     "osd_scrub_finalize_thread_timeout": "600",
>>>>>>     "osd_remove_thread_timeout": "3600",
>>>>>>     "osd_command_thread_timeout": "600",
>>>>>>     "osd_age": "0.8",
>>>>>>     "osd_age_time": "0",
>>>>>>     "osd_heartbeat_addr": ":\/0",
>>>>>>     "osd_heartbeat_interval": "6",
>>>>>>     "osd_heartbeat_grace": "20",
>>>>>>     "osd_mon_heartbeat_interval": "30",
>>>>>>     "osd_mon_report_interval_max": "120",
>>>>>>     "osd_mon_report_interval_min": "5",
>>>>>>     "osd_pg_stat_report_interval_max": "500",
>>>>>>     "osd_mon_ack_timeout": "30",
>>>>>>     "osd_min_down_reporters": "1",
>>>>>>     "osd_min_down_reports": "3",
>>>>>>     "osd_default_data_pool_replay_window": "45",
>>>>>>     "osd_preserve_trimmed_log": "false",
>>>>>>     "osd_auto_mark_unfound_lost": "false",
>>>>>>     "osd_recovery_delay_start": "0",
>>>>>>     "osd_recovery_max_active": "5",
>>>>>>     "osd_recovery_max_chunk": "8388608",
>>>>>>     "osd_recovery_forget_lost_objects": "false",
>>>>>>     "osd_max_scrubs": "1",
>>>>>>     "osd_scrub_load_threshold": "0.5",
>>>>>>     "osd_scrub_min_interval": "86400",
>>>>>>     "osd_scrub_max_interval": "604800",
>>>>>>     "osd_deep_scrub_interval": "604800",
>>>>>>     "osd_deep_scrub_stride": "524288",
>>>>>>     "osd_scan_list_ping_tp_interval": "100",
>>>>>>     "osd_auto_weight": "false",
>>>>>>     "osd_class_dir": "\/usr\/lib\/rados-classes",
>>>>>>     "osd_check_for_log_corruption": "false",
>>>>>>     "osd_use_stale_snap": "false",
>>>>>>     "osd_rollback_to_cluster_snap": "",
>>>>>>     "osd_default_notify_timeout": "30",
>>>>>>     "osd_kill_backfill_at": "0",
>>>>>>     "osd_pg_epoch_persisted_max_stale": "200",
>>>>>>     "osd_min_pg_log_entries": "500",
>>>>>>     "osd_max_pg_log_entries": "1500",
>>>>>>     "osd_op_complaint_time": "30",
>>>>>>     "osd_command_max_records": "256",
>>>>>>     "osd_op_log_threshold": "5",
>>>>>>     "osd_verify_sparse_read_holes": "false",
>>>>>>     "osd_debug_drop_ping_probability": "0",
>>>>>>     "osd_debug_drop_ping_duration": "0",
>>>>>>     "osd_debug_drop_pg_create_probability": "0",
>>>>>>     "osd_debug_drop_pg_create_duration": "1",
>>>>>>     "osd_debug_drop_op_probability": "0",
>>>>>>     "osd_debug_op_order": "false",
>>>>>>     "osd_debug_verify_snaps_on_info": "false",
>>>>>>     "osd_debug_verify_stray_on_activate": "false",
>>>>>>     "osd_debug_skip_full_check_in_backfill_reservation": "false",
>>>>>>     "osd_op_history_size": "20",
>>>>>>     "osd_op_history_duration": "600",
>>>>>>     "osd_target_transaction_size": "30",
>>>>>>     "osd_failsafe_full_ratio": "0.97",
>>>>>>     "osd_failsafe_nearfull_ratio": "0.9",
>>>>>>     "osd_leveldb_write_buffer_size": "0",
>>>>>>     "osd_leveldb_cache_size": "0",
>>>>>>     "osd_leveldb_block_size": "0",
>>>>>>     "osd_leveldb_bloom_size": "0",
>>>>>>     "osd_leveldb_max_open_files": "0",
>>>>>>     "osd_leveldb_compression": "true",
>>>>>>     "osd_leveldb_paranoid": "false",
>>>>>>     "osd_leveldb_log": "",
>>>>>>     "osd_client_op_priority": "63",
>>>>>>     "osd_recovery_op_priority": "50",
>>>>>>     "osd_mon_shutdown_timeout": "5",
>>>>>>     "filestore": "false",
>>>>>>     "filestore_index_retry_probability": "0",
>>>>>>     "filestore_debug_inject_read_err": "false",
>>>>>>     "filestore_debug_omap_check": "false",
>>>>>>     "filestore_xattr_use_omap": "false",
>>>>>>     "filestore_max_inline_xattr_size": "512",
>>>>>>     "filestore_max_inline_xattrs": "2",
>>>>>>     "filestore_max_sync_interval": "5",
>>>>>>     "filestore_min_sync_interval": "0.01",
>>>>>>     "filestore_btrfs_snap": "true",
>>>>>>     "filestore_btrfs_clone_range": "true",
>>>>>>     "filestore_fsync_flushes_journal_data": "false",
>>>>>>     "filestore_fiemap": "false",
>>>>>>     "filestore_flusher": "true",
>>>>>>     "filestore_flusher_max_fds": "512",
>>>>>>     "filestore_flush_min": "65536",
>>>>>>     "filestore_sync_flush": "false",
>>>>>>     "filestore_journal_parallel": "false",
>>>>>>     "filestore_journal_writeahead": "false",
>>>>>>     "filestore_journal_trailing": "false",
>>>>>>     "filestore_queue_max_ops": "500",
>>>>>>     "filestore_queue_max_bytes": "104857600",
>>>>>>     "filestore_queue_committing_max_ops": "5000",
>>>>>>     "filestore_queue_committing_max_bytes": "104857600",
>>>>>>     "filestore_op_threads": "2",
>>>>>>     "filestore_op_thread_timeout": "60",
>>>>>>     "filestore_op_thread_suicide_timeout": "180",
>>>>>>     "filestore_commit_timeout": "600",
>>>>>>     "filestore_fiemap_threshold": "4096",
>>>>>>     "filestore_merge_threshold": "10",
>>>>>>     "filestore_split_multiple": "2",
>>>>>>     "filestore_update_to": "1000",
>>>>>>     "filestore_blackhole": "false",
>>>>>>     "filestore_dump_file": "",
>>>>>>     "filestore_kill_at": "0",
>>>>>>     "filestore_inject_stall": "0",
>>>>>>     "filestore_fail_eio": "true",
>>>>>>     "filestore_replica_fadvise": "true",
>>>>>>     "filestore_debug_verify_split": "false",
>>>>>>     "journal_dio": "true",
>>>>>>     "journal_aio": "true",
>>>>>>     "journal_force_aio": "false",
>>>>>>     "journal_max_corrupt_search": "10485760",
>>>>>>     "journal_block_align": "true",
>>>>>>     "journal_write_header_frequency": "0",
>>>>>>     "journal_max_write_bytes": "10485760",
>>>>>>     "journal_max_write_entries": "100",
>>>>>>     "journal_queue_max_ops": "300",
>>>>>>     "journal_queue_max_bytes": "33554432",
>>>>>>     "journal_align_min_size": "65536",
>>>>>>     "journal_replay_from": "0",
>>>>>>     "journal_zero_on_create": "false",
>>>>>>     "journal_ignore_corruption": "false",
>>>>>>     "rbd_cache": "false",
>>>>>>     "rbd_cache_writethrough_until_flush": "false",
>>>>>>     "rbd_cache_size": "33554432",
>>>>>>     "rbd_cache_max_dirty": "25165824",
>>>>>>     "rbd_cache_target_dirty": "16777216",
>>>>>>     "rbd_cache_max_dirty_age": "1",
>>>>>>     "rbd_cache_block_writes_upfront": "false",
>>>>>>     "rbd_concurrent_management_ops": "10",
>>>>>>     "rbd_default_format": "1",
>>>>>>     "rbd_default_order": "22",
>>>>>>     "rbd_default_stripe_count": "1",
>>>>>>     "rbd_default_stripe_unit": "4194304",
>>>>>>     "rbd_default_features": "3",
>>>>>>     "nss_db_path": "",
>>>>>>     "rgw_data": "\/var\/lib\/ceph\/radosgw\/ceph-0",
>>>>>>     "rgw_enable_apis": "s3, swift, swift_auth, admin",
>>>>>>     "rgw_cache_enabled": "true",
>>>>>>     "rgw_cache_lru_size": "10000",
>>>>>>     "rgw_socket_path": "",
>>>>>>     "rgw_host": "",
>>>>>>     "rgw_port": "",
>>>>>>     "rgw_dns_name": "",
>>>>>>     "rgw_script_uri": "",
>>>>>>     "rgw_request_uri": "",
>>>>>>     "rgw_swift_url": "",
>>>>>>     "rgw_swift_url_prefix": "swift",
>>>>>>     "rgw_swift_auth_url": "",
>>>>>>     "rgw_swift_auth_entry": "auth",
>>>>>>     "rgw_keystone_url": "",
>>>>>>     "rgw_keystone_admin_token": "",
>>>>>>     "rgw_keystone_accepted_roles": "Member, admin",
>>>>>>     "rgw_keystone_token_cache_size": "10000",
>>>>>>     "rgw_keystone_revocation_interval": "900",
>>>>>>     "rgw_admin_entry": "admin",
>>>>>>     "rgw_enforce_swift_acls": "true",
>>>>>>     "rgw_swift_token_expiration": "86400",
>>>>>>     "rgw_print_continue": "true",
>>>>>>     "rgw_remote_addr_param": "REMOTE_ADDR",
>>>>>>     "rgw_op_thread_timeout": "600",
>>>>>>     "rgw_op_thread_suicide_timeout": "0",
>>>>>>     "rgw_thread_pool_size": "100",
>>>>>>     "rgw_num_control_oids": "8",
>>>>>>     "rgw_zone_root_pool": ".rgw.root",
>>>>>>     "rgw_log_nonexistent_bucket": "false",
>>>>>>     "rgw_log_object_name": "%Y-%m-%d-%H-%i-%n",
>>>>>>     "rgw_log_object_name_utc": "false",
>>>>>>     "rgw_usage_max_shards": "32",
>>>>>>     "rgw_usage_max_user_shards": "1",
>>>>>>     "rgw_enable_ops_log": "false",
>>>>>>     "rgw_enable_usage_log": "false",
>>>>>>     "rgw_ops_log_rados": "true",
>>>>>>     "rgw_ops_log_socket_path": "",
>>>>>>     "rgw_ops_log_data_backlog": "5242880",
>>>>>>     "rgw_usage_log_flush_threshold": "1024",
>>>>>>     "rgw_usage_log_tick_interval": "30",
>>>>>>     "rgw_intent_log_object_name": "%Y-%m-%d-%i-%n",
>>>>>>     "rgw_intent_log_object_name_utc": "false",
>>>>>>     "rgw_init_timeout": "300",
>>>>>>     "rgw_mime_types_file": "\/etc\/mime.types",
>>>>>>     "rgw_gc_max_objs": "32",
>>>>>>     "rgw_gc_obj_min_wait": "7200",
>>>>>>     "rgw_gc_processor_max_time": "3600",
>>>>>>     "rgw_gc_processor_period": "3600",
>>>>>>     "rgw_s3_success_create_obj_status": "0",
>>>>>>     "rgw_resolve_cname": "false",
>>>>>>     "rgw_obj_stripe_size": "4194304",
>>>>>>     "rgw_extended_http_attrs": "",
>>>>>>     "rgw_exit_timeout_secs": "120",
>>>>>>     "rgw_get_obj_window_size": "16777216",
>>>>>>     "rgw_get_obj_max_req_size": "4194304",
>>>>>>     "rgw_relaxed_s3_bucket_names": "false",
>>>>>>     "rgw_list_buckets_max_chunk": "1000",
>>>>>>     "mutex_perf_counter": "false",
>>>>>>     "internal_safe_to_start_threads": "true"}
>>>>>>
>>>>>>
>>>>>>
>>>>>> Stefan
>>>>>>
>>>>>>
>>>>>>> -Sam
>>>>>>>
>>>>>>> On Thu, Aug 1, 2013 at 12:07 PM, Stefan Priebe
>>>>>>> <s.priebe@profihost.ag>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Mike we already have the async patch running. Yes it helps but only
>>>>>>>> helps
>>>>>>>> it
>>>>>>>> does not solve. It just hides the issue ...
>>>>>>>> Am 01.08.2013 20:54, schrieb Mike Dawson:
>>>>>>>>
>>>>>>>>> I am also seeing recovery issues with 0.61.7. Here's the process:
>>>>>>>>>
>>>>>>>>> - ceph osd set noout
>>>>>>>>>
>>>>>>>>> - Reboot one of the nodes hosting OSDs
>>>>>>>>>         - VMs mounted from RBD volumes work properly
>>>>>>>>>
>>>>>>>>> - I see the OSD's boot messages as they re-join the cluster
>>>>>>>>>
>>>>>>>>> - Start seeing active+recovery_wait, peering, and
>>>>>>>>> active+recovering
>>>>>>>>>         - VMs mounted from RBD volumes become unresponsive.
>>>>>>>>>
>>>>>>>>> - Recovery completes
>>>>>>>>>         - VMs mounted from RBD volumes regain responsiveness
>>>>>>>>>
>>>>>>>>> - ceph osd unset noout
>>>>>>>>>
>>>>>>>>> Would joshd's async patch for qemu help here, or is there
>>>>>>>>> something
>>>>>>>>> else
>>>>>>>>> going on?
>>>>>>>>>
>>>>>>>>> Output of ceph -w at: http://pastebin.com/raw.php?i=JLcZYFzY
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>> Mike Dawson
>>>>>>>>> Co-Founder & Director of Cloud Architecture
>>>>>>>>> Cloudapt LLC
>>>>>>>>> 6330 East 75th Street, Suite 170
>>>>>>>>> Indianapolis, IN 46250
>>>>>>>>>
>>>>>>>>> On 8/1/2013 2:34 PM, Samuel Just wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Can you reproduce and attach the ceph.log from before you stop
>>>>>>>>>> the
>>>>>>>>>> osd
>>>>>>>>>> until after you have started the osd and it has recovered?
>>>>>>>>>> -Sam
>>>>>>>>>>
>>>>>>>>>> On Thu, Aug 1, 2013 at 1:22 AM, Stefan Priebe - Profihost AG
>>>>>>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> i still have recovery issues with cuttlefish. After the OSD
>>>>>>>>>>> comes
>>>>>>>>>>> back
>>>>>>>>>>> it seem to hang for around 2-4 minutes and then recovery
>>>>>>>>>>> seems to
>>>>>>>>>>> start
>>>>>>>>>>> (pgs in recovery_wait start to decrement). This is with ceph
>>>>>>>>>>> 0.61.7.
>>>>>>>>>>> I
>>>>>>>>>>> get a lot of slow request messages an hanging VMs.
>>>>>>>>>>>
>>>>>>>>>>> What i noticed today is that if i leave the OSD off as long as
>>>>>>>>>>> ceph
>>>>>>>>>>> starts to backfill - the recovery and "re" backfilling wents
>>>>>>>>>>> absolutely
>>>>>>>>>>> smooth without any issues and no slow request messages at all.
>>>>>>>>>>>
>>>>>>>>>>> Does anybody have an idea why?
>>>>>>>>>>>
>>>>>>>>>>> Greets,
>>>>>>>>>>> Stefan
>>>>>>>>>>> --
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>>> ceph-devel"
>>>>>>>>>>> in
>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>> More majordomo info at
>>>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>> ceph-devel"
>>>>>>>>>> in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at
>>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>
>>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>> ceph-devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>>>
>>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
