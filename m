From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Infiniband 40GB
Date: Thu, 07 Jun 2012 12:15:24 -0500
Message-ID: <4FD0E1AC.6020800@inktank.com>
References: <d0e700bd-f7f5-423f-9955-28c3835969e2@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44236 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431Ab2FGRP2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 13:15:28 -0400
Received: by ghrr11 with SMTP id r11so591789ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 10:15:27 -0700 (PDT)
In-Reply-To: <d0e700bd-f7f5-423f-9955-28c3835969e2@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Amon Ott <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, Yann Dupont <Yann.Dupont@univ-nantes.fr>

On 6/7/12 6:25 AM, Alexandre DERUMIER wrote:
> others tests done today: (kernel 3.4 - ubuntu precise)
>
> 3 nodes with 5 osd with btrfs, 1GB journal in tmps forced in writeahe=
ad
> 3 nodes with 1 osd with xfs,8GB journal in tmpfs
> 3 nodes with 1 osd with btfs,8GB journal in tmpfs forced in writeahea=
d
>
> 3 nodes with 5 osd with btrfs, 20G journal on disk forced in writeahe=
ad
> 3 nodes with 1 osd with xfs,20GB journal on disk
> 3 nodes with 1 osd with btfs,20GB journal on disk forced in writeahea=
d
>
>
>
>
> same behaviour for all cases, writes are constant to disk.
>
> benched with:
> rados -p pool3 bench 60 write -t 16
>
> also with
> fio, bonnie  , random/seq write from guest vm with differents block s=
ize.
>
>
>
>
> ----- Mail original -----
>
> De: "Alexandre DERUMIER"<aderumier@odiso.com>
> =C3=80: "Mark Nelson"<mark.nelson@inktank.com>
> Cc: "Amon Ott"<a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, "Yann=
 Dupont"<Yann.Dupont@univ-nantes.fr>
> Envoy=C3=A9: Jeudi 7 Juin 2012 05:31:15
> Objet: Re: Infiniband 40GB
>
> Hi again,
> I have done some tests with journals on a real disk, I have same beha=
viour.
>
> iostat show constant write to journal and write to disks at the same =
time since the beginning of the benchmark.
>
>
> maybe can I try to use differents partitions for each journal ? (curr=
ently I have 1 partition with 5 journal files of each osd)
>
> -Alexandre
>
>
>
> ----- Mail original -----
>
> De: "Alexandre DERUMIER"<aderumier@odiso.com>
> =C3=80: "Mark Nelson"<mark.nelson@inktank.com>
> Cc: "Amon Ott"<a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, "Yann=
 Dupont"<Yann.Dupont@univ-nantes.fr>
> Envoy=C3=A9: Jeudi 7 Juin 2012 05:11:15
> Objet: Re: Infiniband 40GB
>
> Hi mark,
> I have attached a blktrace of /dev/sdb1 of node1 (osd.0)
>
> and also iostat (showing constant writes)
>
> bench used:
>
> rados -p pool3 bench 60 write -t 16
>
>
> kernel use : 3.4 from intank
>
> I'll do tests with journal on an xfs partition today
>

Hi Alexandre,

I'll try to take a look at the data you sent me later today.

Thanks!
Mark

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
