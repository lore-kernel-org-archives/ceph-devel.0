From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: ceph-disk disk partition alignment
Date: Tue, 23 Feb 2016 05:24:07 +0000
Message-ID: <BN1PR02MB0550FC810BB08A29F672683F4A40@BN1PR02MB055.namprd02.prod.outlook.com>
References: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
 <56CBEA15.4090309@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0093.outbound.protection.outlook.com ([65.55.169.93]:33146
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750780AbcBWFYJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Feb 2016 00:24:09 -0500
In-Reply-To: <56CBEA15.4090309@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

Yeah, my bad, ceph-disk issue, thanks...No, I didn't file any tracker, =
please go ahead..

<< IIRC there are cases where sgdisk is not able to create a partition =
 aligned as recommended (but parted could).

Nope, I don't know the scenarios where sgdisk/fdisk/gdisk won't be able=
 to create properly aligned partitions..If you can share that knowledge=
 would be helpful..

Thanks & Regards
Somnath

-----Original Message-----
=46rom: Loic Dachary [mailto:loic@dachary.org]
Sent: Monday, February 22, 2016 9:12 PM
To: Somnath Roy; ceph-devel
Subject: Re: ceph-disk disk partition alignment

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

--
Lo=EFc Dachary, Artisan Logiciel Libre

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
