From: Wido den Hollander <wido@widodh.nl>
Subject: Re: rbd kernel driver on the osd server
Date: Sun, 13 Jan 2013 19:00:18 +0100
Message-ID: <50F2F632.6060402@widodh.nl>
References: <20130113160840.GF27442@hro-mlt-02.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:37710 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3AMSAZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Jan 2013 13:00:25 -0500
In-Reply-To: <20130113160840.GF27442@hro-mlt-02.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Harald_R=F6=DFler?= <Harald.Roessler@btd.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 01/13/2013 05:08 PM, Harald R=F6=DFler wrote:
> Hi,
>
> couple of month ago I read about a limitation to run an RBD kernel dr=
iver on the osd server. Is this limitation still valid? The reason in U=
buntu and Debian there is no support for the RBD devices in QEMU. At th=
e moment, in our setup  the KVM's are running on the OSD servers.
>

I don't think so, but somebody might correct me here.

The OSDs nowadays use syncfs which leads them to only syncing their=20
filesystem instead of ALL the filesystems on that host.

It might however be that Qemu calls sync() instead of syncfs() which=20
still causes everything to be synced, which can lead to problems I gues=
s.

Regarding your reason for doing this, RBD is supported in Ubuntu's Qemu=
=2E

Under Ubuntu precise it already works:=20
http://packages.ubuntu.com/precise/qemu-kvm

The problem is that the shipped version of Ceph is 0.41, which might be=
=20
too old.

I've been following the Blueprint for Ubuntu 13.04 and that will have=20
all the Ceph stuff (Qemu and libvirt) you want with version 0.56.1

I'd look into that.

Wido

> Best Regards
> Harald Roessler
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
