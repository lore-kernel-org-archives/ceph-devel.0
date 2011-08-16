From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Separating clients data
Date: Tue, 16 Aug 2011 17:22:32 +0200
Message-ID: <1313508152.2833.4.camel@wido-laptop>
References: <CAGqxmDOGnrRPgyRFBW28f6zm7Fy-mrhSbBERceZD=KeU3P4GvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:56833 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab1HPPWh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2011 11:22:37 -0400
In-Reply-To: <CAGqxmDOGnrRPgyRFBW28f6zm7Fy-mrhSbBERceZD=KeU3P4GvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Maciej =?UTF-8?Q?Ga=C5=82kiewicz?= <maciejgalkiewicz@ragnarson.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Tue, 2011-08-16 at 14:35 +0200, Maciej Ga=C5=82kiewicz wrote:
> Hello,
>=20
> I have a storage cluster based on glusterfs. Each client have its own
> volume and his is not able to mount any other. Is it possible to
> implement such separation with ceph? I have read about authentication
> and mounting subdirectories. I am not sure if I can configure
> different login/pass for selected directories stored in ceph. All
> clients are running on Xen's domU (virtual machine). Maybe there is
> some other way to achieve this?
>=20

This is currently not possible, it was possible before the introduction
of cephx.

There is a feature request for this:
http://tracker.newdream.net/issues/1237

Wido


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
