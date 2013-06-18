From: James Plank <plank@cs.utk.edu>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Tue, 18 Jun 2013 10:22:31 -0400
Message-ID: <3E438C2F-0779-4824-9C05-ABE4B5803E05@cs.utk.edu>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local> <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local> <51C00FDB.6030803@polytech.univ-nantes.fr>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.eecs.utk.edu ([160.36.58.82]:48753 "EHLO
	smtp2.eecs.utk.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab3FRO3E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jun 2013 10:29:04 -0400
In-Reply-To: <51C00FDB.6030803@polytech.univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-1?Q?Beno=EEt_Parrein?= <benoit.parrein@polytech.univ-nantes.fr>
Cc: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>, Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all -- thank you for including me on this thread, although I have li=
ttle substantive to add.  At the moment, my sole focus is finishing a j=
ournal paper about GF implementations, with a concomitant GF-complete r=
elease to accompany it.  I agree that the CPU burden of the GF arithmet=
ic will not be a bottleneck in your system, regardless of which impleme=
ntation you use, as long as you stay at or below GF(2^16).  If you want=
 to go higher, GF-complete will help.  When we put out a new release (t=
he code will be ready within two weeks, however, the documentation is l=
agging), I'll let you know.  I think LRC is a nice coding paradigm, alt=
hough I imagine that it has IP issues with Microsoft.  I don't have fir=
st-hand experience with network/regenerating codes, and I'll be honest =
-- there have been so many papers in that realm that I am not up to dat=
e on them.

Is there a question on which you'd like some help?  It sounds as though=
 you are at two decision points: What code should you use, and at which=
 point on the space-overhead/fault-tolerance curve would you like to be=
?

Best wishes,

Jim
----------

On Jun 18, 2013, at 3:44 AM, Beno=EEt Parrein wrote:

> Hi Paul,
>=20
> thank you for your message
>=20
> from my point, LRC focuses on the repairing problem. how to reconstru=
ct destroyed node to maintain the same availability by the distributed =
system?
> in this context they can even go below 1x rate by introducing local p=
arity on classical Reed Solomon blocks (but they pay a supplementary ov=
erhead). see excellent Alex Dimakis's papers for that. but, still from =
my point, the same relationship between redundancy and availability occ=
urs (if you consider binomial model for your loses).
>=20
> best
> bp
>=20
>=20
> Le 17/06/2013 18:55, Paul Von-Stamwitz a =E9crit :
>> Loic,
>>=20
>> As Benoit points out, Mojette uses discrete geometry rather than alg=
ebra, so simple XOR is all that is needed.
>>=20
>> Benoit,
>>=20
>> Microsoft's paper states that their [12,2,2] LRC provides better ava=
ilability than 3x replication with 1.33x efficiency. 1.5x is certainly =
a good number. I'm just pointing out that better efficiency can be had =
without losing availibity.
>>=20
>> All the best,
>> Paul
>=20
> <benoit_parrein.vcf>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
