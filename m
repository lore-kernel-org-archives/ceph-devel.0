From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v2 0/8] ceph: add perf metrics support
Date: Wed, 8 Jan 2020 18:46:41 +0800
Message-ID: <72665b33-8858-dca9-e9bd-5163e29c9fc3@redhat.com>
References: <20200108104152.28468-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38160 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbgAHKq6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jan 2020 05:46:58 -0500
In-Reply-To: <20200108104152.28468-1-xiubli@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

Additional info for provided metric flags in client metadata

$./bin/cephfs-journal-tool --rank=3D1:0 event get --type=3DSESSION json
Wrote output to JSON file 'dump'
$ cat dump
[
 =C2=A0=C2=A0=C2=A0 {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "client instance": "client.42=
75 v1:192.168.195.165:0/461391971",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "open": "true",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "client map version": 1,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "inos": "[]",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "inotable version": 0,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "client_metadata": {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clie=
nt_features": {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "feature_bits": "0000000000001bff"
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "metr=
ic_spec": {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "metric_flags": {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "feature_bits": "0000000000000=
01f" <<=3D=3D=3D=3D=3D metric=20
flags provided by kclient
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "enti=
ty_id": "",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "host=
name": "fedora1",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "kern=
el_version": "5.5.0-rc2+",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "root=
": "/"
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 },
[...]


On 2020/1/8 18:41, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> Changed in V2:
> - add read/write/metadata latency metric support.
> - add and send client provided metric flags in client metadata
> - addressed the comments from Ilya and merged the 4/4 patch into 3/4.
> - addressed all the other comments in v1 series.
>
> In this version it will send the metrics to the MDSs every second if
> sending_metrics is enabled, disable as default.
>
>
>
> We can get the metrics from the debugfs:
>
> $ cat /sys/kernel/debug/ceph/0c93a60d-5645-4c46-8568-4c8f63db4c7f.clien=
t4267/metrics
> item          total       sum_lat(us)     avg_lat(us)
> -----------------------------------------------------
> read          13          417000          32076
> write         42          131205000       3123928
> metadata      104         493000          4740
>
> item          total           miss            hit
> -------------------------------------------------
> d_lease       204             0               918
>
> session       caps            miss            hit
> -------------------------------------------------
> 0             204             213             368218
>
>
> In the MDS side, we can get the metrics(NOTE: the latency is in
> nanosecond):
>
> $ ./bin/ceph fs perf stats | python -m json.tool
> {
>      "client_metadata": {
>          "client.4267": {
>              "IP": "v1:192.168.195.165",
>              "hostname": "fedora1",
>              "mount_point": "N/A",
>              "root": "/"
>          }
>      },
>      "counters": [
>          "cap_hit"
>      ],
>      "global_counters": [
>          "read_latency",
>          "write_latency",
>          "metadata_latency",
>          "dentry_lease_hit"
>      ],
>      "global_metrics": {
>          "client.4267": [
>              [
>                  0,
>                  32076923
>              ],
>              [
>                  3,
>                  123928571
>              ],
>              [
>                  0,
>                  4740384
>              ],
>              [
>                  918,
>                  0
>              ]
>          ]
>      },
>      "metrics": {
>          "delayed_ranks": [],
>          "mds.0": {
>              "client.4267": [
>                  [
>                      368218,
>                      213
>                  ]
>              ]
>          }
>      }
> }
>
>
>
> Xiubo Li (8):
>    ceph: add global dentry lease metric support
>    ceph: add caps perf metric for each session
>    ceph: add global read latency metric support
>    ceph: add global write latency metric support
>    ceph: add global metadata perf metric support
>    ceph: periodically send perf metrics to MDS
>    ceph: add reset metrics support
>    ceph: send client provided metric flags in client metadata
>
>   fs/ceph/acl.c                   |   2 +-
>   fs/ceph/addr.c                  |  38 +++-
>   fs/ceph/caps.c                  |  63 ++++--
>   fs/ceph/debugfs.c               | 182 +++++++++++++++-
>   fs/ceph/dir.c                   |  38 +++-
>   fs/ceph/file.c                  |  26 ++-
>   fs/ceph/inode.c                 |   8 +-
>   fs/ceph/mds_client.c            | 369 ++++++++++++++++++++++++++++++-=
-
>   fs/ceph/mds_client.h            |  48 +++++
>   fs/ceph/snap.c                  |   2 +-
>   fs/ceph/super.h                 |  15 +-
>   fs/ceph/xattr.c                 |   8 +-
>   include/linux/ceph/ceph_fs.h    |  77 +++++++
>   include/linux/ceph/osd_client.h |   5 +-
>   net/ceph/osd_client.c           |  18 +-
>   15 files changed, 826 insertions(+), 73 deletions(-)
>
