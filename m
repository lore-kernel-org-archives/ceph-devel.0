From: Mohamad Gebai <mgebai@suse.com>
Subject: Re: Ceph Bluestore OSD CPU utilization
Date: Tue, 1 Aug 2017 10:35:59 +0300
Message-ID: <a9127d78-873f-7db9-6111-81fd804aa2cf@suse.com>
References: <694B98CBCEF42547AE4CD1A693225B5D085533EA@CNMAILEX04.lenovo.com>
 <5f6e1242-f0ec-62f2-9778-eb0a28406838@redhat.com>
 <6929185c-7c88-83ee-9e12-62db1cd23ec5@redhat.com>
 <694B98CBCEF42547AE4CD1A693225B5D085544B4@CNMAILEX04.lenovo.com>
 <e09c864a-fb65-a68a-4802-f8b4d29f88fc@gmail.com>
 <694B98CBCEF42547AE4CD1A693225B5D085546CF@CNMAILEX04.lenovo.com>
 <f367fa53-1d0c-3a81-0769-e0a46adb9cdb@gmail.com>
 <694B98CBCEF42547AE4CD1A693225B5D08554965@CNMAILEX04.lenovo.com>
 <CAF-wwdG5Z+LBtsdiWcdMOJQVimzsv1n6ApaVhJNiSqKfVMoxxQ@mail.gmail.com>
 <de192cba-0bc8-8f29-2cdd-26e7ca48db9e@gmail.com>
 <CAB=cV2QXE0+SPP_Lur6tBWPSqq077c3kfuvcu_yX-93WUqSiog@mail.gmail.com>
 <76e43d0f-37d9-756e-f9ed-9df37a07162d@gmail.com>
 <CAB=cV2SrUn_hd3t8jxp0JS6DjY6Juhpkx0NLRcQ=-cGebqvdGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41101 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750763AbdHAHff (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 1 Aug 2017 03:35:35 -0400
In-Reply-To: <CAB=cV2SrUn_hd3t8jxp0JS6DjY6Juhpkx0NLRcQ=-cGebqvdGw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jianjian Huo <samuel.huo@gmail.com>, Mark Nelson <mark.a.nelson@gmail.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Junqin JQ7 Zhang <zhangjq7@lenovo.com>, Mark Nelson <mnelson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


On 07/31/2017 09:29 PM, Jianjian Huo wrote:
> On Sat, Jul 29, 2017 at 8:34 PM, Mark Nelson <mark.a.nelson@gmail.com> wrote:
>>
>> https://drive.google.com/uc?export=download&id=0B2gTBZrkrnpZbE50QUdtZlBxdFU
> Thanks for sharing this data, Mark.
> From your data of last March, for RBD EC overwrite on NVMe, EC
> sequential writes are faster than 3X for all IO sizes including small
> 4K/16KB. Is this right? but I am not seeing this on my setup(all nvme
> drives, 12 of them per node), in my case EC sequential writes are 2~3
> times slower than 3X. Maybe I have too many drives per node?
>

FWIW, we've seen EC random writes being 3x to 4x slower than replication
in terms of IOPS for a block size of 4kb. Similar setup: 10 NVMe disks
per node.

Mohamad

