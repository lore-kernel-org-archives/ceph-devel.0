From: Dan van der Ster <dan@vanderster.com>
Subject: Re: ceph.dir.rbytes inconsistent on different hosts
Date: Tue, 13 Jun 2017 12:02:18 +0200
Message-ID: <CABZ+qq=NUHM6v7v5kS5FD8DQsPiSNbBAgU+qY1=vcANNZ4+zHg@mail.gmail.com>
References: <CAGbvivJw+gEDijgq3eG41k78K2AGh+HknKwE7FKVUGo01Wd3SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:33521 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbdFMKDG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jun 2017 06:03:06 -0400
Received: by mail-ot0-f169.google.com with SMTP id k4so84184828otd.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 03:03:06 -0700 (PDT)
Received: from mail-ot0-f175.google.com (mail-ot0-f175.google.com. [74.125.82.175])
        by smtp.gmail.com with ESMTPSA id p53sm6310920otd.26.2017.06.13.03.02.59
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 03:02:59 -0700 (PDT)
Received: by mail-ot0-f175.google.com with SMTP id k4so84184271otd.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 03:02:59 -0700 (PDT)
In-Reply-To: <CAGbvivJw+gEDijgq3eG41k78K2AGh+HknKwE7FKVUGo01Wd3SA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sounds like this issue?

   http://tracker.ceph.com/issues/17939

Cheers, Dan



On Mon, Jun 12, 2017 at 9:45 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Ceph 10.2.7
> Ubuntu 16.04.2
>
> We have 2 hosts running identical versions of ceph with identical
> ceph.conf configuration files.
> Both mount /cephfs with the same options.
>
> We have a directory under /cephfs with a 4GB file in it.  The
> ceph.dir.rbytes xattr reported by ceph is different on the 2 hosts.
> One is correct, one is not.
>
> One host reports the 'ceph.dir.rbytes' correctly as 4129644548, the
> other reports it incorrectly as  2389190660
> Any ideas why this would be happening ?
>
> - Wyllys Ingersoll
>   Keeper Technology, LLC
>
>
> HOST A (correct values):
> $ ls -alF /cephfs/exports/smbtest
> total 4032857
> drwxrwxrwx 1 root    root    4129644548 May 31 11:28 ./
> drwxr-xr-x 1 root    root    4129644548 May 31 11:25 ../
> -rw-r--r-- 1 2000501 2000514       4096 May 31 11:26 ._.DS_Store
> -rw-r--r-- 1 2000501 2000514       6148 Jun  1 14:37 .DS_Store
> -rw-r--r-- 1 2000501 2000514 4129634304 Jun 12 15:25 test-2017-05-30-m1.iso
>
> $ getfattr -d -m ceph.dir /cephfs/exports/smbtest
> getfattr: Removing leading '/' from absolute path names
> # file: cephfs/exports/smbtest
> ceph.dir.rbytes="4129644548"
>
> HOST B (incorrect values)
> $ ls -alF /cephfs/exports/smbtest
> total 4032857
> drwxrwxrwx 1 root          root         2389190660 May 31 11:28 ./
> drwxr-xr-x 1 root          root         4129644548 May 31 11:25 ../
> -rw-r--r-- 1 2000501 2000514       4096 May 31 11:26 ._.DS_Store
> -rw-r--r-- 1 2000501 2000514       6148 Jun  1 14:37 .DS_Store
> -rw-r--r-- 1 2000501 2000514 4129634304 Jun 12 15:25 test-2017-05-30-m1.iso
>
> $ getfattr -d -m ceph.dir.rbytes /cephfs/exports/smbtest
> getfattr: Removing leading '/' from absolute path names
> # file: cephfs/exports/smbtest
> ceph.dir.rbytes="2389190660"
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
