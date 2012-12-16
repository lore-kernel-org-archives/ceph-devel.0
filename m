From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Empty directory size greater than zero and can't remove
Date: Sun, 16 Dec 2012 10:04:18 +0800
Message-ID: <CAJiejCRi8QOfQB5Y0rN5vQz-xiTeA1SKdku=8Xa_+3CZAjysLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48954 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab2LPCEk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 21:04:40 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3271548pad.19
        for <ceph-devel@vger.kernel.org>; Sat, 15 Dec 2012 18:04:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux <ceph-devel@vger.kernel.org>

I couldn't rm files in ceph, which was backuped files of one osd. It
reports direcory not empty, but there's nothing under that directory,
just the directory itself held some spaces. How could I shoot down the
problem ?

log30 /mnt/bc # ls -aR osd.28/
osd.28/:
=2E  ..  osd.28

osd.28/osd.28:
=2E  ..  current

osd.28/osd.28/current:
=2E  ..  0.537_head

osd.28/osd.28/current/0.537_head:
=2E  ..
log30 /mnt/bc # ls -lhd osd.28/osd.28/current/0.537_head
drwxr-xr-x 1 root root 119M Dec 14 19:22 osd.28/osd.28/current/0.537_he=
ad
log30 /mnt/bc #
log30 /mnt/bc # rm -rf osd.28/
rm: cannot remove =E2=80=98osd.28/osd.28/current/0.537_head=E2=80=99: D=
irectory not empty
log30 /mnt/bc # rm -rf osd.28/osd.28/current/0.537_head
rm: cannot remove =E2=80=98osd.28/osd.28/current/0.537_head=E2=80=99: D=
irectory not empty

The cluster seems health:
log3 ~ # ceph -s
   health HEALTH_OK
   monmap e1: 3 mons at
{log21=3D10.205.118.21:6789/0,log3=3D10.205.119.2:6789/0,squid86-log12=3D=
150.164.100.218:6789/0},
election epoch 640, quorum 0,1,2 log21,log3,squid86-log12
   osdmap e1864: 45 osds: 45 up, 45 in
    pgmap v163907: 9224 pgs: 9224 active+clean; 3168 GB data, 9565 GB
used, 111 TB / 120 TB avail
   mdsmap e134: 1/1/1 up {0=3Dlog14=3Dup:active}, 1 up:standby

And this is the pgid info mentioned above:
log3 ~ # ceph pg 0.537 query
{ "state": "active+clean",
  "up": [
        11,
        28,
        33],
  "acting": [
        11,
        28,
        33],
  "info": { "pgid": "0.537",
      "last_update": "1864'546",
      "last_complete": "1864'546",
      "log_tail": "0'0",
      "last_backfill": "MAX",
      "purged_snaps": "[]",
      "history": { "epoch_created": 1,
          "last_epoch_started": 1740,
          "last_epoch_clean": 1774,
          "last_epoch_split": 1524,
          "same_up_since": 1738,
          "same_interval_since": 1738,
          "same_primary_since": 1523,
          "last_scrub": "1864'546",
          "last_scrub_stamp": "2012-12-16 04:26:16.037585"},
      "stats": { "version": "1864'546",
          "reported": "1523'3018",
          "state": "active+clean",
          "last_fresh": "2012-12-16 04:26:16.037742",
          "last_change": "2012-12-16 04:26:16.037742",
          "last_active": "2012-12-16 04:26:16.037742",
          "last_clean": "2012-12-16 04:26:16.037742",
          "last_unstale": "2012-12-16 04:26:16.037742",
          "mapping_epoch": 1523,
          "log_start": "0'0",
          "ondisk_log_start": "0'0",
          "created": 1,
          "last_epoch_clean": 1,
          "parent": "0.0",
          "parent_split_bits": 0,
          "last_scrub": "1864'546",
          "last_scrub_stamp": "2012-12-16 04:26:16.037585",
          "log_size": 74256,
          "ondisk_log_size": 74256,
          "stat_sum": { "num_bytes": 1708739453,
              "num_objects": 428,
              "num_object_clones": 0,
              "num_object_copies": 0,
              "num_objects_missing_on_primary": 0,
              "num_objects_degraded": 0,
              "num_objects_unfound": 0,
              "num_read": 0,
              "num_read_kb": 0,
              "num_write": 546,
              "num_write_kb": 1889873},
          "stat_cat_sum": {},
          "up": [
                11,
                28,
                33],
          "acting": [
                11,
                28,
                33]},
      "empty": 0,
      "dne": 0,
      "incomplete": 0},
  "recovery_state": [
        { "name": "Started\/Primary\/Active",
          "enter_time": "2012-12-14 11:03:28.545423",
          "might_have_unfound": [],
          "recovery_progress": { "backfill_target": -1,
              "waiting_on_backfill": 0,
              "backfill_pos": "0\/\/0\/\/-1",
              "backfill_info": { "begin": "0\/\/0\/\/-1",
                  "end": "0\/\/0\/\/-1",
                  "objects": []},
              "peer_backfill_info": { "begin": "0\/\/0\/\/-1",
                  "end": "0\/\/0\/\/-1",
                  "objects": []},
              "backfills_in_flight": [],
              "pull_from_peer": [],
              "pushing": []},
          "scrub": { "scrub_epoch_start": "1738",
              "scrub_active": 0,
              "scrub_block_writes": 0,
              "finalizing_scrub": 0,
              "scrub_waiting_on": 0,
              "scrub_waiting_on_whom": []}},
        { "name": "Started",
          "enter_time": "2012-12-14 11:03:27.525077"}]}
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
