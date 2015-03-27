From: Barclay Jameson <almightybeeij@gmail.com>
Subject: Re: [ceph-users] CephFS Slow writes with 1MB files
Date: Fri, 27 Mar 2015 16:46:37 -0500
Message-ID: <CAMzumdb8S77aYqNUyhwzZDCGp6KBFc8OueZ0pCKrkSP=hDNFPg@mail.gmail.com>
References: <CAMzumdZo2jdHEnB55g1XOVTxc4JLq-+6JFFZSwjgox=9LOUdZA@mail.gmail.com>
	<CAMzumdbezcb-p1_MpcSL-h8tTR0RKATt93Om6NPejtn1G6yPeQ@mail.gmail.com>
	<CAC6JEv-G_s3gRNmn3MHPiuFP6ODiOgvhX_J02KEo=Dd0X-JLGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:33439 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbbC0Vqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 17:46:38 -0400
Received: by qcbjx9 with SMTP id jx9so28398934qcb.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2015 14:46:37 -0700 (PDT)
In-Reply-To: <CAC6JEv-G_s3gRNmn3MHPiuFP6ODiOgvhX_J02KEo=Dd0X-JLGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: ceph-users <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes it's the exact same hardware except for the MDS server (although I
tried using the MDS on the old node).
I have not tried moving the MON back to the old node.

My default cache size is "mds cache size = 10000000"
The OSDs (3 of them) have 16 Disks with 4 SSD Journal Disks.
I created 2048 for data and metadata:
ceph osd pool create cephfs_data 2048 2048
ceph osd pool create cephfs_metadata 2048 2048


To your point on clients competing against each other... how would I check that?

Thanks for the input!


On Fri, Mar 27, 2015 at 3:04 PM, Gregory Farnum <greg@gregs42.com> wrote:
> So this is exactly the same test you ran previously, but now it's on
> faster hardware and the test is slower?
>
> Do you have more data in the test cluster? One obvious possibility is
> that previously you were working entirely in the MDS' cache, but now
> you've got more dentries and so it's kicking data out to RADOS and
> then reading it back in.
>
> If you've got the memory (you appear to) you can pump up the "mds
> cache size" config option quite dramatically from it's default 100000.
>
> Other things to check are that you've got an appropriately-sized
> metadata pool, that you've not got clients competing against each
> other inappropriately, etc.
> -Greg
>
> On Fri, Mar 27, 2015 at 9:47 AM, Barclay Jameson
> <almightybeeij@gmail.com> wrote:
>> Opps I should have said that I am not just writing the data but copying it :
>>
>> time cp Small1/* Small2/*
>>
>> Thanks,
>>
>> BJ
>>
>> On Fri, Mar 27, 2015 at 11:40 AM, Barclay Jameson
>> <almightybeeij@gmail.com> wrote:
>>> I did a Ceph cluster install 2 weeks ago where I was getting great
>>> performance (~= PanFS) where I could write 100,000 1MB files in 61
>>> Mins (Took PanFS 59 Mins). I thought I could increase the performance
>>> by adding a better MDS server so I redid the entire build.
>>>
>>> Now it takes 4 times as long to write the same data as it did before.
>>> The only thing that changed was the MDS server. (I even tried moving
>>> the MDS back on the old slower node and the performance was the same.)
>>>
>>> The first install was on CentOS 7. I tried going down to CentOS 6.6
>>> and it's the same results.
>>> I use the same scripts to install the OSDs (which I created because I
>>> can never get ceph-deploy to behave correctly. Although, I did use
>>> ceph-deploy to create the MDS and MON and initial cluster creation.)
>>>
>>> I use btrfs on the OSDS as I can get 734 MB/s write and 1100 MB/s read
>>> with rados bench -p cephfs_data 500 write --no-cleanup && rados bench
>>> -p cephfs_data 500 seq (xfs was 734 MB/s write but only 200 MB/s read)
>>>
>>> Could anybody think of a reason as to why I am now getting a huge regression.
>>>
>>> Hardware Setup:
>>> [OSDs]
>>> 64 GB 2133 MHz
>>> Dual Proc E5-2630 v3 @ 2.40GHz (16 Cores)
>>> 40Gb Mellanox NIC
>>>
>>> [MDS/MON new]
>>> 128 GB 2133 MHz
>>> Dual Proc E5-2650 v3 @ 2.30GHz (20 Cores)
>>> 40Gb Mellanox NIC
>>>
>>> [MDS/MON old]
>>> 32 GB 800 MHz
>>> Dual Proc E5472  @ 3.00GHz (8 Cores)
>>> 10Gb Intel NIC
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
