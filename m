From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: Inline dedup/compression
Date: Thu, 2 Jul 2015 11:34:34 -0400 (EDT)
Message-ID: <445939313.53.1435851274972.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1840766443.51.1435851210328.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2223 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbbGBPeq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jul 2015 11:34:46 -0400
In-Reply-To: <1840766443.51.1435851210328.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Haomai Wang <haomaiwang@gmail.com>

Hi Chaitanya,

Have you ruled out variants using fixed chunksize?  (Arguments for/agai=
nst
fingerprinting elided.)

Matt

----- "Chaitanya Huilgol" <Chaitanya.Huilgol@sandisk.com> wrote:

> Hi James et.al ,
>=20
> Here is an example for clarity,=20
> 1. Client Writes object  object.abcd
> 2. Based on the crush rules, say  OSD.a is the primary OSD which
> receives the write
> 3. OSD.a  performs segmenting/fingerprinting which can be static or
> dynamic and generates a list of segments, the object.abcd is now
> represented by a manifest object with the list of segment hash and
> len
>  [Header]=20
>  [Seg1_sha, len]
>  [Seg2_sha, len]
>  ...
>  [Seg3_sha, len]
> 4. OSD.a writes each segment as a new object in the cluster with
> object name  <reserved_dedupe_perfix><sha>
> 5. The dedupe object write is treated differently from regular object
> writes, If the object is present then an object reference count is
> incremented and the object is not overwritten - this forms the basis
> of the dedupe logic. Multiple objects with one or more same
> constituent segments start sharing the segment objects.
> 6. Once all the segments are successfully written the object
> 'object.abcd' is now just a stub object with the segment manifest as
> described above and is goes through a regular object write sequence=20
>=20
> Partial writes on objects will be complicated,
> - Partially affected segments will have to be read and segmentation
> logic has to be run from first to last affected segment boundaries
> -  New segments will be written =20
> - Old overwritten segments have to be deleted
> - Write merged manifest of the object=20
>=20
> All this will need protection of the PG lock, Also additional
> journaling mechanism will be needed to  recover from cases where the
> osd goes down before writing all the segments.=20
>=20
> Since this is quite a lot of processing, a better use case for this
> dedupe mechanism would be in the data tiering model with object
> redirects.
> The manifest object fits quiet well into object redirects scheme of
> things, the idea is that, when an object is moved out of the base
> tier, you have an option to create a dedupe stub object and write
> individual segments into the cold backend tier with a rados plugin.=20
>=20
> Remaining responses inline.
>=20
> Regards,
> Chaitanya
>=20
> -----Original Message-----
> From: James (Fei) Liu-SSI [mailto:james.liu@ssi.samsung.com]=20
> Sent: Wednesday, July 01, 2015 4:00 AM
> To: Chaitanya Huilgol; Allen Samuels; Haomai Wang
> Cc: ceph-devel
> Subject: RE: Inline dedup/compression
>=20
> Hi Chaitanya,
>    Very interesting thoughts. I am not sure whether I get all of them
> or now. Here are several questions for the solution you provided,
> Might be a little bit detailed.
>=20
>     Regards,
>     James
>=20
> - Dedupe is set as a pool property
> Write:
> - Write arrives at the primary OSD/pg
> [James] Does the OSD/PG mean PG Backend over here?=20
> [Chaitanya] I mean the Primary OSD and the PG which get selected by
> the crush - not the specific OSD component
>=20
> - Data is segmented (rabin/static) and secure hash computed [James]
> Which component in OSD are you going to do the data segment and hash
> computation?
> [Chaitanya] If partial writes are not supported then this could be
> down before acquiring the PG lock, else we need the protection of the
> PG lock.  Probably in the do_request() path?
>=20
> - A manifest is created with the offset/len/hash for all the segments
> [James] The manifest is going to be part of xattr of object? Where ar=
e
> you going to save manifest?
> [Chaitanya] The manifest is a stub object with the constituent
> segments list=20
>=20
> - OSD/pg sends rados write with a special name
> <__known__prefix><secure hash> for all segments [James] What's your
> meaning of Rados Wirte?  Where do the all segments with secure hash
> signature write to?
> [Chaitanya] All segments are unique objects with the above mentioned
> naming scheme, they get written back into the cluster as a regular
> client rados object write
>=20
> - PG receiving dedup write will:
>         1. check for object presence and create object if not present
>         2. If object is already present, then an reference count is
> incremented (check and increment needs to be atomic) [James] It makes
> sense. But I was wondering the unit for dedupe is segment or object?
> If object base, it totally make sense. However, why we need to have
> segment with manifest?
>=20
> - Response is received by original primary PG for all segments [James=
]
> What response?
> [Chaitanya] Write response indicating the status of the segment objec=
t
> write
>=20
> - Primary PG writes the manifest to local and replicas or EC members
> [James] How about the dedupe data if the data is not present in
> replicas?
> [Chaitanya] I am sorry, I did not get your question, the manifest
> object gets written in the primary and the replicas or encoded and
> written to the EC members, it is afforded the protection policy set
> for the pool. Same is the case with the individual constituent
> segments. =20
> =20
> - Response sent to client
>=20
> Read:
> - Read received at primary PG
> [James]  The read can only fetch data from Primary PG?
> - Reads manifest object
>=20
> - sends reads for each segment object <__know_prefix><secure hash>
> - coalesces all the response to build the required data
> - Responds to client
>=20
>=20
> Pros:
> No need of centralized hash index so inline with ceph no bottleneck
> philosophy
>=20
> Cons:
> Some PGs may get overloaded due to frequently occurring segment
> patterns Latency and increased traffic on the network
>   =20
>=20
>=20
> -----Original Message-----
> From: Chaitanya Huilgol [mailto:Chaitanya.Huilgol@sandisk.com]
> Sent: Tuesday, June 30, 2015 8:50 AM
> To: Allen Samuels; James (Fei) Liu-SSI; Haomai Wang
> Cc: ceph-devel
> Subject: RE: Inline dedup/compression
>=20
>=20
> - Reference count has to be maintained as an attribute of the object
> - As mentioned in the write workflow, duplicate segment writes
> increment the reference count
> - Object Delete would result in delete on constituent segments listed
> in the object segment manifest
> - Segment object delete will decrement reference count and remove the
> segment when there are no more references present=20
>=20
> Regards,
> Chaitanya
>=20
> -----Original Message-----
> From: Allen Samuels
> Sent: Tuesday, June 30, 2015 9:02 PM
> To: Chaitanya Huilgol; James (Fei) Liu-SSI; Haomai Wang
> Cc: ceph-devel
> Subject: RE: Inline dedup/compression
>=20
> This covers the read and write, what about the delete? One of the
> major issues with Dedupe, whether global or local is to address the
> inherent ref-counting associated with sharing of pieces of storage.
>=20
> Allen Samuels
> Software Architect, Emerging Storage Solutions=20
>=20
> 2880 Junction Avenue, Milpitas, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Chaitanya
> Huilgol
> Sent: Monday, June 29, 2015 11:20 PM
> To: James (Fei) Liu-SSI; Haomai Wang
> Cc: ceph-devel
> Subject: RE: Inline dedup/compression
>=20
> Below is an alternative idea at a very high level around dedup with
> ceph without a need of centralized hash index,
>=20
> - Dedupe is set as a pool property
> Write:
> - Write arrives at the primary OSD/pg
> - Data is segmented (rabin/static) and secure hash computed
> - A manifest is created with the offset/len/hash for all the segments
> - OSD/pg sends rados write with a special name
> <__known__prefix><secure hash> for all segments
> - PG receiving dedup write will:
>         1. check for object presence and create object if not present
>         2. If object is already present, then an reference count is
> incremented (check and increment needs to be atomic)
> - Response is received by original primary PG for all segments
> - Primary PG writes the manifest to local and replicas or EC members
> - Response sent to client
>=20
> Read:
> - Read received at primary PG
> - Reads manifest object
> - sends reads for each segment object <__know_prefix><secure hash>
> - coalesces all the response to build the required data
> - Responds to client
>=20
>=20
> Pros:
> No need of centralized hash index so inline with ceph no bottleneck
> philosophy
>=20
> Cons:
> Some PGs may get overloaded due to frequently occurring segment
> patterns Latency and increased traffic on the network
>=20
> Regards,
> Chaitanya
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of James (Fei)
> Liu-SSI
> Sent: Tuesday, June 30, 2015 2:25 AM
> To: Haomai Wang
> Cc: ceph-devel
> Subject: RE: Inline dedup/compression
>=20
> Hi Haomai,
>   Thanks for moving the idea forward. Regarding to the compression.=20
> However,  if we do compression on the client level, it is not global.
> And the compression was only applied to the local client, am I right?=
=20
> I think there is pros and cons in two solutions and we can get into
> details more for each solution.
>   I really like your idea for dedupe in OSD side   by the way. Let me
> think more about it.
>=20
>  Regards,
>  James
>=20
> -----Original Message-----
> From: Haomai Wang [mailto:haomaiwang@gmail.com]
> Sent: Friday, June 26, 2015 8:55 PM
> To: James (Fei) Liu-SSI
> Cc: ceph-devel
> Subject: Re: Inline dedup/compression
>=20
> On Sat, Jun 27, 2015 at 2:03 AM, James (Fei) Liu-SSI
> <james.liu@ssi.samsung.com> wrote:
> > Hi Haomai,
> >   Thanks for your response as always. I agree compression is
> comparable easier task but still very challenge in terms of
> implementation no matter where we should implement . Client side like
> RBD, or RDBGW or CephFS, or PG should be a little bit better place to
> implementation in terms of efficiency and cost reduction before the
> data were duplicated to other OSDs. It has  two reasons :
> > 1. Keep the data consistency among OSDs in one PG 2. Saving the=20
> > computing resources
> >
> > IMHO , The compression should be accomplished before the replicatio=
n
> come into play in pool level. However, we can also have second level
> of compression in the local objectstore.  In term of unit size of
> compression , It really depends workload and in which layer we should
> implement.
> >
> > About inline deduplication, it will dramatically increase the
> complexities if we bring in the replication and Erasure Coding for
> consideration.
> >
> > However, Before we talk about implementation, It would be great if
> we can understand the pros and cons to implement inline
> dedupe/compression. We all understand the benefits of
> dedupe/compression. However, the side effect is performance hurt and
> need more computing resources. It would be great if we can understand
> the problems from 30,000 feet high for the whole picture about the
> Ceph. Please correct me if I were wrong.
>=20
> Actually we may have some tricks to reduce performance hurt like
> compression. As Joe mentioned, we can compress slave pg data to avoid
> performance hurt, but it may increase the complexity of recovery and
> pg remap things. Another in-detail implement way if we begin to
> compress data from messenger, osd thread and pg thread won't access
> data for normal client op, so maybe we can make it parallel with pg
> process. Journal thread will get the compressed data at last.
>=20
> The effect of compression also is a concern, we do compression in
> rados may not get the best compression result. If we can do
> compression in libcephfs, librbd and radosgw and make rados unknown t=
o
> compression, it maybe simpler and we can get file/block/object level
> compression. it should be better?
>=20
> About dedup, my current idea is we could setup a memory pool at osd
> side for checksum store usage. Then we calculate object data and map
> to PG instead of object name at client side, so a object could always
> in a osd where it's also responsible for dedup storage. It also could
> be distributed at pool level.
>=20
>=20
> >
> > By the way, Both of software defined storage solution startups like
> Hdevig and Springpath provide inline dedupe/compression.  It is not
> apple to apple comparison. But it is good reference. The datacenters
> need cost effective solution.
> >
> > Regards,
> > James
> >
> >
> >
> > -----Original Message-----
> > From: Haomai Wang [mailto:haomaiwang@gmail.com]
> > Sent: Thursday, June 25, 2015 8:08 PM
> > To: James (Fei) Liu-SSI
> > Cc: ceph-devel
> > Subject: Re: Inline dedup/compression
> >
> > On Fri, Jun 26, 2015 at 6:01 AM, James (Fei) Liu-SSI
> <james.liu@ssi.samsung.com> wrote:
> >> Hi Cephers,
> >>     It is not easy to ask when Ceph is going to support inline
> dedup/compression across OSDs in RADOS because it is not easy task an=
d
> answered. Ceph is providing replication and EC for performance and
> failure recovery. But we also lose the efficiency  of storage store
> and cost associate with it. It is kind of contradicted with each
> other. But I am curious how other Cephers think about this question.
> >>    Any plan for Cephers to do anything regarding to inline
> dedupe/compression except the features brought by local node itself
> like BRTFS?
> >
> > Compression is easier to implement in rados than dedup. The most
> important thing about compression is where we begin to compress,
> client, pg or objectstore. Then we need to decide how much the
> compress unit is. Of course, compress and dedup both like to use
> keyvalue-alike storage api to use, but I think it's not difficult to
> use existing objectstore api.
> >
> > Dedup is more possible to implement in local osd instead of the
> whole pool or cluster, and if we want to do dedup for the pool level,
> we need to do dedup from client.
> >
> >>
> >>   Regards,
> >>   James
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel"
> >> in the body of a message to majordomo@vger.kernel.org More
> majordomo=20
> >> info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > Best Regards,
> >
> > Wheat
>=20
>=20
>=20
> --
> Best Regards,
>=20
> Wheat
>   =EC=B9=BB & ~ &   +-  =DD=B6  w  =CB=9B   m  ^  b  ^n r   z   h    =
&   G   h ( =E9=9A=8E =DD=A2j" =20
> m     z =DE=96   f   h   ~ m
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e
> is intended only for the use of the designated recipient(s) named
> above. If the reader of this message is not the intended recipient,
> you are hereby notified that you have received this message in error
> and that any review, dissemination, distribution, or copying of this
> message is strictly prohibited. If you have received this
> communication in error, please notify the sender by telephone or
> e-mail (as shown above) immediately and destroy any and all copies of
> this message in your possession (whether hard copies or electronicall=
y
> stored copies).
>=20
> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =CA=87=DA=99 ,j=
   f   h   z  w     =20
> j:+v   w j m         zZ+     =DD=A2j"  ! i
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD

--=20
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
