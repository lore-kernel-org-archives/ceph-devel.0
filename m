From: Dong Wu <archer.wudong@gmail.com>
Subject: Fwd: Fwd: [ceph-users] Hammer OSD memory increase when add new machine
Date: Wed, 9 Nov 2016 11:16:15 +0800
Message-ID: <CAAL-TMfQ36RzOZUG+Wy9ayc3Odc_w5bbysrUeRcFB3a6KUTLzQ@mail.gmail.com>
References: <CAAL-TMfWddz2x7GzTghoJzp=_=d-OwtVa7fxvt8aD-rFCUqiWg@mail.gmail.com>
 <CAAL-TMdf-8Q9nd1px+VqFeQtVjg=vX6or4Xv0X3YW=-OzkNKgQ@mail.gmail.com>
 <alpine.DEB.2.11.1611081407100.29278@piezo.us.to> <CAAL-TMfLMaXqwZ9u+64twxmtZGyxn8jOW1T8YH6ZRyrue=e1Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:34723 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcKIDQR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 22:16:17 -0500
Received: by mail-ua0-f169.google.com with SMTP id 51so163800082uai.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 19:16:17 -0800 (PST)
In-Reply-To: <CAAL-TMfLMaXqwZ9u+64twxmtZGyxn8jOW1T8YH6ZRyrue=e1Fw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

---------- Forwarded message ----------
From: Dong Wu <archer.wudong@gmail.com>
Date: 2016-11-09 11:14 GMT+08:00
Subject: Re: Fwd: [ceph-users] Hammer OSD memory increase when add new mach=
ine
To: Sage Weil <sage@newdream.net>


2016-11-08 22:08 GMT+08:00 Sage Weil <sage@newdream.net>:
>> ---------- Forwarded message ----------
>> From: Dong Wu <archer.wudong@gmail.com>
>> Date: 2016-10-27 18:50 GMT+08:00
>> Subject: Re: [ceph-users] Hammer OSD memory increase when add new machin=
e
>> To: huang jun <hjwsm1989@gmail.com>
>> =E6=8A=84=E9=80=81=EF=BC=9A ceph-users <ceph-users@lists.ceph.com>
>>
>>
>> 2016-10-27 17:50 GMT+08:00 huang jun <hjwsm1989@gmail.com>:
>> > how do you add the new machine ?
>> > does it first added to default ruleset and then you add the new rule
>> > for this group?
>> > do you have data pool use the default rule, does these pool contain da=
ta?
>>
>> we dont use default ruleset, when we add new group machine,
>> crush_location auto generate root and chassis, then we add a new rule
>> for this group.
>>
>>
>> > 2016-10-27 17:34 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
>> >> Hi all,
>> >>
>> >> We have a ceph cluster only use rbd. The cluster contains several
>> >> group machines, each group contains several machines, then each
>> >> machine has 12 SSDs, each ssd as an OSD (journal and data together).
>> >> eg:
>> >> group1: machine1~machine12
>> >> group2: machine13~machine24
>> >> ......
>> >> each group is separated with other group, which means each group has
>> >> separated pools.
>> >>
>> >> we use Hammer(0.94.6) compiled with jemalloc(4.2).
>> >>
>> >> We have found that when we add a new group machine, the other group
>> >> machine's memory increase 5% more or less (OSDs usage).
>> >>
>> >> each group's data is separated with others, so backfill only in group=
,
>> >> not across.
>> >> Why add a group of machine cause others memory increase? Is this reas=
onable?
>
> It could be cached OSDmaps (they get slightly larger when you add OSDs)
> but it's hard to say.  It seems more likely that the pools and crush rule=
s
> aren't configured right and you're adding OSDs to the wrong group.

I'm sure we don't adding OSDs to the wrong group, so I'll check
whether the cached OSDmaps cause 5% memory increase.

> If you look at the 'ceph daemon osd.NNN perf dump' output you can see,
> among other things, how many PGs are on the OSD.

