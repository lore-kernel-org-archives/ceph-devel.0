From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk disk partition alignment
Date: Mon, 7 Mar 2016 15:44:26 +0700
Message-ID: <56DD3F6A.5050009@dachary.org>
References: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
 <56CBEA15.4090309@dachary.org>
 <BN1PR02MB0550FC810BB08A29F672683F4A40@BN1PR02MB055.namprd02.prod.outlook.com>
 <56CBF2DB.10602@dachary.org> <56DD36C9.9060406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41816 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcCGIoh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 03:44:37 -0500
In-Reply-To: <56DD36C9.9060406@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ric Wheeler <rwheeler@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Ric,

On 07/03/2016 15:07, Ric Wheeler wrote:
> On 02/23/2016 11:19 AM, Loic Dachary wrote:
>> Here it is http://tracker.ceph.com/issues/14842
>>
>> On 23/02/2016 12:24, Somnath Roy wrote:
>>> eph-deploy is creating data partition from sector 1 ignoring what s=
gdisk is recommending (256 in my disk). Basically, it should be aligned=
 with physical sector size (reported in /sys/block/<device>/queue/physi=
cal_block_size). In my case it is 16K physical and 4K logical...256 is =
perfectly fine as sgdisk/fdisk internally decides.
>>>> Disk performance will be severely impacted because of partitioning=
 this way from ceph-deploy ,
>=20
> I think that more modern partition tools handle alignment better (and=
 handle the modern partition types) - sfdisk and parted both are better=
 than fdisk I believe.
>=20
> For RHEL & Fedora, we try hard to make sure that we use the advertise=
d alignment when we create a partition and default to an alignment on s=
ector 2048 (1MB) if it is not set by the device.

So far we've used https://sourceforge.net/projects/gptfdisk/, do you kn=
ow if it has limitations that would be better addressed by other tools =
?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
