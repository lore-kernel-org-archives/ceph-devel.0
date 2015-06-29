From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: CRC32 of messages
Date: Mon, 29 Jun 2015 08:27:10 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB4C4DC44D@ABGEX73E.FSC.NET>
References: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDAE1C3@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:6221 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbF2G1M convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 02:27:12 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDAE1C3@SACMBXIP01.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Somnath Roy
> Sent: Friday, June 26, 2015 7:52 PM
>=20
> ceph_crc32c_intel_fast is ~6 times faster than ceph_crc32c_sctp. If y=
ou are
> not using intel cpus or you have older intel cpus where this sse4 ins=
truction

Not exactly true, AMD CPUs released after October 2011 support SSE 4.2 =
(which include CRC32 instructions) as well.
See this: http://www.cpu-world.com/Glossary/S/SSE4.2.html

With best regards / Pozdrawiam
Piotr Da=B3ek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
