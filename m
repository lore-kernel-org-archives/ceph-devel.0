From: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Subject: RE: Comments on Ceph distributed parity implementation
Date: Fri, 14 Jun 2013 18:12:23 -0700
Message-ID: <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fujitsu25.fnanic.fujitsu.com ([192.240.6.15]:41810 "EHLO
	fujitsu25.fnanic.fujitsu.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753097Ab3FOBUU convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Jun 2013 21:20:20 -0400
In-Reply-To: <51BB9FC3.8040102@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Martin Flyvbjerg <martinflyvbjerg@gmx.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic and Martin,

This is a great discussion and I agree that the performance ramificatio=
ns of erasure coding need to be thought out very carefully. Since chunk=
s are not only encoded, but distributed across the cluster, we need to =
pay attention to the network overhead as well as the arithmetic involve=
d in the encoding/decoding.

If I understand the proposal correctly, objects begin their life's jour=
ney replicated as normal. As it grows cold, it gets transformed to an e=
ncode PG in another pool. Subsequent reads will be redirected (ehh). Su=
bsequent writes will first decode the original object and re-replicate =
it (ouch!). Client writes never are encoded on the fly; they are always=
 replicated (nice).

So...
encode() is run as a low-priority background process probably once a we=
ek during deep scrubs.
decode() should be rare (if not, the object shouldn't have been encoded=
 in the first place.) If the cluster is healthy no arithmetic is needed=
, just concatenation, but a lot of network activity.
repair() operations will be the most prevalent and may occur at any tim=
e during normal self-healing/rebalancing operations.

Therefore, in my opinion, the algorithm that we choose must be optimize=
d for repairing damaged and missing chunks. The main problem I have wit=
h Reed-Solomon is that it uses MDS codes which maximize network activit=
y for recalculations. Pyramid codes have the same write (encode) overhe=
ad, but have better read (repair) overhead.

Loic, I know nothing about Mojette Transforms. From what little I glean=
ed, it might be good for repair (needing only a subset of chunks within=
 a range to recalculate a missing chunk) but I'm worried about the stor=
age efficiency. RozoFS claims 1.5x. I'd like to do better than that.

All the best,
Paul

On 06/14/2013 3:57 PM, Loic Dachary wrote:
> Hi Martin,
>=20
> Your explanations are very helpful to better understand the tradeoffs=
 of
> the existing implementations. To be honest I was looking forward to y=
our
> intervention. Not you specifically, of course :-) But someone with a =
good
> theoretical background to be a judge of what's best in the context of=
 Ceph.
> If you say it's the upcoming library to be released in August 2013, I=
'll
> take your word for it.
>=20
> The work currently being done within Ceph is to architecture to stora=
ge
> backend ( namely placement groups ) to make room for distributed pari=
ty.
> My initial idea was to isolate the low level library under an API tha=
t
> takes a region ( 16KB for instance, as in gf_unit.c found in
> http://web.eecs.utk.edu/~plank/plank/papers/CS-13-
> 703/gf_complete_0.1.tar ) as input and outputs chunks that can then b=
e
> written on different hosts. For instance
>=20
> 	encode(char* region, char** chuncks) =3D> encode the region into N
> chuncks
> 	decode(char** chunks, char* region) =3D> decode the N chuncks into a
> region
>         repair(char** chunks, int damaged) =3D> repair the damaged ch=
unck
>=20
> Do you think it is a sensible approach ? And if you do, will I find
> examples of such higher level functions in
> http://web.eecs.utk.edu/~plank/plank/papers/CS-13-
> 703/gf_complete_0.1.tar ? Or elsewhere ?
>=20
> I'm a little confused about the relation between GF complete ( as fou=
nd at
> http://web.eecs.utk.edu/~plank/plank/papers/CS-13-
> 703/gf_complete_0.1.tar ) which is very recent ( 2013 ) and Jerasure =
( as
> found at http://web.eecs.utk.edu/~plank/plank/papers/CS-08-627/Jerasu=
re-
> 1.2.tar )  which is comparatively older ( 2008 ). Do you know how Jer=
asure
> 2.0 relates to GF complete ?
>=20
> For completeness, here is a thread with pointers to Mojette Transform
> that's being used as part of Rozofs.
>=20
> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg14666.html
>=20
> I'm not able to compare it with the other libraries because it seems =
to
> take a completely different approach. Do you have an opinion about it=
 ?
