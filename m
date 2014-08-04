From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: ISA erasure code plugin and cache
Date: Mon, 4 Aug 2014 12:43:44 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE75817C@CERNXCHG43.cern.ch>
References: <53DF750B.6080107@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4AE75711F@CERNXCHG43.cern.ch>,<53DF7E7A.5040509@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:14985 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbaHDMnr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 08:43:47 -0400
In-Reply-To: <53DF7E7A.5040509@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20

the size of a table is k*(m+k) * 32 e.g. ~4k for a (10,4) codec.

The size to store all possible decoding tables of (10,4) is few MB - th=
is matters if you have it 200 times duplicated ...

Cheers Andreas.
=20

________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 04 August 2014 14:37
To: Andreas Joachim Peters
Cc: Ma, Jianpeng; Ceph Development
Subject: Re: ISA erasure code plugin and cache

On 04/08/2014 14:15, Andreas Joachim Peters wrote:> Hi Loic,
>
> the background relevant to your comments have (unfortunately) never b=
een answered on the mailing list.
>
> The cache is written in a way, that it is useful for a fixed (k,m) co=
mbination and thread-safe.
>
> So, if there is one instance of the plugin per pool, it is the right =
implementation. If there is (as you write) one instance for each PG in =
any pool, it is sort of 'stupid' because the same encoding table is sto=
red for each PG seperatly.

I would not called it stupid ;-) Just not as efficient as if the cache =
was by all PGs. Without cache the decode table has to be calculated for=
 each object in the placement group and there are a lot of objects. The=
 table may be duplicated hundreds of time so it has an impact on the me=
mory footprint, but it should not have a visible impact on the decode p=
erformances. An optimisation of your implementation to save memory woul=
d be nice, but it is not critical.

How large are the decode tables ?

> So if the final statement is to create one plugin instance per PG, I =
will change it accordingly and shared encoding & decoding tables for a =
fixed (k,m), if not it can stay.
>
> Just need to know that ... this boils down to the fact, that encoding=
 & decoding should not be considered 'stateless'.
>
> Cheers Andreas.
>
>
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 04 August 2014 13:56
> To: Andreas Joachim Peters
> Cc: Ma, Jianpeng; Ceph Development
> Subject: ISA erasure code plugin and cache
>
> Hi,
>
> Here is how I understand the current code:
>
> When an OSD is missing, recovery is required and the primary OSD will=
 collect the available chunks to do so. It will then call the decode me=
thod via ECUtil::decode which is a small wrapper around the correspondi=
ng ErasureCodeInterface::decode method.
>
>    https://github.com/ceph/ceph/blob/master/src/osd/ECBackend.cc#L361
>
> The ISA plugin will then use the isa_decode method to perform the wor=
k
>
>    https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Eras=
ureCodeIsa.cc#L212
>
> and will be repeatedly called until all objects in the PGs that were =
relying on the missing OSD are recovered. To avoid computing the decodi=
ng table for each object, it is stored in a LRU cache
>
>    https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Eras=
ureCodeIsa.cc#L480
>
> and copied in the stack if already there:
>
>    https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Eras=
ureCodeIsa.cc#L433
>
> Each PG has a separate instance of ErasureCodeIsa, obtained when it i=
s created:
>
>    https://github.com/ceph/ceph/blob/master/src/osd/PGBackend.cc#L292
>
> It means that data members of each ErasureCodeIsa are copied as many =
times as there are PGs. If an OSD handles participates in 200 PG that b=
elong to an erasure coded pool configured to use ErasureCodeIsa, the da=
ta members will be duplicated 200 times.
>
> It is good practice to make it so that the encode/decode methods of E=
rasureCodeIsa are thread safe. In the jerasure plugin these methods hav=
e no side effect on the object. In the isa plugin the LRU cache storing=
 the decode tables is modified by the decode method and guarded by a mu=
tex:
>
>    get https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/=
ErasureCodeIsa.cc#L281
>    put https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/=
ErasureCodeIsa.cc#L310
>
> Please correct me if I'm mistaken ;-) I've not reviewed the code yet =
and try to find problems, I just wanted to make sure I get the intentio=
n before doing so.
>
> Cheers
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
