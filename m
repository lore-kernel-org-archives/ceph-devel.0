From: Sage Weil <sage@inktank.com>
Subject: Re: Review request : Erasure Code plugin loader implementation
Date: Mon, 19 Aug 2013 09:19:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308190913460.11018@cobra.newdream.net>
References: <5210F429.2020805@dachary.org> <alpine.DEB.2.00.1308181031580.1479@cobra.newdream.net> <521128ED.1080605@dachary.org> <alpine.DEB.2.00.1308181654560.1479@cobra.newdream.net> <52123493.80803@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46832 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3HSQTI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 12:19:08 -0400
In-Reply-To: <52123493.80803@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 19 Aug 2013, Loic Dachary wrote:
> 
> 
> On 19/08/2013 02:01, Sage Weil wrote:
> > On Sun, 18 Aug 2013, Loic Dachary wrote:
> >> Hi Sage,
> >>
> >> Unless I misunderstood something ( which is still possible at this stage ;-) decode() is used both for recovery of missing chunks and retrieval of the original buffer. Decoding the M data chunks is a special case of decoding N <= M chunks out of the M+K chunks that were produced by encode(). It can be used to recover parity chunks as well as data chunks.
> >>
> >> https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasure-code.rst#erasure-code-library-abstract-api
> >>
> >>     map<int, buffer> decode(const set<int> &want_to_read, const map<int, buffer> &chunks)
> >>
> >>     decode chunks to read the content of the want_to_read chunks and return a map associating the chunk number with its decoded content. For instance, in the simplest case M=2,K=1 for an encoded payload of data A and B with parity Z, calling
> >>
> >>     decode([1,2], { 1 => 'A', 2 => 'B', 3 => 'Z' })
> >>     => { 1 => 'A', 2 => 'B' }
> >>
> >>     If however, the chunk B is to be read but is missing it will be:
> >>
> >>     decode([2], { 1 => 'A', 3 => 'Z' })
> >>     => { 2 => 'B' }
> > 
> > Ah, I guess this works when some of the chunks contain the original 
> > data (as with a parity code).  There are codes that don't work that way, 
> > although I suspect we won't use them.
> > 
> > Regardless, I wonder if we should generalize slightly and have some 
> > methods work in terms of (offset,length) of the original stripe to 
> > generalize that bit.  Then we would have something like
> > 
> >      map<int, buffer> transcode(const set<int> &want_to_read, const map<int, 
> >             buffer>& chunks);
> > 
> > to go from chunks -> chunks (as we would want to do with, say, a LRC-like 
> > code where we can rebuild some shards from a subset of the other shards).  
> > And then also have
> > 
> >      int decode(const map<int, buffer>& chunks, unsigned offset, 
> >          unsigned len, bufferlist *out);
> 
> This function would be implemented more or less as:
> 
>   set<int> want_to_read = range_to_chunks(offset, len) // compute what chunks must be retrieved
>   set<int> available = the up set
>   set<int> minimum = minimum_to_decode(want_to_read, available);
>   map<int, buffer> available_chunks = retrieve_chunks_from_osds(minimum);
>   map<int, buffer> chunks = transcode(want_to_read, available_chunks); // repairs if necessary
>   out = bufferptr(concat_chunks(chunks), offset - offset of the first chunk, len)
> 
> or do you have something else in mind ?

This makes sense.  I am still wondering if it is worth generalizing this a 
bit further to codes without a nice mapping of a range -> want_to_read 
(i.e. that require decoding the entire stripe to get any part of it).  
For those codes, we would want to choose the N cheapest/available chunks 
and the sequence above would be a bit different.  I guess in reality, 
though, we probably don't care to implement any such codes (I'm not sure 
what their advantages would be, if any)!

sage





 > 
> > 
> > that recovers the original data.
> > 
> > In our case, the read path would use decode, and for recovery we would use 
> > transcode.  
> > 
> > We'd also want to have alternate minimum_to_decode* methods, like
> > 
> >     virtual set<int> minimum_to_decode(unsigned offset, unsigned len, const 
> >          set<int> &available_chunks) = 0;
> 
> I also have a convenience wrapper in mind for this but I feel I'm missing something.
> 
> Cheers
> 
> > 
> > What do you think?
> > 
> > sage
> > 
> > 
> > 
> > 
> >>
> >> Cheers
> >>
> >> On 18/08/2013 19:34, Sage Weil wrote:
> >>> On Sun, 18 Aug 2013, Loic Dachary wrote:
> >>>> Hi Ceph,
> >>>>
> >>>> I've implemented a draft of the Erasure Code plugin loader in the context of http://tracker.ceph.com/issues/5878. It has a trivial unit test and an example plugin. It would be great if someone could do a quick review. The general idea is that the erasure code pool calls something like:
> >>>>
> >>>> ErasureCodePlugin::factory(&erasure_code, "example", parameters)
> >>>>
> >>>> as shown at
> >>>>
> >>>> https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c73985412f3c8c/src/test/osd/TestErasureCode.cc#L28
> >>>>
> >>>> to get an object implementing the interface
> >>>>
> >>>> https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c73985412f3c8c/src/osd/ErasureCodeInterface.h
> >>>>
> >>>> which matches the proposal described at
> >>>>
> >>>> https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasure-code.rst#erasure-code-library-abstract-api
> >>>>
> >>>> The draft is at
> >>>>
> >>>> https://github.com/ceph/ceph/commit/5a2b1d66ae17b78addc14fee68c73985412f3c8c
> >>>>
> >>>> Thanks in advance :-)
> >>>
> >>> I haven't been following this discussion too closely, but taking a look 
> >>> now, the first 3 make sense, but
> >>>
> >>>     virtual map<int, bufferptr> decode(const set<int> &want_to_read, const 
> >>> map<int, bufferptr> &chunks) = 0;
> >>>
> >>> it seems like this one should be more like
> >>>
> >>>     virtual int decode(const map<int, bufferptr> &chunks, bufferlist *out);
> >>>
> >>> As in, you'd decode the chunks you have to get the actual data.  If you 
> >>> want to get (missing) chunks for recovery, you'd do
> >>>
> >>>   minimum_to_decode(...);  // see what we need
> >>>   <fetch those chunks from other nodes>
> >>>   decode(...);   // reconstruct original buffer
> >>>   encode(...);   // encode missing chunks from original data
> >>>
> >>> sage
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> >> -- 
> >> Lo?c Dachary, Artisan Logiciel Libre
> >> All that is necessary for the triumph of evil is that good people do nothing.
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do nothing.
> 
> 
