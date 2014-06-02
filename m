From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Pyramid erasure code description revisited
Date: Mon, 2 Jun 2014 12:20:37 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE72E354@CERNXCHG44.cern.ch>
References: <538A0CF8.8030501@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:26334 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145AbaFBMUm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 08:20:42 -0400
In-Reply-To: <538A0CF8.8030501@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20

I think this gives all the flexibility to define any possible combinati=
on for encoding ...

When one constructs the steps one has just to be aware that the 'most l=
ocal' encoding should happen in the end, right?

It would be usefule to have a tool which outputs then for each data aND=
 parity chunk the achieved 'redundancy' and the overall volume and maxi=
mal reconstruction 'overhead'.

Cheers Andreas.

________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 31 May 2014 19:10
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Pyramid erasure code description revisited

Hi Andreas,

After a few weeks and a fresh eye, I revisited the way pyramid erasure =
code could be described by the system administrator. Here is a proposal=
 that is hopefully more intuitive than the one from the last CDS ( http=
://pad.ceph.com/p/cdsgiant-pyramid-erasure-code ).

These are the steps to create all coding chunks. The upper case letters=
 are data chunks and the lower case letters are coding chunks.

"__ABC__DE_" data chunks placement

Step 1
"__ABC__DE_"
"_yVWX_zYZ_" K=3D5, M=3D2
"_aABC_bDE_"

Step 2
"_aABC_bDE_"
"z_XYZ_____" K=3D3, M=3D1
"caABC_bDE_"

Step 3
"caABC_bDE_"
"_____zXYZ_" K=3D3, M=3D1
"caABCdbDE_"

Step 4
"caABCdbDE_"
"_____WXYZz" K=3D4, M=3D1
"caABCdbDEe"

The interpretation of Step 3 is as follows:

Given the output of the previous step ( "caABC_bDE_" ), the bDE chunks =
are considered to be data chunks at this stage and they are marked with=
 XYZ. A K=3D3, M=3D1 coding chunk is calculated and placed in the chunk=
 marked with z ( "_____zXYZ_" ). The output of this coding step is the =
previous step plus the coding chunk that was just calculated, named d (=
 "caABCdbDE_" ).

This gives the flexibility of deciding wether or not a coding chunk fro=
m a previous step is used as data to compute the coding chunk of the ne=
xt step. It also allows for unbalanced steps such as step 4.

=46or decoding, the steps are walked from the bottom up. If E is missin=
g, it can be reconstructed from dbD.e in step 4 and the other steps are=
 skipped because it was the only missing chunk. If AB are missing, all =
steps that have not be used to encode it are ignored, up to step 2 that=
 will fail to recover them because M=3D1 and yeild to step 1 that will =
use a..CbDE successfully because M=3D2.

Giving up the recursion and favor iteration seems to simplify how it ca=
n be explained. And I suspect the implementation is also simpler. What =
do you think ?

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
