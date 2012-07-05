From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Slow request warnings on 0.48
Date: Thu, 05 Jul 2012 12:58:27 -0500
Message-ID: <4FF5D5C3.80207@inktank.com>
References: <44469a6e-79a3-4eaa-be25-c47192c8fc80@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43278 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab2GER6d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 13:58:33 -0400
Received: by yenl2 with SMTP id l2so7684809yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 10:58:33 -0700 (PDT)
In-Reply-To: <44469a6e-79a3-4eaa-be25-c47192c8fc80@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: David Blundell <David.Blundell@100percentit.com>, ceph-devel@vger.kernel.org

On 07/04/2012 11:58 AM, Alexandre DERUMIER wrote:
> Hi, I see same messages here after upgrade to 0.48.
>
> with random write benchmark.
>
> I have more lags than before with 0.47 (but disks are at 100% usage, =
so can't tell if it's normal or not)
>
>
> ----- Mail original -----
>
> De: "David Blundell"<David.Blundell@100percentit.com>
> =C3=80: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Mercredi 4 Juillet 2012 18:53:02
> Objet: Slow request warnings on 0.48
>
> I have three servers running mon and osd using Ubuntu 12.04 that I ha=
ve been testing with RADOS storing RBD KVM instances
>
> 0.47.3 worked extremely well (once I got over a few btrfs issues). Th=
e same servers running 0.48 give a large number of "[WRN] slow request"=
 messages whenever I generate a lot of random IO in the KVM instances u=
sing iozone. The slow responses eventually leads to disk timeouts on th=
e KVM instances.
>
> I have erased the osds and recreated on new btrfs volumes with the sa=
me result.
>
> I have also tried switching to xfs using mkfs.xfs -n size=3D64k with =
noatime, inode64,delaylog,logbufs=3D8,logbsize=3D256k
>
> Xfs gives the same result - the iozone tests run fine until the rando=
m IO starts and then there are lots of slow request warnings.
>
> Does anyone have any ideas about the best place to start troubleshoot=
ing / debugging?
>
> Thanks,
>
> David

Hi David and Alexandre,

Does this only happen with random writes or also sequential writes?  If=
=20
it happens with sequential writes as well, does it happen with rados be=
nch?

--=20
Mark Nelson
Performance Engineer
Inktank
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
