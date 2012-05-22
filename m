From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 18:52:42 +0400
Message-ID: <CABYiri_A-Ge6nQMG5NJuwj3h=vFYJmhj9LzdfPdWe_SRMCrx-w@mail.gmail.com>
References: <4FBB8A5B.9010500@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36410 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758912Ab2EVOxE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 10:53:04 -0400
Received: by weyu7 with SMTP id u7so3942096wey.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 07:53:03 -0700 (PDT)
In-Reply-To: <4FBB8A5B.9010500@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

Hi,

I`ve run in almost same problem about two months ago, and there is a
couple of corner cases: near-default tcp parameters, small journal
size, disks that are not backed by controller with NVRAM cache and
high load on osd` cpu caused by side processes. Finally, I have able
to achieve 115Mb/s for large linear writes on raw rbd block inside VM
with journal on tmpfs and osds on RAID0 built on top of three sata
disks.

On Tue, May 22, 2012 at 4:45 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hi list,
>
> my ceph block testcluster is now running fine.
>
> Setup:
> 4x ceph servers
> =C2=A0- 3x mon with /mon on local os SATA disk
> =C2=A0- 4x OSD with /journal on tmpfs and /srv on intel ssd
>
> all of them use 2x 1Gbit/s lacp trunk.
>
> 1x KVM Host system (2x 1Gbit/s lacp trunk)
>
> With one KVM i do not get more than 40MB/s and my network link is jus=
t
> at 40% of 1Gbit/s.
>
> Is this expected? If not where can i start searching / debugging?
>
> Thanks,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
