From: "Wang, Zhiye" <Zhiye.Wang@Arcserve.com>
Subject: CephFS: How to figure out which files are affected after a disaster
Date: Fri, 24 Mar 2017 05:35:31 +0000
Message-ID: <CY4PR10MB159194A6062F5ABA74AA3E9CE43E0@CY4PR10MB1591.namprd10.prod.outlook.com>
References: <CY4PR10MB1591F37261F24E1D6F510E97E43E0@CY4PR10MB1591.namprd10.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:45375
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751620AbdCXFfe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 24 Mar 2017 01:35:34 -0400
In-Reply-To: <CY4PR10MB1591F37261F24E1D6F510E97E43E0@CY4PR10MB1591.namprd10.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dear all,

I store only one replica (pool size =3D 1) for my data. And I lose one OSD =
in my cluster. Is there a way to figure out which files (in CephFS) are act=
ually affected?

"pool size =3D 1" is just an example for simple. I can also say "pool size =
=3D 2, but lose 2 OSD", or "pool size =3D 3, but lose 3 OSD".



Thanks
Zhiye


