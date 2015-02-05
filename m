From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: xio messenger prelim benchmark
Date: Wed, 04 Feb 2015 20:08:53 -0600
Message-ID: <54D2D0B5.8070608@redhat.com>
References: <em44dffba0-5698-428a-9fdb-78129fba5a4f@lt-vu-6500>
Reply-To: mnelson@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:32952 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbBECI4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Feb 2015 21:08:56 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so6894926ieb.2
        for <ceph-devel@vger.kernel.org>; Wed, 04 Feb 2015 18:08:55 -0800 (PST)
In-Reply-To: <em44dffba0-5698-428a-9fdb-78129fba5a4f@lt-vu-6500>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vu Pham <vuhuong@mellanox.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: "\"Matt W. Benjamin\" <matt@cohortfs.com>" <matt@cohortfs.com>, Oren Duer <oren@mellanox.com>



On 02/04/2015 02:08 PM, Vu Pham wrote:
> Hi,
>
> I would like to share some benchmarking numbers on xio messenger and
> simple messenger
>
> HW/SW configuration:
> ---------------------
> . 1 32-core Xeon E5-2697V3 2.6G (Haswell) node, 64GB of memory.
> . Hyperthreading is ON/enabled, 64 cores
> . Mellanox ConnectX3-EN 40Gb/s HCAs, fw- 2.33.5000
> . Mellanox SX1012 40Gb/s switch EN.
> . Ubuntu 14.04 LTS stock kernel
> . MLNX_OFED_LINUX-2.4-1.0.0 sw package
> . Accelio master branch (tag v-1.3)
> . Ceph master (Jan-29) + pr #3544 (xio spread portals).
> . Use ramdisks and filestore backend
> . Use fio_rbd on user rbd as client
>
> 1 OSD, 1 client node
> -------------------------
> a. 1 rbd image
> xio messenger:
> . ~9100 iops (4K random write, 6 cores used on osd node, numjobs=1,
> iodepth=64)
> . ~21k iops (4K random read, 4 cores used, numjobs=1, iodepth=32)
> . ~121k iops (4K random read, 15 cores used, numjobs=8, iodepth=32)
> . ~520MB/s (256K random write, 3 cores used, numjobs=1, iodepth=64)
> . ~3140MB/s (256K random read, 4 cores used, numjobs=1, iodepth=32)
> . ~4330MB/s (256K random read, 6 cores used, numjobs=8)
> simple messenger:
> . ~8500 iops (4K random write, 7 cores used)
> . ~20k iops (4K random read, 5 cores used)
> . ~105k iops (4K random read, 20 cores used, numjobs=8, iopdepth=32)
> . ~450MB/s (256K random write, 3 cores used)
> . ~1140MB/s (256K random read, 3 cores used)
> . ~4330MB/s (256K random read, 8 cores used, numjobs=8)
>
>
> b. 2 rbd images on two separated pools, 2 fio_rbd instances
> xio messenger:
> . ~9100 iops (4K random write, 6 cores used on osd node, each fio_rbd
> instance has numjobs=1, iodepth=64)
> . ~155k iops (4K random read, 19 cores used, each fio_rbd instance has
> numjobs=8, iodepth=32)
> . ~4225MB/s (256K random read, 6 cores used, each fio_rbd instance has
> numjobs=1, iodepth=32)
> . ~4330MB/s (256K random read, 8 cores used, each fio_rbd instance has
> numjobs=8, iodepth=32)
>
> simple messenger:
> . ~7800 iops (4K random write, 7 cores used on osd node, each fio_rbd
> instance has numjobs=1, iodepth=64)
> . ~125k iops (4K random read, 25 cores used, each fio_rbd instance has
> numjobs=8, iodepth=32)
> . ~2068MB/s (256K random read, 4 cores used, each fio_rbd instance has
> numjobs=1, iodepth=32)
> . ~4330MB/s (256K random read, 11 cores used, each fio_rbd instance has
> numjobs=8, iodepth=32)
>
> 2 OSDs, 1 client node, 4 rbd images on 4 separated pools
> --------------------------------------------------------------------
> 4K random read: xio messenger max at ~272k iops, simple messenger max at
> ~170k iops
>
>
> 4 OSDs, 1 client node, 4 rbd images on 4 separated pools
> ---------------------------------------------------------------------
> 4K random read: xio messenger max at ~355k iops, simple messenger max at
> ~204k iops
>
>
> 8 OSDs, 1 client node, 4 rbd images on 4 separated pools
> ---------------------------------------------------------------------
> 4K random read: xio messenger max at ~355K iops, simple messenger max at
> ~225k iops
>
>
> I attach here the ceph configuration files that I used.
> Please note that I enable flow-control and turn off header_crc &
> data_crc for both xio & simple.
>
> Are the simple messenger numbers looking reasonable and in the ballpark?
> Please share your numbers and configuration if you have higher numbers.

These numbers look great Vu.  You may want to look at the auth numbers I 
just posted as you are getting sufficiently high enough IOPs that doing 
things like disabling in-memory dubgging, disabling auth, and testing on 
RHEL may make a difference for you.

>
> thanks,
> -vu
>
