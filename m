From: Denis Fondras <ceph@ledeuns.net>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Wed, 09 Jan 2013 09:30:53 +0100
Message-ID: <50ED2ABD.4050003@ledeuns.net>
References: <50E81A3D.5070100@ledeuns.net> <50EB0518.9050304@ledeuns.net> <E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com> <50EBDC5E.3090207@ledeuns.net> <CAPYLRzhUWYu8vp-Lk6WgyjxLH-GJ08QakTgWqZEKjVSXCbEZ2A@mail.gmail.com> <50EC7720.1040604@ledeuns.net> <CAPYLRziWs+mpHCB=FXin2UYA-wwrqiqPe1B--_kVN_+ex0apkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:23634 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273Ab3AIIaw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 03:30:52 -0500
In-Reply-To: <CAPYLRziWs+mpHCB=FXin2UYA-wwrqiqPe1B--_kVN_+ex0apkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

Le 09/01/2013 00:36, Gregory Farnum a =E9crit :
>
> It looks like it's taking approximately forever for writes to complet=
e
> to disk; it's shutting down because threads are going off to write an=
d
> not coming back. If you set "osd op thread timeout =3D 60" (or 120) i=
t
> might manage to churn through, but I'd look into why the writes are
> taking so long =97 bad disk, fragmented btrfs filesystem, or somethin=
g
> else.


I believe it is a BTRFS issue as when I mkfs.btrfs the volume and rejoi=
n=20
it to the cluster, it works (OSD is staying up).

Denis
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