>=20
> As Patrick mentioned, I'll be at http://www.oscon.com/oscon2013 next =
month
> but I'd love to understand more about this as soon as possible :-)
>=20
> Cheers
>=20
> P.S. Updated
> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encodin=
g_as_
> a_storage_backend#Erasure_Encoded_Storage with a link to
> http://web.eecs.utk.edu/~plank/plank/www/software.html for the record
>=20
> On 06/14/2013 10:13 PM, Martin Flyvbjerg wrote:
> > Dear Community
> > I am a young engineer (not software or math, please bare with me) w=
ith
> some suggestions regarding erasure codes. I never used Ceph before or=
 any
> other distributed file system.
> >
> > I stumped upon the suggestion for adding erasure codes to Ceph, as
> > described in this article
> >
> http://wiki.Ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encodin=
g_as_
> a_storage_backend
> >
> > first I would like to say great initiative to add erasure codes to =
Ceph.
> > Ceph needs its own implementation and it have to be done right, I c=
annot
> stress this enough, suggested software mentioned in that article woul=
d
> result in very low performance.
> >
> > Why?
> > Reed-Solomon is normally something regarded as being very slow comp=
ared
> to other erasure codes, because the underlying Galois-Field multiplic=
ation
> is slow. Please see video at usenix.org forexplanation.
> >
> > The implementations of Zfec library and other suggested software th=
e
> others rely on the Vandermonde matrix, a matrix used in in Reed-Solom=
on
> erasure codes, a faster approach would be to use the Cauchy-Reed-Solo=
mon
> implementation. Please see [1,2,3]
> > Although there is something even better, by using the Intel SSE2/3 =
SIMD
> instructions it is possible to do the as fast as any other XOR based
> erasure codes (RaptorQ LT-codes, LDPC etc.).
> >
> > The suggested FECpp lib uses the optimisation but with a relative s=
mall
> Galois-field only 2^8, since Ceph aimes at unlimited scalability
> increasing the size of the Galois-Field would improve performance [4]=
=2E Of
> course the configured Ceph Object Size and/or Stripe width have to be
> taken into account.
> > Please see
> > https://www.usenix.org/conference/fast13/screaming-fast-galois-fiel=
d-
> arithmetic-using-sse2-extensions
> >
> >
> > The solution
> > Using the GF-Complete open source library [4] to implement Reed-Sol=
omon
> in Ceph in order to allow Ceph to scale to infinity.
> > James S. Plank the author of GF-complete have developed a library
> implementing various Reed-Solomon codes called Jerasure.
> http://web.eecs.utk.edu/~plank/plank/www/software.html
> > Jerasure 2.0 using the GF-complete artimetric based in Intel SSE SI=
MD
> instructions, is current in development expected release august 2013.=
 Will
> be released under the new BSD license. Jerasure 2.0 also supports
> arbitrary Galois-field sizes 8,16,32,64 or 128 bit.
> >
> > The limit of this implementation would be the processors L2/L3 cach=
e not
> the underlying arithmetic.
> >
> > Best Regards
> > Martin Flyvbjerg
> >
> > [1] http://web.eecs.utk.edu/~plank/plank/papers/CS-05-569.pdf
> > [2] http://web.eecs.utk.edu/~plank/plank/papers/CS-08-625.pdf
> > [3] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2009.pdf
> > [4] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2013-GF.pdf
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do
> nothing.
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
