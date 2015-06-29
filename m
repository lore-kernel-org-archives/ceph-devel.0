From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: Inline dedup/compression
Date: Mon, 29 Jun 2015 16:32:08 -0400 (EDT)
Message-ID: <1848247503.101.1435609928777.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1534307780.99.1435609644861.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1221 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950AbbF2UcR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Jun 2015 16:32:17 -0400
In-Reply-To: <1534307780.99.1435609644861.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>

Hi,

The issues Greg raises steered us away from stream compression, but I'm glad you're experimenting with it.

We were/are interested in (block-oriented, generalized) dedup.  For us, it was clear that the different needs of users and changing capabilities of Ceph lead to different strategies for different data sets (at least).

In our variant of the system, where EC is client side, I don't think there's a conflict with dedup.  We situated it at the volume (kind of like pool) level, where it's abstracted from placement (we've only implemented some simulations to date).

Matt

----- "Haomai Wang" <haomaiwang@gmail.com> wrote:

> On Sat, Jun 27, 2015 at 2:03 AM, James (Fei) Liu-SSI
> <james.liu@ssi.samsung.com> wrote:
> > Hi Haomai,
> >   Thanks for your response as always. I agree compression is
> comparable easier task but still very challenge in terms of
> implementation no matter where we should implement . Client side like
> RBD, or RDBGW or CephFS, or PG should be a little bit better place to
> implementation in terms of efficiency and cost reduction before the
> data were duplicated to other OSDs. It has  two reasons :
> > 1. Keep the data consistency among OSDs in one PG
> > 2. Saving the computing resources
> >
> > IMHO , The compression should be accomplished before the replication
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
> 
> Actually we may have some tricks to reduce performance hurt like
> compression. As Joe mentioned, we can compress slave pg data to avoid
> performance hurt, but it may increase the complexity of recovery and
> pg remap things. Another in-detail implement way if we begin to
> compress data from messenger, osd thread and pg thread won't access
> data for normal client op, so maybe we can make it parallel with pg
> process. Journal thread will get the compressed data at last.
> 
> The effect of compression also is a concern, we do compression in
> rados may not get the best compression result. If we can do
> compression in libcephfs, librbd and radosgw and make rados unknown
> to
> compression, it maybe simpler and we can get file/block/object level
> compression. it should be better?
> 
> About dedup, my current idea is we could setup a memory pool at osd
> side for checksum store usage. Then we calculate object data and map
> to PG instead of object name at client side, so a object could always
> in a osd where it's also responsible for dedup storage. It also could
> be distributed at pool level.
> 
> 
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
> dedup/compression across OSDs in RADOS because it is not easy task and
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
> majordomo
> >> info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > Best Regards,
> >
> > Wheat
> 
> 
> 
> -- 
> Best Regards,
> 
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
