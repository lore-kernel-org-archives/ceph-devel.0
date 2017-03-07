From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Much more dentries than inodes, is that normal?
Date: Tue, 7 Mar 2017 22:48:47 +0800
Message-ID: <CAAM7YA=+vR4bO9SSonu=Srh_g9XTLO4uBsSQ6EgdgTvnBwyJzQ@mail.gmail.com>
References: <CAEYCsVL-_JihR5RcDPzajNhZk52sGdwHOxU1Xmsbb==fhMh39Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35999 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932788AbdCGOsu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Mar 2017 09:48:50 -0500
Received: by mail-ua0-f175.google.com with SMTP id 72so6136607uaf.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Mar 2017 06:48:49 -0800 (PST)
In-Reply-To: <CAEYCsVL-_JihR5RcDPzajNhZk52sGdwHOxU1Xmsbb==fhMh39Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Tue, Mar 7, 2017 at 5:17 PM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> Hi,
>
>       From the admin socket of mds, I got following data on our
> production cephfs env, roughly we have 585K inodes and almost same
> amount of caps, but we have>2x dentries than inodes.
>
>       I am pretty sure we dont use hard link intensively (if any).
> And the #ino match with "rados ls --pool $my_data_pool}.
>
>       Thanks for any explanations, appreciate it.
>
>
> "mds_mem": {
>         "ino": 584974,
>         "ino+": 1290944,
>         "ino-": 705970,
>         "dir": 25750,
>         "dir+": 25750,
>         "dir-": 0,
>         "dn": 1291393,
>         "dn+": 1997517,
>         "dn-": 706124,
>         "cap": 584560,
>         "cap+": 2657008,
>         "cap-": 2072448,
>         "rss": 24599976,
>         "heap": 166284,
>         "malloc": 18446744073708721289,
>         "buf": 0
>     },
>

Maybe they are dirty null dentries. try flushing mds's journal and check again.

Regards
Yan, Zheng

>
>
> Xiaoxi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
