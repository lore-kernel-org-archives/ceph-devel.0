From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: EC backend benchmark
Date: Mon, 11 May 2015 22:11:10 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8A4FA@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8A41B@SACMBXIP01.sdcorp.global.sandisk.com>
 <555126F3.1050607@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0080.outbound.protection.outlook.com ([157.56.111.80]:38700
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751530AbbEKWNw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 18:13:52 -0400
In-Reply-To: <555126F3.1050607@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

Thanks Loic..
<< inline

Regards
Somnath
-----Original Message-----
=46rom: Loic Dachary [mailto:loic@dachary.org]
Sent: Monday, May 11, 2015 3:02 PM
To: Somnath Roy
Cc: ceph-users@lists.ceph.com; Ceph Development
Subject: Re: EC backend benchmark

Hi,
[Sorry I missed the body of your questions, here is my answer ;-]

On 11/05/2015 23:13, Somnath Roy wrote:> Summary :
>
> -------------
>
>
>
> 1. It is doing pretty good in Reads and 4 Rados Bench clients are sat=
urating 40 GB network. With more physical server, it is scaling almost =
linearly and saturating 40 GbE on both the host.
>
>
>
> 2. As suspected with Ceph, problem is again with writes. Throughput w=
ise it is beating replicated pools in significant numbers. But, it is n=
ot scaling with multiple clients and not saturating anything.
>
>
>
>
>
> So, my question is the following.
>
>
>
> 1. Probably, nothing to do with EC backend, we are suffering because =
of filestore inefficiencies. Do you think any tunable like EC stipe siz=
e (or anything else) will help here ?

I think Mark Nelson would be in a better position that me to answer as =
he has conducted many experiments with erasure coded pools.

[Somnath] Sure, Mark, any insight  ? :-)

> 2. I couldn't make fault domain as 'host', because of HW limitation. =
Do you think will that play a role in performance for bigger k values ?

I don't see a reason why there would be a direct relationship between t=
he failure domain and the values of k. Do you have a specific example i=
n mind ?

[Somnath] Nope, other than more network hops..If failure domain is OSD,=
 more than one chunks could be within a host...But, since I have 40GbE =
and not saturating network BW (for bigger cluster that probability is l=
ess), IMO it shouldn't matter. I thought of checking with you.

> 3. Even though it is not saturating 40 GbE for writes, do you think s=
eparating out public/private network will help in terms of performance =
?

I don't think so. What is the bottleneck ? CPU or disk I/O ?

[Somnath] For write, no resources (cpu/network/disk) are saturating.

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre



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
