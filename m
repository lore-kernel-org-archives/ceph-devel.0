From: xiubli@redhat.com
Subject: [PATCH v6 0/9] ceph: add perf metrics support
Date: Mon, 10 Feb 2020 00:33:58 -0500
Message-ID: <20200210053407.37237-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57068 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgBJFeY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:34:24 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Changed in V6:
- fold r_end_stamp patch to its first user
- remove some parameters' declartion which are only used once
- switch debugfs sending_metric UI to a module parameter
- make the cap hit/mis metric as global per superblock
- some other small fixes

It will send the metrics to ceph cluster per metric_send_interval seconds
if enabled, metric_send_interval is a module parameter and default value
is 0, 0 also means disabled.


We can get the metrics from the debugfs:

$ cat /sys/kernel/debug/ceph/0c93a60d-5645-4c46-8568-4c8f63db4c7f.client4=
267/metrics=20
item          total       sum_lat(us)     avg_lat(us)
-----------------------------------------------------
read          13          417000          32076
write         42          131205000       3123928
metadata      104         493000          4740

item          total           miss            hit
-------------------------------------------------
d_lease       204             0               918
caps          204             213             368218


In the MDS side, we can get the metrics(NOTE: the latency is in
nanosecond):

$ ./bin/ceph fs perf stats | python -m json.tool
{
    "client_metadata": {
        "client.4267": {
            "IP": "v1:192.168.195.165",
            "hostname": "fedora1",
            "mount_point": "N/A",
            "root": "/"
        }
    },
    "counters": [
        "cap_hit"
    ],
    "global_counters": [
        "read_latency",
        "write_latency",
        "metadata_latency",
        "dentry_lease_hit"
    ],
    "global_metrics": {
        "client.4267": [
            [
                0,
                32076923
            ],
            [
                3,
                123928571
            ],
            [
                0,
                4740384
            ],
            [
                918,
                0
            ]
        ]
    },
    "metrics": {
        "delayed_ranks": [],
        "mds.0": {
            "client.4267": [
                [
                    368218,
                    213
                ]
            ]
        }
    }
}


The provided metric flags in client metadata

$./bin/cephfs-journal-tool --rank=3D1:0 event get --type=3DSESSION json
Wrote output to JSON file 'dump'
$ cat dump
[=20
    {
        "client instance": "client.4275 v1:192.168.195.165:0/461391971",
        "open": "true",
        "client map version": 1,
        "inos": "[]",
        "inotable version": 0,
        "client_metadata": {
            "client_features": {
                "feature_bits": "0000000000001bff"
            },
            "metric_spec": {
                "metric_flags": {
                    "feature_bits": "000000000000001f"
                }
            },
            "entity_id": "",
            "hostname": "fedora1",
            "kernel_version": "5.5.0-rc2+",
            "root": "/"
        }
    },
[...]





Xiubo Li (9):
  ceph: add global dentry lease metric support
  ceph: add caps perf metric for each session
  ceph: add global read latency metric support
  ceph: add global write latency metric support
  ceph: add global metadata perf metric support
  ceph: periodically send perf metrics to ceph
  ceph: add CEPH_DEFINE_RW_FUNC helper support
  ceph: add reset metrics support
  ceph: send client provided metric flags in client metadata

 fs/ceph/acl.c                   |   2 +
 fs/ceph/addr.c                  |  13 ++
 fs/ceph/caps.c                  |  29 +++
 fs/ceph/debugfs.c               | 107 ++++++++-
 fs/ceph/dir.c                   |  25 ++-
 fs/ceph/file.c                  |  22 ++
 fs/ceph/mds_client.c            | 381 +++++++++++++++++++++++++++++---
 fs/ceph/mds_client.h            |   6 +
 fs/ceph/metric.h                | 155 +++++++++++++
 fs/ceph/quota.c                 |   9 +-
 fs/ceph/super.c                 |   4 +
 fs/ceph/super.h                 |  11 +
 fs/ceph/xattr.c                 |  17 +-
 include/linux/ceph/ceph_fs.h    |   1 +
 include/linux/ceph/debugfs.h    |  14 ++
 include/linux/ceph/osd_client.h |   1 +
 net/ceph/osd_client.c           |   2 +
 17 files changed, 759 insertions(+), 40 deletions(-)
 create mode 100644 fs/ceph/metric.h

--=20
2.21.0
