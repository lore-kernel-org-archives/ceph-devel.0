From: Sage Weil <sweil@redhat.com>
Subject: Re: per-pool bluestore options
Date: Thu, 18 Aug 2016 16:18:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608181615370.2394@piezo.us.to>
References: <alpine.DEB.2.11.1608131843050.17762@piezo.us.to> <4adc2518-07d5-f4bd-7d71-5716bfb767c1@mirantis.com> <alpine.DEB.2.11.1608171617250.17762@piezo.us.to> <26d298ca-a400-c102-92fc-6f5dd3d483f4@mirantis.com> <alpine.DEB.2.11.1608181513430.2394@piezo.us.to>
 <e161ff11-aef1-fc26-3d65-3b2b549a60a7@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbcHSCyb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 Aug 2016 22:54:31 -0400
In-Reply-To: <e161ff11-aef1-fc26-3d65-3b2b549a60a7@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 18 Aug 2016, Igor Fedotov wrote:
> On 18.08.2016 18:26, Sage Weil wrote:
> > On Thu, 18 Aug 2016, Igor Fedotov wrote:
> > > On 17.08.2016 19:27, Sage Weil wrote:
> > > > On Mon, 15 Aug 2016, Igor Fedotov wrote:
> > > > > On 13.08.2016 21:56, Sage Weil wrote:
> > > > > > Hi Igor,
> > > > > > 
> > > > > > I took another look at
> > > > > > 
> > > > > > 	https://github.com/ceph/ceph/pull/10556
> > > > > > 
> > > > > > You define three settings:
> > > > > > 
> > > > > >     compress_hint - determines if pool contains compressible /
> > > > > > incompressible
> > > > > > data
> > > > > >     compress_algorithm - permits to specify different compression
> > > > > > algorithm
> > > > > >     compress_ratio - specifies maximum compression ratio
> > > > > > 
> > > > > > I think we should extend this to include csum-related options.  And
> > > > > > use
> > > > > > a
> > > > > > consistent naming scheme that aligns with the config options where
> > > > > > we
> > > > > > just
> > > > > > strip off the bluestore_ prefix.  The relevant options are:
> > > > > Sounds good!
> > > > > The major questions here is how do these per-pool options correlate
> > > > > with
> > > > > corresponding per-store ones?
> > > > > One might suggest per-pool options to have higher priority over
> > > > > per-store
> > > > > one.
> > > > > But I'm not sure that the best option.  Sometimes user might want to
> > > > > disable/alter corresponding option without enumerating all the pools
> > > > > by
> > > > > simple
> > > > > switching at per-store level. Hence we need to consider some means for
> > > > > that.
> > > > > >     bluestore_csum = {true, false}
> > > > > >     bluestore_csum_type = {crc32c, crc32c_{8,16}, ...}
> > > > > >     bluestore_csum_min_chunk_size = 4k      (*)
> > > > > >     bluestore_csum_max_chunk_size = 64k     (*)
> > > > > >     bluestore_compression = {force, aggressive, passive, none}
> > > > > Actually this option along with compression_hint result in a single
> > > > > flag:
> > > > > compress or not. Any rationale for not using that simple flag?
> > > > There are currently two persistent hints: compressible and
> > > > incompressible.
> > > > Aggressive will compress unless incompressible, whereas passive will
> > > > compress if compressible.  Either way it varies per object, though, so a
> > > > single flag isn't sufficient.
> > > So final approach is to have bluestore_compression switch at pool level
> > > (and
> > > per-store too) and compression_hint at object one, right? Hence we don't
> > > need
> > > compression_hint per pool. In fact my original point was that the
> > > latter(along
> > > with bluestore_compression) is IMHO an overkill and can be substituted
> > > with
> > > simple enable_compression flag.
> > I think so.  Having a pool compression_hint = compressible will accomplish
> > the same thing as setting the pool compression = aggressive.
> OK, Sounds good!
> Still there is an open question how to assign such a hint to objects from user
> perspective....

https://github.com/ceph/ceph/blob/master/src/include/rados/librados.h#L145
and
https://github.com/ceph/ceph/blob/master/src/include/rados/librados.h#L2438

> > > > > My original idea here was to have bluestore_compression on per-store
> > > > > basis
> > > > > and
> > > > > compression_hint of per pool one. This way one can receive pretty
> > > > > flexible
> > > > > control at both storage and pool level - see my question above.
> > > > Yeah, I'm not sure how complex it's worth getting.  To get complete
> > > > control, we probably need a default *and* the min/max allowed range for
> > > > each option in order to bound what you can choose per-pool, but I think
> > > > that is probably overkill.
> > > > 
> > > > A bit easier would be to have
> > > > 
> > > >    bluestore_csum_override = {,true,false}
> > > >    bluestore_csum_type_override = {, crc32c, crc32c_{8,16}}
> > > >    bluestore_compression_override = {, force, aggressive, passive, none}
> > > > 
> > > > and have them blank by default (no override).  For the numeric options
> > > > we'd need to use 0 to mean 'no override'.
> > > > 
> > > > What do you think?
> > > IMO per-pool settings (if set) have to override corresponding per-store
> > > one by default. But one should be able to turn off that behavior with
> > > 'one-click' and force specific per-store setting to prevail.
> > > Hence we don't need 'override' settings at per-pool level but should have
> > > one
> > > at per-store one. E.g.
> > > 
> > > Pool A has:
> > > bluestore_csum = true
> > > Pool B:
> > > bluestore_csum=<not set>
> > > OSD:
> > > bluestore_csum=  false [/force]
> > > 
> > > if /'force' is omitted - actual settings are
> > > Pool A:
> > > bluestore_csum=true
> > > Pool B:
> > > bluestore_csum=false
> > > 
> > > else
> > > Pool A:
> > > bluestore_csum=false
> > > Pool B:
> > > bluestore_csum=false
> > Hmm, this makes parsing more complicated but is probably less confusing.
> > But what about numeric values?
> > 
> >   bluestore_compression_max_blob_size=1048576/force?
> > 
> > This is partly why I like the (implementation) simplicity of
> > 
> >   bluestore_compression_max_blob_size_force=1048576
> > 
> > (or _override, whatever).
> This way one gets parameter name duplication for each per-store parameter that
> has per-pool clone. E.g.
> 
>  bluestore_compression_max_blob_size for default settings
> 
> and
>  bluestore_compression_max_blob_size_force for override ones.
> 
> Can't say that's pretty elegant..
> What's about a single generic parameter that denotes per-collection params to
> be banned, e.g.
> 
> bluestore_force_per_store_settings = *
> bluestore_force_per_store_settings = bluestore_compression
> bluestore_force_per_store_settings = bluestore_compression, bluestore_csum,
> bluestore_csum_type
> 
> 
> or bluestore_disable_per_collection_settings = a,b,c ?

I like this.  Or rather the converse:

 bluestore_allow_per_collection_settings = bluestore_compression,bluestore_csum, ...

sage
