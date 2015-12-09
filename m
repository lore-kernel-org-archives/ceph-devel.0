From: Subra Varanasi-SSI <s.varanasi@ssi.samsung.com>
Subject: Resending : changes to eliminate rdma_local from xio messenger
 /ceph.conf.
Date: Wed, 9 Dec 2015 00:17:51 +0000
Message-ID: <4E71B74F2F86B3418F9BC11BDF8B2D251BC31D57@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:53596 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbLIARy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 19:17:54 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>, Marcus Watts <mwatts@redhat.com>, Vu Pham <vuhuong@mellanox.com>, "Gunna (Gunneswara) Marripudi-SSI" <g.marripudi@ssi.samsung.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi Matt/Marcus/Vu

As discussed before, in our efforts support multiple RDMA NIC ports in =
XIO Messenger, I have removed the need to specify rdma_local in ceph.co=
nf file and only use the addresses specified as a part of OSD network p=
arameters.=20
Please review the change. The changes have been tested for different ca=
ses ( no ip specified/ip correctly specified for each OSD/ rdma removed=
 etc) with I/O.

Change is at=20

Branch:  github.com/vsjulu/ceph/tree/wip-xio-rdma
Commit:=A0=A0 github.com/vsjulu/ceph/commit/d6e02a9d35f7897938e7a9f216a=
92e2e6c6f50a6#diff-e2c6ef819d3b7ad2010cf49194eefed6

Description of the change:=20
=2E Ceph supports specifiying different IP addresses for each OSD using=
 the [OSD]=20
=2E parameters in ceph.conf.=20
=2E rdma_local was a parameter that is used to specify a default rdma i=
p address to use in the=20
=2E XioMessenger bind method if no public nw/cluster nw address is spec=
ified.
=2E Remove reference to rdma_local from XioMessenger bind method and in=
stead return error code if the OSD IP addresses are not specified so we=
 can use the common parameters currently supported.

Thanks,
Subra
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
