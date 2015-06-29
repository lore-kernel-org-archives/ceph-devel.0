From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: CRC32 of messages
Date: Mon, 29 Jun 2015 09:31:57 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB4C4DC4FE@ABGEX73E.FSC.NET>
References: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDAE1C3@SACMBXIP01.sdcorp.global.sandisk.com>
 <90559C83A9C7FA45B5846C975DFA612DDB4C4DC44D@ABGEX73E.FSC.NET>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB05D9@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:6708 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbF2HcC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 03:32:02 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB05D9@SACMBXIP01.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Somnath Roy [mailto:Somnath.Roy@sandisk.com]
> Sent: Monday, June 29, 2015 9:01 AM
> To: Da=B3ek, Piotr; ceph-devel@vger.kernel.org
> Subject: RE: CRC32 of messages
>=20
> Thanks Piotr for the info, but I am not sure the asm instructions cep=
h is using
> for probing cpu is compatible to AMD or not.

Looks like it's vendor-neutral:

        asm("movl %4, %%eax;"
            "cpuid;"
            "movl %%eax, %0;"
            "movl %%ebx, %1;"
            "movl %%ecx, %2;"
            "movl %%edx, %3;"
                : "=3Dr" (*eax), "=3Dr" (*ebx), "=3Dr" (*ecx), "=3Dr" (=
*edx)
                : "r" (id)
                : "eax", "ebx", "ecx", "edx");


This code reads the actual CPU features, regardless of vendor. Later th=
ese features are probed for a selected few, which include SSE 4.2.

Old, but interesting, related read: http://arstechnica.com/gadgets/2008=
/07/atom-nano-review/6/


With best regards / Pozdrawiam
Piotr Da=B3ek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
