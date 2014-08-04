From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: ISA erasure code plugin and cache
Date: Mon, 4 Aug 2014 15:22:03 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE75828F@CERNXCHG43.cern.ch>
References: <53DF750B.6080107@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4AE75711F@CERNXCHG43.cern.ch>
 <53DF7E7A.5040509@dachary.org>
 <6AA21C22F0A5DA478922644AD2EC308C8A60B8@SHSMSX101.ccr.corp.intel.com>,
 <53DF8304.5040100@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4AE7581DE@CERNXCHG43.cern.ch>,<alpine.DEB.2.00.1408040719440.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:13210 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbaHDPWF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 11:22:05 -0400
In-Reply-To: <alpine.DEB.2.00.1408040719440.18917@cobra.newdream.net>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, "Ma, Jianpeng" <jianpeng.ma@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

Could one not attach the EC instance to the "pg_pool_t" structure which is given by reference to PGBackend *PGBackend::build_pg_backend? Just a naive question ... i don't know the upstream code ...

That would follow the spirit of 'saving/sharing resources' and would follow the logic that the CODEC configuration is by pool and not by PG ?!?!?

Cheers Andreas.



________________________________________
From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.org] on behalf of Sage Weil [sweil@redhat.com]
Sent: 04 August 2014 16:22
To: Andreas Joachim Peters
Cc: Loic Dachary; Ma, Jianpeng; Ceph Development
Subject: RE: ISA erasure code plugin and cache

On Mon, 4 Aug 2014, Andreas Joachim Peters wrote:
> Yes,
> you are both right, it would have only the current failure situation in
> each cache and it stores the encoding table in each plug-in instance.
> Probably the sharing of cache and encoding table would add more
> (unwanted) thread synchronization points.
>
> If this is the final design, I might remove also the lock? Nevertheless,
> it has no measurable performance impact ...

Perhaps, but I think the memory impact is significant, especially since
people will want to use erasure coding for "cold" storage pools are
underpowered hardware.  I think we should adjust the strategy so that
there is a single instance per pool, or (perhaps better) the cache is
global to the plugin (and shared across pools that may share the same
EC profile).

sage


> Cheers Andreas.
>
>
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 04 August 2014 14:56
> To: Ma, Jianpeng; Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: ISA erasure code plugin and cache
>
> On 04/08/2014 14:50, Ma, Jianpeng wrote:
> >> -----Original Message-----
> >> From: ceph-devel-owner@vger.kernel.org
> >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
> >> Sent: Monday, August 4, 2014 8:37 PM
> >> To: Andreas Joachim Peters
> >> Cc: Ma, Jianpeng; Ceph Development
> >> Subject: Re: ISA erasure code plugin and cache
> >>
> >>
> >>
> >> On 04/08/2014 14:15, Andreas Joachim Peters wrote:> Hi Loic,
> >>>
> >>> the background relevant to your comments have (unfortunately) never been
> >> answered on the mailing list.
> >>>
> >>> The cache is written in a way, that it is useful for a fixed (k,m) combination
> >> and thread-safe.
> >>>
> >>> So, if there is one instance of the plugin per pool, it is the right
> >> implementation. If there is (as you write) one instance for each PG in any pool,
> >> it is sort of 'stupid' because the same encoding table is stored for each PG
> >> seperatly.
> >>
> >> I would not called it stupid ;-) Just not as efficient as if the cache was by all PGs.
> >> Without cache the decode table has to be calculated for each object in the
> >> placement group and there are a lot of objects. The table may be duplicated
> >> hundreds of time so it has an impact on the memory footprint, but it should not
> >> have a visible impact on the decode performances. An optimisation of your
> >> implementation to save memory would be nice, but it is not critical.
> >>
> > AFAIK, for a recovery pg, all the objects of pg have the same lost chunks. So only the first object miss the cache.
> > But the later won't.  It only need a entry to cache.
> > Or am I missing something?
>
> It also is my understanding and that's what makes the cache so useful. Now, in the long run the cache stays and grows. Since it is a few mega bytes per PG, it will eventually has a non negligible impact on a long running OSD. But again, it's nothing critical to performances.
>
> Cheers
>
> >
> > Jianpeng Ma
> >
> >> How large are the decode tables ?
> >>
> >>> So if the final statement is to create one plugin instance per PG, I will change
> >> it accordingly and shared encoding & decoding tables for a fixed (k,m), if not it
> >> can stay.
> >>>
> >>> Just need to know that ... this boils down to the fact, that encoding &
> >> decoding should not be considered 'stateless'.
> >>>
> >>> Cheers Andreas.
> >>>
> >>>
> >>> ________________________________________
> >>> From: Loic Dachary [loic@dachary.org]
> >>> Sent: 04 August 2014 13:56
> >>> To: Andreas Joachim Peters
> >>> Cc: Ma, Jianpeng; Ceph Development
> >>> Subject: ISA erasure code plugin and cache
> >>>
> >>> Hi,
> >>>
> >>> Here is how I understand the current code:
> >>>
> >>> When an OSD is missing, recovery is required and the primary OSD will collect
> >> the available chunks to do so. It will then call the decode method via
> >> ECUtil::decode which is a small wrapper around the corresponding
> >> ErasureCodeInterface::decode method.
> >>>
> >>>    https://github.com/ceph/ceph/blob/master/src/osd/ECBackend.cc#L361
> >>>
> >>> The ISA plugin will then use the isa_decode method to perform the work
> >>>
> >>>
> >> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureCode
> >> Isa.cc#L212
> >>>
> >>> and will be repeatedly called until all objects in the PGs that were relying on
> >> the missing OSD are recovered. To avoid computing the decoding table for each
> >> object, it is stored in a LRU cache
> >>>
> >>>
> >> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureCode
> >> Isa.cc#L480
> >>>
> >>> and copied in the stack if already there:
> >>>
> >>>
> >> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureCode
> >> Isa.cc#L433
> >>>
> >>> Each PG has a separate instance of ErasureCodeIsa, obtained when it is
> >> created:
> >>>
> >>>    https://github.com/ceph/ceph/blob/master/src/osd/PGBackend.cc#L292
> >>>
> >>> It means that data members of each ErasureCodeIsa are copied as many
> >> times as there are PGs. If an OSD handles participates in 200 PG that belong to
> >> an erasure coded pool configured to use ErasureCodeIsa, the data members
> >> will be duplicated 200 times.
> >>>
> >>> It is good practice to make it so that the encode/decode methods of
> >> ErasureCodeIsa are thread safe. In the jerasure plugin these methods have no
> >> side effect on the object. In the isa plugin the LRU cache storing the decode
> >> tables is modified by the decode method and guarded by a mutex:
> >>>
> >>>    get
> >> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureCode
> >> Isa.cc#L281
> >>>    put
> >> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureCode
> >> Isa.cc#L310
> >>>
> >>> Please correct me if I'm mistaken ;-) I've not reviewed the code yet and try to
> >> find problems, I just wanted to make sure I get the intention before doing so.
> >>>
> >>> Cheers
> >>> --
> >>> Lo?c Dachary, Artisan Logiciel Libre
> >>>
> >>
> >> --
> >> Lo?c Dachary, Artisan Logiciel Libre
> >
>
> --
> Lo?c Dachary, Artisan Logiciel Libre
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html