Here is one of my osd's perf dump:
{
    "WBThrottle": {
        "bytes_dirtied": 0,
        "bytes_wb": 0,
        "ios_dirtied": 0,
        "ios_wb": 0,
        "inodes_dirtied": 0,
        "inodes_wb": 0
    },
    "filestore": {
        "journal_queue_max_ops": 300,
        "journal_queue_ops": 0,
        "journal_ops": 29571,
        "journal_queue_max_bytes": 33554432,
        "journal_queue_bytes": 0,
        "journal_bytes": 7997292079,
        "journal_latency": {
            "avgcount": 29571,
            "sum": 41.510506649
        },
        "journal_wr": 23836,
        "journal_wr_bytes": {
            "avgcount": 23836,
            "sum": 8131936256
        },
        "journal_full": 0,
        "committing": 0,
        "commitcycle": 11428,
        "commitcycle_interval": {
            "avgcount": 11428,
            "sum": 57177.881514939
        },
        "commitcycle_latency": {
            "avgcount": 11428,
            "sum": 37.167420754
        },
        "op_queue_max_ops": 50,
        "op_queue_ops": 0,
        "ops": 29571,
        "op_queue_max_bytes": 104857600,
        "op_queue_bytes": 0,
        "bytes": 7996878085,
        "apply_latency": {
            "avgcount": 29571,
            "sum": 72.631955250
        },
        "queue_transaction_latency_avg": {
            "avgcount": 29571,
            "sum": 0.612424041
        }
    },
    "leveldb": {
        "leveldb_get": 12793,
        "leveldb_transaction": 16101,
        "leveldb_compact": 0,
        "leveldb_compact_range": 0,
        "leveldb_compact_queue_merge": 0,
        "leveldb_compact_queue_len": 0
    },
    "mutex-FileJournal::completions_lock": {
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "mutex-FileJournal::finisher_lock": {
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "mutex-FileJournal::write_lock": {
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "mutex-FileJournal::writeq_lock": {
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "mutex-JOS::ApplyManager::apply_lock": {
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "mutex-JOS::ApplyManager::com_lock": {
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "mutex-JOS::SubmitManager::lock": {
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "mutex-WBThrottle::lock": {
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "objecter": {
        "op_active": 0,
        "op_laggy": 0,
        "op_send": 0,
        "op_send_bytes": 0,
        "op_resend": 0,
        "op_ack": 0,
        "op_commit": 0,
        "op": 0,
        "op_r": 0,
        "op_w": 0,
        "op_rmw": 0,
        "op_pg": 0,
        "osdop_stat": 0,
        "osdop_create": 0,
        "osdop_read": 0,
        "osdop_write": 0,
        "osdop_writefull": 0,
        "osdop_append": 0,
        "osdop_zero": 0,
        "osdop_truncate": 0,
        "osdop_delete": 0,
        "osdop_mapext": 0,
        "osdop_sparse_read": 0,
        "osdop_clonerange": 0,
        "osdop_getxattr": 0,
        "osdop_setxattr": 0,
        "osdop_cmpxattr": 0,
        "osdop_rmxattr": 0,
        "osdop_resetxattrs": 0,
        "osdop_tmap_up": 0,
        "osdop_tmap_put": 0,
        "osdop_tmap_get": 0,
        "osdop_call": 0,
        "osdop_watch": 0,
        "osdop_notify": 0,
        "osdop_src_cmpxattr": 0,
        "osdop_pgls": 0,
        "osdop_pgls_filter": 0,
        "osdop_other": 0,
        "linger_active": 0,
        "linger_send": 0,
        "linger_resend": 0,
        "linger_ping": 0,
        "poolop_active": 0,
        "poolop_send": 0,
        "poolop_resend": 0,
        "poolstat_active": 0,
        "poolstat_send": 0,
        "poolstat_resend": 0,
        "statfs_active": 0,
        "statfs_send": 0,
        "statfs_resend": 0,
        "command_active": 0,
        "command_send": 0,
        "command_resend": 0,
        "map_epoch": 23508,
        "map_full": 0,
        "map_inc": 13944,
        "osd_sessions": 0,
        "osd_session_open": 0,
        "osd_session_close": 0,
        "osd_laggy": 0
    },
    "osd": {
        "op_wip": 0,
        "op": 0,
        "op_in_bytes": 0,
        "op_out_bytes": 0,
        "op_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "op_process_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "op_r": 0,
        "op_r_out_bytes": 0,
        "op_r_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "op_r_process_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "op_w": 0,
        "op_w_in_bytes": 0,
        "op_w_rlat": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "op_w_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "op_w_process_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "op_rw": 0,
        "op_rw_in_bytes": 0,
        "op_rw_out_bytes": 0,
        "op_rw_rlat": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "op_rw_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "op_rw_process_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "subop": 0,
        "subop_in_bytes": 0,
        "subop_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "subop_w": 0,
        "subop_w_in_bytes": 0,
        "subop_w_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "subop_pull": 0,
        "subop_pull_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "subop_push": 0,
        "subop_push_in_bytes": 0,
        "subop_push_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "pull": 0,
        "push": 0,
        "push_out_bytes": 0,
        "push_in": 0,
        "push_in_bytes": 0,
        "recovery_ops": 0,
        "loadavg": 123,
        "buffer_bytes": 0,
        "numpg": 124,
        "numpg_primary": 45,
        "numpg_replica": 79,
        "numpg_stray": 0,
        "heartbeat_to_peers": 54,
        "heartbeat_from_peers": 0,
        "map_messages": 64201,
        "map_message_epochs": 64876,
        "map_message_epoch_dups": 51257,
        "messages_delayed_for_map": 0,
        "stat_bytes": 788411367424,
        "stat_bytes_used": 5702975488,
        "stat_bytes_avail": 782708391936,
        "copyfrom": 0,
        "tier_promote": 0,
        "tier_flush": 0,
        "tier_flush_fail": 0,
        "tier_try_flush": 0,
        "tier_try_flush_fail": 0,
        "tier_evict": 0,
        "tier_whiteout": 0,
        "tier_dirty": 0,
        "tier_clean": 0,
        "tier_delay": 0,
        "tier_proxy_read": 0,
        "agent_wake": 0,
        "agent_skip": 0,
        "agent_flush": 0,
        "agent_evict": 0,
        "object_ctx_cache_hit": 0,
        "object_ctx_cache_total": 532
    },
    "recoverystate_perf": {
        "initial_latency": {
            "avgcount": 124,
            "sum": 0.029587197
        },
        "started_latency": {
            "avgcount": 408,
            "sum": 270724868.452214455
        },
        "reset_latency": {
            "avgcount": 532,
            "sum": 0.046226936
        },
        "start_latency": {
            "avgcount": 532,
            "sum": 0.019358541
        },
        "primary_latency": {
            "avgcount": 168,
            "sum": 94632238.321256675
        },
        "peering_latency": {
            "avgcount": 213,
            "sum": 209.700529539
        },
        "backfilling_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "waitremotebackfillreserved_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "waitlocalbackfillreserved_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "notbackfilling_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "repnotrecovering_latency": {
            "avgcount": 240,
            "sum": 176092468.246603209
        },
        "repwaitrecoveryreserved_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "repwaitbackfillreserved_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "RepRecovering_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "activating_latency": {
            "avgcount": 213,
            "sum": 6.094189814
        },
        "waitlocalrecoveryreserved_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "waitremoterecoveryreserved_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "recovering_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "recovered_latency": {
            "avgcount": 213,
            "sum": 0.005857072
        },
        "clean_latency": {
            "avgcount": 168,
            "sum": 94632068.725193329
        },
        "active_latency": {
            "avgcount": 168,
            "sum": 94632073.698045579
        },
        "replicaactive_latency": {
            "avgcount": 240,
            "sum": 176092468.253890532
        },
        "stray_latency": {
            "avgcount": 319,
            "sum": 241.362531889
        },
        "getinfo_latency": {
            "avgcount": 213,
            "sum": 5.952202080
        },
        "getlog_latency": {
            "avgcount": 213,
            "sum": 0.043122217
        },
        "waitactingchange_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "incomplete_latency": {
            "avgcount": 0,
            "sum": 0.000000000
        },
        "getmissing_latency": {
            "avgcount": 213,
            "sum": 0.007089986
        },
        "waitupthru_latency": {
            "avgcount": 213,
            "sum": 203.690927646
        }
    },
    "throttle-filestore_bytes": {
        "val": 0,
        "max": 33554432,
        "get": 0,
        "get_sum": 0,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 29571,
        "take_sum": 7997292079,
        "put": 23835,
        "put_sum": 7997292079,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-filestore_ops": {
        "val": 0,
        "max": 300,
        "get": 0,
        "get_sum": 0,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 29571,
        "take_sum": 29571,
        "put": 23835,
        "put_sum": 29571,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-msgr_dispatch_throttler-client": {
        "val": 0,
        "max": 104857600,
        "get": 78386,
        "get_sum": 1785569,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 78386,
        "put_sum": 1785569,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-msgr_dispatch_throttler-cluster": {
        "val": 0,
        "max": 104857600,
        "get": 89377,
        "get_sum": 114403326,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 89377,
        "put_sum": 114403326,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-msgr_dispatch_throttler-hb_back_server": {
        "val": 0,
        "max": 104857600,
        "get": 194417133,
        "get_sum": 9137605251,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 194417133,
        "put_sum": 9137605251,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-msgr_dispatch_throttler-hb_front_server": {
        "val": 0,
        "max": 104857600,
        "get": 194417133,
        "get_sum": 9137605251,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 194417133,
        "put_sum": 9137605251,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-msgr_dispatch_throttler-hbclient": {
        "val": 0,
        "max": 104857600,
        "get": 385828720,
        "get_sum": 18133949840,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 385828720,
        "put_sum": 18133949840,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-msgr_dispatch_throttler-ms_objecter": {
        "val": 0,
        "max": 104857600,
        "get": 0,
        "get_sum": 0,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 0,
        "put_sum": 0,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-objecter_bytes": {
        "val": 0,
        "max": 104857600,
        "get": 0,
        "get_sum": 0,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 0,
        "put_sum": 0,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-objecter_ops": {
        "val": 0,
        "max": 1024,
        "get": 0,
        "get_sum": 0,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 0,
        "put_sum": 0,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-osd_client_bytes": {
        "val": 0,
        "max": 524288000,
        "get": 268,
        "get_sum": 53091,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 268,
        "put_sum": 53091,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    },
    "throttle-osd_client_messages": {
        "val": 0,
        "max": 100,
        "get": 268,
        "get_sum": 268,
        "get_or_fail_fail": 0,
        "get_or_fail_success": 0,
        "take": 0,
        "take_sum": 0,
        "put": 268,
        "put_sum": 268,
        "wait": {
            "avgcount": 0,
            "sum": 0.000000000
        }
    }
}

on average, my osd has 120~180 PGs.

> Can you capture the
> output before and after the change (and 5% memory footprint increase)?
>

because this problem first found in our product invironment, next time
we add another group machine, I'll capture the output before and after
the change.
And alse I'll try to reproduce in another invironment and get some clue.

> sage
