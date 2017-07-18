From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: cephfs performance
Date: Tue, 18 Jul 2017 14:30:58 +0800
Message-ID: <CAEYCsVJ4deZ6vy6xifxDD=Sn9QkeCfxb8hV04fABDzN2Rg_=eA@mail.gmail.com>
References: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35829 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdGRGbA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 02:31:00 -0400
Received: by mail-oi0-f53.google.com with SMTP id 191so9370146oii.2
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jul 2017 23:30:59 -0700 (PDT)
In-Reply-To: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

we have seen fuse show much worse perofermance compared to kernel,
would you mind to test via kernel cephfs client( ubuntu 16.04 with 4.4
or rhel 7.2/7.3 should be good enough)

2017-07-18 13:27 GMT+08:00 sheng qiu <herbert1984106@gmail.com>:
> hi,
>
> I am evaluating the cephfs performance and see unreasonable
> performance when multiple threads accessing same mount point.
>
> there are 10k files (300MB each) in the fuse mount point, when
> increase multiple fio threads accessing those 10k files, the
> performance is not scaled and bounded to ~40MB/s.
>
> the ceph cluster has 36 OSDs on three high end servers, each OSD
> backed by a NVMe drive. Theres's another servers running one MDS
> process and monitors.
>
> if pushing IO via fio rbd engine to the cluster directly, it has
> pretty reasonable performance. Is there any special configuration i
> should pay attention when setup cephfs or fuse client is the problem?
> or i should use more MDS?
>
> any suggestions would be appreciated.
>
> Thanks,
> Sheng
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
