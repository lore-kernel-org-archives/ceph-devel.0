From: Adir Lev <adirl@mellanox.com>
Subject: systemd and RDMA
Date: Thu, 23 Feb 2017 12:34:50 +0000
Message-ID: <VI1PR0501MB278205C007302409F70B10B2D7530@VI1PR0501MB2782.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve1eur01on0065.outbound.protection.outlook.com ([104.47.1.65]:41696
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751034AbdBWMgo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Feb 2017 07:36:44 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: kefu chai <tchaikov@gmail.com>

Hi Cephers,

In order to use systemctl with RDMA messenger we need to make few changes t=
o /etc/systemd/system/
1. Set PrivateDevices=3Dno
2. Set LimitMEMLOCK=3Dinfinity
see PR: https://github.com/ceph/ceph/pull/13305

I got few rejects suggesting to change those params only when actually usin=
g RDMA.
Since systemd scripts are the first to run we cannot check it in ceph code.

Any suggestion on how to check messenger type and set PrivateDevices and Li=
mitMEMLOCK accordingly?=20

TIA,
Adir Lev


