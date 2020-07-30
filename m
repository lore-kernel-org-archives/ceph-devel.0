From: Frank Yu <flyxiaoyu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [nautilus][mds] MDS fall into ReadOnly mode
Date: Thu, 30 Jul 2020 18:55:17 +0800
Message-ID: <CAKXD-H7ZGqkBSYKCaCa26HuugaQn51NGgCsOw1GEHq_3SZYUCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi guys,

I have a ceph cluster with three MDS servers, two of them in active status,
while the left one is in standby-replay mode. Today I found the message '1
MDSs are read only' show up when check the cluster status with 'ceph -s',
details as below:

# ceph -s
  cluster:
    id:     3d43e9a5-50dc-4f84-9493-656bf4f06f8c
    health: HEALTH_WARN
            5 clients failing to advance oldest client/flush tid
            1 MDSs are read only
            2 MDSs report slow requests
            2 MDSs behind on trimming
            BlueFS spillover detected on 33 OSD(s)

  services:
    mon: 3 daemons, quorum bjcpu-001,bjcpu-002,bjcpu-003 (age 3M)
    mgr: bjcpu-001.xxxx.io(active, since 3M), standbys: bjcpu-003.xxxx.io,
bjcpu-002.xxxx.io
    mds: cephfs:2 {0=bjcpu-003.xxxx.io=up:active,1=bjcpu-001.xxxx.io=up:active}
1 up:standby-replay
    osd: 48 osds: 48 up (since 7w), 48 in (since 7M)

  data:
    pools:   3 pools, 2304 pgs
    objects: 301.35M objects, 70 TiB
    usage:   246 TiB used, 280 TiB / 527 TiB avail
    pgs:     2295 active+clean
             9    active+clean+scrubbing+deep

  io:
    client:   254 B/s rd, 44 MiB/s wr, 0 op/s rd, 15 op/s wr

What should I do to fix the error message? it seems the cluster still works
fine(can read and write).

Many thanks


-- 
Regards
Frank Yu
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
