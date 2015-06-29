From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: CRC32 of messages
Date: Mon, 29 Jun 2015 07:00:50 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB05D9@SACMBXIP01.sdcorp.global.sandisk.com>
References: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDAE1C3@SACMBXIP01.sdcorp.global.sandisk.com>
 <90559C83A9C7FA45B5846C975DFA612DDB4C4DC44D@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0092.outbound.protection.outlook.com ([157.56.111.92]:39456
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750809AbbF2HAy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 03:00:54 -0400
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB4C4DC44D@ABGEX73E.FSC.NET>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Piotr for the info, but I am not sure the asm instructions ceph =
is using for probing cpu is compatible to AMD or not.

Regards
Somnath

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Dalek, Piotr
Sent: Sunday, June 28, 2015 11:27 PM
To: ceph-devel@vger.kernel.org
Subject: RE: CRC32 of messages

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Somnath Roy
> Sent: Friday, June 26, 2015 7:52 PM
>
> ceph_crc32c_intel_fast is ~6 times faster than ceph_crc32c_sctp. If
> you are not using intel cpus or you have older intel cpus where this
> sse4 instruction

Not exactly true, AMD CPUs released after October 2011 support SSE 4.2 =
(which include CRC32 instructions) as well.
See this: http://www.cpu-world.com/Glossary/S/SSE4.2.html

With best regards / Pozdrawiam
Piotr Da=B3ek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
