From: Barclay Jameson <almightybeeij@gmail.com>
Subject: Re: CephFS Slow writes with 1MB files
Date: Fri, 27 Mar 2015 11:47:07 -0500
Message-ID: <CAMzumdbezcb-p1_MpcSL-h8tTR0RKATt93Om6NPejtn1G6yPeQ@mail.gmail.com>
References: <CAMzumdZo2jdHEnB55g1XOVTxc4JLq-+6JFFZSwjgox=9LOUdZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33088 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbbC0QrI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 12:47:08 -0400
Received: by qgfa8 with SMTP id a8so131519177qgf.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2015 09:47:08 -0700 (PDT)
In-Reply-To: <CAMzumdZo2jdHEnB55g1XOVTxc4JLq-+6JFFZSwjgox=9LOUdZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

Opps I should have said that I am not just writing the data but copying it :

time cp Small1/* Small2/*

Thanks,

BJ

On Fri, Mar 27, 2015 at 11:40 AM, Barclay Jameson
<almightybeeij@gmail.com> wrote:
> I did a Ceph cluster install 2 weeks ago where I was getting great
> performance (~= PanFS) where I could write 100,000 1MB files in 61
> Mins (Took PanFS 59 Mins). I thought I could increase the performance
> by adding a better MDS server so I redid the entire build.
>
> Now it takes 4 times as long to write the same data as it did before.
> The only thing that changed was the MDS server. (I even tried moving
> the MDS back on the old slower node and the performance was the same.)
>
> The first install was on CentOS 7. I tried going down to CentOS 6.6
> and it's the same results.
> I use the same scripts to install the OSDs (which I created because I
> can never get ceph-deploy to behave correctly. Although, I did use
> ceph-deploy to create the MDS and MON and initial cluster creation.)
>
> I use btrfs on the OSDS as I can get 734 MB/s write and 1100 MB/s read
> with rados bench -p cephfs_data 500 write --no-cleanup && rados bench
> -p cephfs_data 500 seq (xfs was 734 MB/s write but only 200 MB/s read)
>
> Could anybody think of a reason as to why I am now getting a huge regression.
>
> Hardware Setup:
> [OSDs]
> 64 GB 2133 MHz
> Dual Proc E5-2630 v3 @ 2.40GHz (16 Cores)
> 40Gb Mellanox NIC
>
> [MDS/MON new]
> 128 GB 2133 MHz
> Dual Proc E5-2650 v3 @ 2.30GHz (20 Cores)
> 40Gb Mellanox NIC
>
> [MDS/MON old]
> 32 GB 800 MHz
> Dual Proc E5472  @ 3.00GHz (8 Cores)
> 10Gb Intel NIC
