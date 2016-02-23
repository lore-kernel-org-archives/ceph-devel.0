From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk disk partition alignment
Date: Tue, 23 Feb 2016 12:11:49 +0700
Message-ID: <56CBEA15.4090309@dachary.org>
References: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49135 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbcBWFMA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Feb 2016 00:12:00 -0500
In-Reply-To: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

This not a ceph-deploy issue, rather a ceph-disk issue. Did you file an=
 issue regarding this problem or would you like me to create one ? IIRC=
 there are cases where sgdisk is not able to create a partition  aligne=
d as recommended (but parted could). Do you know anything about that ?

Cheers

On 23/02/2016 01:27, Somnath Roy wrote:
> Hi,
> I am seeing ceph-deploy is creating data partition from sector 1 igno=
ring what sgdisk is recommending (256 in my disk). Basically, it should=
 be aligned with physical sector size (reported in /sys/block/<device>/=
queue/physical_block_size). In my case it is 16K physical and 4K logica=
l...256 is perfectly fine as sgdisk/fdisk internally decides.
> Disk performance will be severely impacted because of partitioning th=
is way from ceph-deploy , any reason why we are doing like this ?



> Thanks & Regards
> Somnath
>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
