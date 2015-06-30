From: Casey Bodley <cbodley@gmail.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Tue, 30 Jun 2015 17:15:58 -0400
Message-ID: <CAMeBU_3ty6ae5VXP=_D8py1_Pk4rLKxCa4Larz0oKnyTYDtz8w@mail.gmail.com>
References: <CACJqLyZcAzb5wocrN8b8WoK6j3ynWF-_3=T+1aQkDko4Mv_SmQ@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319D0D@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34973 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbbF3VQA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2015 17:16:00 -0400
Received: by qget71 with SMTP id t71so10303129qge.2
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 14:15:58 -0700 (PDT)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03B319D0D@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

When Danny Al-Gaaf & Daniel Gollub published "Ceph Performance
Analysis: fio and RBD" at
https://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html,
they also mentioned a fio engine that linked directly into ceph's
FileStore. I was able to find Daniel's branch on github at
https://github.com/gollub/ceph/tree/fio_filestore_v2, and did some
more work on it at the time.

I just rebased that work onto the latest ceph master branch, and
pushed to our github at
https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore. You
can find the source in src/test/fio_ceph_filestore.cc, and run fio
with the provided example fio job file in src/test/filestore.fio.

I didn't have a chance to confirm that it builds with automake, but
the cmake version built for me. I'm happy to help if you run into
problems,
Casey

On Tue, Jun 30, 2015 at 2:31 PM, James (Fei) Liu-SSI
<james.liu@ssi.samsung.com> wrote:
> Hi Haomai,
>   What are you trying to ask is to benchmark local objectstore(like kvstore/filestore/newstore) locally with FIO(ObjectStore engine)? You want to purely compare the performance locally for these objectstores, right?
>
>   Regards,
>   James
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
> Sent: Tuesday, June 30, 2015 9:06 AM
> To: ceph-devel@vger.kernel.org
> Subject: About Fio backend with ObjectStore API
>
> Hi all,
>
> Long long ago, is there someone said about fio backend with Ceph ObjectStore API? So we could use the existing mature fio facility to benchmark ceph objectstore.
>
> --
> Best Regards,
>
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
