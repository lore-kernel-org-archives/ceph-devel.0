From: Gregory Farnum <greg@gregs42.com>
Subject: Re: [ceph-users] CephFS Slow writes with 1MB files
Date: Fri, 27 Mar 2015 13:04:02 -0700
Message-ID: <CAC6JEv-G_s3gRNmn3MHPiuFP6ODiOgvhX_J02KEo=Dd0X-JLGg@mail.gmail.com>
References: <CAMzumdZo2jdHEnB55g1XOVTxc4JLq-+6JFFZSwjgox=9LOUdZA@mail.gmail.com>
	<CAMzumdbezcb-p1_MpcSL-h8tTR0RKATt93Om6NPejtn1G6yPeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36591 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbbC0UED (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 16:04:03 -0400
Received: by igbud6 with SMTP id ud6so30180674igb.1
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2015 13:04:03 -0700 (PDT)
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com. [209.85.213.178])
        by mx.google.com with ESMTPSA id y6sm2293040igw.21.2015.03.27.13.04.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2015 13:04:02 -0700 (PDT)
Received: by ignm3 with SMTP id m3so38021790ign.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2015 13:04:02 -0700 (PDT)
In-Reply-To: <CAMzumdbezcb-p1_MpcSL-h8tTR0RKATt93Om6NPejtn1G6yPeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barclay Jameson <almightybeeij@gmail.com>
Cc: ceph-users <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

So this is exactly the same test you ran previously, but now it's on
faster hardware and the test is slower?

Do you have more data in the test cluster? One obvious possibility is
that previously you were working entirely in the MDS' cache, but now
you've got more dentries and so it's kicking data out to RADOS and
then reading it back in.

If you've got the memory (you appear to) you can pump up the "mds
cache size" config option quite dramatically from it's default 100000.

Other things to check are that you've got an appropriately-sized
metadata pool, that you've not got clients competing against each
other inappropriately, etc.
-Greg

On Fri, Mar 27, 2015 at 9:47 AM, Barclay Jameson
<almightybeeij@gmail.com> wrote:
> Opps I should have said that I am not just writing the data but copying it :
>
> time cp Small1/* Small2/*
>
> Thanks,
>
> BJ
>
> On Fri, Mar 27, 2015 at 11:40 AM, Barclay Jameson
> <almightybeeij@gmail.com> wrote:
>> I did a Ceph cluster install 2 weeks ago where I was getting great
>> performance (~= PanFS) where I could write 100,000 1MB files in 61
>> Mins (Took PanFS 59 Mins). I thought I could increase the performance
>> by adding a better MDS server so I redid the entire build.
>>
>> Now it takes 4 times as long to write the same data as it did before.
>> The only thing that changed was the MDS server. (I even tried moving
>> the MDS back on the old slower node and the performance was the same.)
>>
>> The first install was on CentOS 7. I tried going down to CentOS 6.6
>> and it's the same results.
>> I use the same scripts to install the OSDs (which I created because I
>> can never get ceph-deploy to behave correctly. Although, I did use
>> ceph-deploy to create the MDS and MON and initial cluster creation.)
>>
>> I use btrfs on the OSDS as I can get 734 MB/s write and 1100 MB/s read
>> with rados bench -p cephfs_data 500 write --no-cleanup && rados bench
>> -p cephfs_data 500 seq (xfs was 734 MB/s write but only 200 MB/s read)
>>
>> Could anybody think of a reason as to why I am now getting a huge regression.
>>
>> Hardware Setup:
>> [OSDs]
>> 64 GB 2133 MHz
>> Dual Proc E5-2630 v3 @ 2.40GHz (16 Cores)
>> 40Gb Mellanox NIC
>>
>> [MDS/MON new]
>> 128 GB 2133 MHz
>> Dual Proc E5-2650 v3 @ 2.30GHz (20 Cores)
>> 40Gb Mellanox NIC
>>
>> [MDS/MON old]
>> 32 GB 800 MHz
>> Dual Proc E5472  @ 3.00GHz (8 Cores)
>> 10Gb Intel NIC
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
