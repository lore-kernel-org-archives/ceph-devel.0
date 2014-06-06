From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Locally repairable code description revisited (was Pyramid ...)
Date: Fri, 6 Jun 2014 11:46:23 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE730544@CERNXCHG44.cern.ch>
References: <538A0CF8.8030501@dachary.org>,<53907935.9010009@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:19421 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbaFFLq0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 07:46:26 -0400
In-Reply-To: <53907935.9010009@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,
the basic implementation looks very clean.

I have few comments/ideas:

- the reconstruction strategy using the three levels is certainly effic=
ient enough for standard cases but does not guarantee always the minimu=
m decoding (in cases where one layer is not enough to reconstruct) sinc=
e your third algorithm is just brute-force to reconstruct everything th=
rough all layers until we have what we need ...

- the whole LRC configuration actually does not describe the placement =
- it still looks disconnected from the placement strategy/crush rules .=
=2E. wouldn't it make sense to have the crush rule implicit in the desc=
ription or a function to derive it automatically based on the LRC confi=
guration? Maybe you have this already done in another way and I didn't =
see it ...

-  should the plug-in have the ability to select reconstruction on prox=
imity or this should be up-to the higher layer to provide chunks in a w=
ay that reconstruction would select the 'closest' layer? The relevance =
of the question you will understand better in the next point ....

- I remember we had this 3 data centre example with (8,4) where you can=
 reconstruct every object if 2 data centres are up. Another appealing e=
xample avoiding remote access when reading an object is that you have 2=
 data centres having a replication of e.g. (4,2) encoded objects. Can y=
ou describe in your LRC configuration language to store the same chunk =
twice like    __ABCCBA__ ?

Cheers Andreas.


________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 05 June 2014 16:05
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Re: Locally repairable code description revisited (was Pyramid=
 ...)

Hi Andreas,

Here is a preliminary implementation https://github.com/ceph/ceph/pull/=
1921 . It does not have tests yet, nor does it run but but it compiles =
and I think it makes sense. It is indeed simpler than the previous impl=
ementation.

It would be great if you could quickly browse

   https://github.com/dachary/ceph/commit/5661c72864eca04c5dac9494a3f7e=
7a13515fca6

and let me know if you have any concerns.

Cheers

On 31/05/2014 19:10, Loic Dachary wrote:
> Hi Andreas,
>
> After a few weeks and a fresh eye, I revisited the way pyramid erasur=
e code could be described by the system administrator. Here is a propos=
al that is hopefully more intuitive than the one from the last CDS ( ht=
tp://pad.ceph.com/p/cdsgiant-pyramid-erasure-code ).
>
> These are the steps to create all coding chunks. The upper case lette=
rs are data chunks and the lower case letters are coding chunks.
>
> "__ABC__DE_" data chunks placement
>
> Step 1
> "__ABC__DE_"
> "_yVWX_zYZ_" K=3D5, M=3D2
> "_aABC_bDE_"
>
> Step 2
> "_aABC_bDE_"
> "z_XYZ_____" K=3D3, M=3D1
> "caABC_bDE_"
>
> Step 3
> "caABC_bDE_"
> "_____zXYZ_" K=3D3, M=3D1
> "caABCdbDE_"
>
> Step 4
> "caABCdbDE_"
> "_____WXYZz" K=3D4, M=3D1
> "caABCdbDEe"
>
> The interpretation of Step 3 is as follows:
>
> Given the output of the previous step ( "caABC_bDE_" ), the bDE chunk=
s are considered to be data chunks at this stage and they are marked wi=
th XYZ. A K=3D3, M=3D1 coding chunk is calculated and placed in the chu=
nk marked with z ( "_____zXYZ_" ). The output of this coding step is th=
e previous step plus the coding chunk that was just calculated, named d=
 ( "caABCdbDE_" ).
>
> This gives the flexibility of deciding wether or not a coding chunk f=
rom a previous step is used as data to compute the coding chunk of the =
next step. It also allows for unbalanced steps such as step 4.
>
> For decoding, the steps are walked from the bottom up. If E is missin=
g, it can be reconstructed from dbD.e in step 4 and the other steps are=
 skipped because it was the only missing chunk. If AB are missing, all =
steps that have not be used to encode it are ignored, up to step 2 that=
 will fail to recover them because M=3D1 and yeild to step 1 that will =
use a..CbDE successfully because M=3D2.
>
> Giving up the recursion and favor iteration seems to simplify how it =
can be explained. And I suspect the implementation is also simpler. Wha=
t do you think ?
>
> Cheers
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
