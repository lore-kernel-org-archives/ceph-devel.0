From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: ceph, XioMessenger issue
Date: Thu, 3 Nov 2016 07:27:40 +0000
Message-ID: <DB5PR05MB1607074AA7D7B7E04076A241A9A30@DB5PR05MB1607.eurprd05.prod.outlook.com>
References: <FEC85B105C5F644CA51BDB90657EEA98281CB374@ddsm-mbx01.digdes.com>
 <alpine.DEB.2.11.1611022003390.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0079.outbound.protection.outlook.com ([104.47.2.79]:23901
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751136AbcKCL77 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 3 Nov 2016 07:59:59 -0400
In-Reply-To: <alpine.DEB.2.11.1611022003390.20331@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Marov Aleksey <Marov.A@raidix.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We (in Mellanox) build with Xio on a regular basis.  We have a bunch of com=
mits in the pipe that we are submitting 1 after the other.  Currently, the =
pipe is blocked by this PR  https://github.com/ceph/ceph/pull/9444=20
After we complete releasing new version here we'll struggle with the needed=
 merges

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Wednesday, November 02, 2016 22:07
> To: Marov Aleksey=20
>=20
>=20
> It sounds like nobody else has hit this yet except you, so apparently oth=
ers
> also are building with[out] xio in their dev environments.  :(
