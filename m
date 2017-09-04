From: John Spray <jspray@redhat.com>
Subject: Re: luminous filesystem is degraded
Date: Mon, 4 Sep 2017 10:05:43 +0100
Message-ID: <CALe9h7f48vWZ1g6WtonOKfy9DowGGnJbBK12prfA7YjrWXUkhw@mail.gmail.com>
References: <CAKRxpusdzy+k=v8nhvfW9Y_zciHYOZSo9U8HNvFovAAnH-eGzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36576 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbdIDJGF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Sep 2017 05:06:05 -0400
Received: by mail-wr0-f181.google.com with SMTP id p14so12981397wrg.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 Sep 2017 02:06:04 -0700 (PDT)
In-Reply-To: <CAKRxpusdzy+k=v8nhvfW9Y_zciHYOZSo9U8HNvFovAAnH-eGzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Sep 3, 2017 at 2:14 PM, Two Spirit <twospirit6905@gmail.com> wrote:
> Setup: luminous on
> Ubuntu 14.04/16.04 mix. 5 OSD. all up. 3 or 4 mds, 3mon,cephx
> rebooting all 6 ceph systems did not clear the problem. Failure
> occurred within 6 hours of start of test.
> similar stress test with 4OSD,1MDS,1MON,cephx worked fine.
>
>
> stress test
> # cp * /mnt/cephfs
>
> # ceph -s
>     health: HEALTH_WARN
>             1 filesystem is degraded
>             crush map has straw_calc_version=0
>             1/731529 unfound (0.000%)
>             Degraded data redundancy: 22519/1463058 objects degraded
> (1.539%), 2 pgs unclean, 2 pgs degraded, 1 pg undersized
>
>   services:
>     mon: 3 daemons, quorum xxx233,xxx266,xxx272
>     mgr: xxx266(active)
>     mds: cephfs-1/1/1 up  {0=xxx233=up:replay}, 3 up:standby
>     osd: 5 osds: 5 up, 5 in
>     rgw: 1 daemon active

Your MDS is probably stuck in the replay state because it can't read
from one of your degraded PGs.  Given that you have all your OSDs in,
but one of your PGs is undersized (i.e. is short on OSDs), I would
guess that something is wrong with your choice of CRUSH rules or EC
config.

John

>
> # ceph mds dump
> dumped fsmap epoch 590
> fs_name cephfs
> epoch   589
> flags   c
> created 2017-08-24 14:35:33.735399
> modified        2017-08-24 14:35:33.735400
> tableserver     0
> root    0
> session_timeout 60
> session_autoclose       300
> max_file_size   1099511627776
> last_failure    0
> last_failure_osd_epoch  1573
> compat  compat={},rocompat={},incompat={1=base v0.20,2=client
> writeable ranges,3=default file layouts on dirs,4=dir inode in
> separate object,5=mds uses versioned encoding,6=dirfrag is stored in
> omap,8=file layout v2}
> max_mds 1
> in      0
> up      {0=579217}
> failed
> damaged
> stopped
> data_pools      [5]
> metadata_pool   6
> inline_data     disabled
> balancer
> standby_count_wanted    1
> 579217: x.x.x.233:6804/1176521332 'xxx233' mds.0.589 up:replay seq 2
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
