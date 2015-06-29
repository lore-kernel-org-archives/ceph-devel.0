From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: CRC32 of messages
Date: Mon, 29 Jun 2015 08:31:56 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB4C4DC457@ABGEX73E.FSC.NET>
References: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:44677 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbbF2GcA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 02:32:00 -0400
In-Reply-To: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Erik G. Burrows
> Sent: Friday, June 26, 2015 6:49 PM
>=20
> All,
> Can someone explain to me the rationale for performing in-software CR=
C32
> hashes of all messages through the Pipe and AsyncMessage classes?
>=20
> On my servers, operf shows that 20% of the total CPU time in my bench=
mark
> tests are being spent in the librados ceph_crc32c_sctp function. I ca=
n see that
> the library is trying to use CPU accelerations if available, but what=
 I'd like to
> understand is: why checksum the messages at all?

As Somnath already wrote, you can disable CRC checking for messages. Bu=
t they're also used for journals, among other things, so you'll always =
see some CPU usage spent on CRC32 calculations.

> If the messages are local, there should not be any corruption at all,=
 and if
> they are coming in over IP, then the kernel and NIC should do Layer-2=
/3 CRCs
> and reject any corrupted packets. So why re-CRC the messages at the C=
eph
> layer?

I can imagine data corruption coming from Ceph itself and not caught by=
 IP layers, for example due to bug in Ceph code or mainboard/RAM failur=
e. And it's a nice debug feature you can use when dealing with low-leve=
l code.

With best regards / Pozdrawiam
Piotr Da=B3ek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
