From: =?ISO-8859-1?Q?Beno=EEt_Parrein?=
	<benoit.parrein@polytech.univ-nantes.fr>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Mon, 17 Jun 2013 18:48:51 +0200
Message-ID: <51BF3DF3.80407@polytech.univ-nantes.fr>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local> <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040102070709000004040002"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-loi.cpub.univ-nantes.fr ([193.52.103.112]:35532 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753362Ab3FQRAD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jun 2013 13:00:03 -0400
In-Reply-To: <51BE2EB1.2020807@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org, "James S. Plank" <plank@cs.utk.edu>

This is a multi-part message in MIME format.
--------------040102070709000004040002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Loïc,

totaly agree about performances. honestly, we don't experiment yet any 
trouble in our erasure coding implementation (which is just software 
optimized for the moment). the bottleneck is more located at the network 
(basically at 1Gbit/s) and at the disks i/o levels. and, I guess it is 
the same conclusion for well optimized libraries like Jerasure.
to continue about Mojette transform, this erasure code is in fact 
(1+epsilon)MDS with a linear complexity both in coding and decoding (we 
just need addition and subtraction in any field). furthermore, it is 
well implemented in RozoFS. th epsilon (the overhead) is very negligible 
for normal use cases.

best,
bp


Le 16/06/2013 23:31, Loic Dachary a écrit :
> Hi Benoît,
>
>  From the ( naïve ) point of view of engineering, performances are important. The recent works of James Plank ( cc'ed ) greatly improved them
>   and I'm looking forward to the next version of jerasure ( http://web.eecs.utk.edu/~plank/plank/papers/CS-08-627.html ). Rozofs Mojette Transform implementation ( https://github.com/rozofs/rozofs/blob/master/rozofs/common/transform.h & https://github.com/rozofs/rozofs/blob/master/rozofs/common/transform.cc ) does not seem to make use of SIMD. Is it because the performances are good enough to not require them ?
>
> Cheers
>
> On 06/16/2013 09:51 PM, Benoît Parrein wrote:
>> Paul Von-Stamwitz <PVonStamwitz <at> us.fujitsu.com> writes:
>>
>> Hi Paul,
>>
>>> Loic, I know nothing about Mojette Transforms. From what little I gleaned,
>> it might be good for repair
>>> (needing only a subset of chunks within a range to recalculate a missing
>> chunk) but I'm worried about the
>>> storage efficiency. RozoFS claims 1.5x. I'd like to do better than that.
>>>
>>> All the best,
>>> Paul
>>>
>> If you want to do better than that you will probably lose in availability.
>> 1.5x give the same availability than 3 replicats and that for any kind of
>> erasure coding.
>> FYI, Mojette transform has no constraint in terms of Galois fields. It is the
>> big advantage to use discrete geometry rather than algebra.
>>
>> best regards,
>> bp
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------040102070709000004040002
Content-Type: text/x-vcard; charset=utf-8;
 name="benoit_parrein.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="benoit_parrein.vcf"

begin:vcard
fn;quoted-printable:Beno=C3=AEt Parrein
n;quoted-printable:Parrein;Beno=C3=AEt
org;quoted-printable:Polytech Nantes, Universit=C3=A9 de Nantes, IRCCyN lab
adr;quoted-printable:;;=C3=A9quipe Image Vid=C3=A9o Communication;;;;France
email;internet:benoit.parrein@polytech.univ-nantes.fr
title;quoted-printable:Ma=C3=AEtre de Conf=C3=A9rences
tel;work:+33 2 40 68 30 50
version:2.1
end:vcard


--------------040102070709000004040002--
