From: Adir Lev <adirl@mellanox.com>
Subject: RE: systemd and RDMA
Date: Tue, 28 Feb 2017 15:29:26 +0000
Message-ID: <VI1PR0501MB2782C556BF49AB4D95AC824ED7560@VI1PR0501MB2782.eurprd05.prod.outlook.com>
References: <VI1PR0501MB278205C007302409F70B10B2D7530@VI1PR0501MB2782.eurprd05.prod.outlook.com>
 <alpine.DEB.2.11.1702231425150.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:13792
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751122AbdB1UJj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Feb 2017 15:09:39 -0500
In-Reply-To: <alpine.DEB.2.11.1702231425150.7782@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, kefu chai <tchaikov@gmail.com>

Thank you the helpful response,
Looks like we have all info to create this change
I will push new PR soon=20

Adir

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]=20
Sent: Thursday, February 23, 2017 4:26 PM
To: Adir Lev <adirl@mellanox.com>
Cc: ceph-devel@vger.kernel.org; kefu chai <tchaikov@gmail.com>
Subject: Re: systemd and RDMA

On Thu, 23 Feb 2017, Adir Lev wrote:
> Hi Cephers,
>=20
> In order to use systemctl with RDMA messenger we need to make few=20
> changes to /etc/systemd/system/ 1. Set PrivateDevices=3Dno 2. Set=20
> LimitMEMLOCK=3Dinfinity see PR: https://github.com/ceph/ceph/pull/13305
>=20
> I got few rejects suggesting to change those params only when actually us=
ing RDMA.
> Since systemd scripts are the first to run we cannot check it in ceph cod=
e.
>=20
> Any suggestion on how to check messenger type and set PrivateDevices=20
> and LimitMEMLOCK accordingly?

Hmm, is it possible to make them conditional on something in /etc/{sysconfi=
g,default}/ceph?  Then an RDMA user would just need to comment in a line li=
ke ENABLE_RDMA=3D1 or something...

sage
