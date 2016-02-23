From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk disk partition alignment
Date: Tue, 23 Feb 2016 12:49:15 +0700
Message-ID: <56CBF2DB.10602@dachary.org>
References: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
 <56CBEA15.4090309@dachary.org>
 <BN1PR02MB0550FC810BB08A29F672683F4A40@BN1PR02MB055.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35382 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbcBWFtZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Feb 2016 00:49:25 -0500
In-Reply-To: <BN1PR02MB0550FC810BB08A29F672683F4A40@BN1PR02MB055.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Here it is http://tracker.ceph.com/issues/14842

On 23/02/2016 12:24, Somnath Roy wrote:
> eph-deploy is creating data partition from sector 1 ignoring what sgd=
isk is recommending (256 in my disk). Basically, it should be aligned w=
ith physical sector size (reported in /sys/block/<device>/queue/physica=
l_block_size). In my case it is 16K physical and 4K logical...256 is pe=
rfectly fine as sgdisk/fdisk internally decides.
>> Disk performance will be severely impacted because of partitioning t=
his way from ceph-deploy ,=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
