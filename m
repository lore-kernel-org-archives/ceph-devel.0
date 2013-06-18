From: =?ISO-8859-1?Q?Beno=EEt_Parrein?=
	<benoit.parrein@polytech.univ-nantes.fr>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Tue, 18 Jun 2013 09:44:27 +0200
Message-ID: <51C00FDB.6030803@polytech.univ-nantes.fr>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local> <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070604050509070301030800"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-loi.cpub.univ-nantes.fr ([193.52.103.112]:42962 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752186Ab3FRHoa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jun 2013 03:44:30 -0400
In-Reply-To: <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "James S. Plank" <plank@cs.utk.edu>

This is a multi-part message in MIME format.
--------------070604050509070301030800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paul,

thank you for your message

from my point, LRC focuses on the repairing problem. how to reconstruct 
destroyed node to maintain the same availability by the distributed system?
in this context they can even go below 1x rate by introducing local 
parity on classical Reed Solomon blocks (but they pay a supplementary 
overhead). see excellent Alex Dimakis's papers for that. but, still from 
my point, the same relationship between redundancy and availability 
occurs (if you consider binomial model for your loses).

best
bp


Le 17/06/2013 18:55, Paul Von-Stamwitz a écrit :
> Loic,
>
> As Benoit points out, Mojette uses discrete geometry rather than algebra, so simple XOR is all that is needed.
>
> Benoit,
>
> Microsoft's paper states that their [12,2,2] LRC provides better availability than 3x replication with 1.33x efficiency. 1.5x is certainly a good number. I'm just pointing out that better efficiency can be had without losing availibity.
>
> All the best,
> Paul


--------------070604050509070301030800
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


--------------070604050509070301030800--
