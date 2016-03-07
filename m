From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: ceph-disk disk partition alignment
Date: Mon, 7 Mar 2016 13:37:37 +0530
Message-ID: <56DD36C9.9060406@redhat.com>
References: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
 <56CBEA15.4090309@dachary.org>
 <BN1PR02MB0550FC810BB08A29F672683F4A40@BN1PR02MB055.namprd02.prod.outlook.com>
 <56CBF2DB.10602@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54870 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbcCGIHt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Mar 2016 03:07:49 -0500
In-Reply-To: <56CBF2DB.10602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 02/23/2016 11:19 AM, Loic Dachary wrote:
> Here it is http://tracker.ceph.com/issues/14842
>
> On 23/02/2016 12:24, Somnath Roy wrote:
>> eph-deploy is creating data partition from sector 1 ignoring what sgdisk is recommending (256 in my disk). Basically, it should be aligned with physical sector size (reported in /sys/block/<device>/queue/physical_block_size). In my case it is 16K physical and 4K logical...256 is perfectly fine as sgdisk/fdisk internally decides.
>>> Disk performance will be severely impacted because of partitioning this way from ceph-deploy ,

I think that more modern partition tools handle alignment better (and handle the 
modern partition types) - sfdisk and parted both are better than fdisk I believe.

For RHEL & Fedora, we try hard to make sure that we use the advertised alignment 
when we create a partition and default to an alignment on sector 2048 (1MB) if 
it is not set by the device.

Ric

