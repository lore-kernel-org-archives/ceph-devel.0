From: Sage Weil <sage@inktank.com>
Subject: Re: Review request : Erasure Code plugin loader implementation
Date: Sun, 18 Aug 2013 10:34:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308181031580.1479@cobra.newdream.net>
References: <5210F429.2020805@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37858 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab3HRRem (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Aug 2013 13:34:42 -0400
In-Reply-To: <5210F429.2020805@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 18 Aug 2013, Loic Dachary wrote:
> Hi Ceph,
> 
> I've implemented a draft of the Erasure Code plugin loader in the context of http://tracker.ceph.com/issues/5878. It has a trivial unit test and an example plugin. It would be great if someone could do a quick review. The general idea is that the erasure code pool calls something like:
> 
> ErasureCodePlugin::factory(&erasure_code, "example", parameters)
> 
> as shown at
> 
> https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c73985412f3c8c/src/test/osd/TestErasureCode.cc#L28
> 
> to get an object implementing the interface
> 
> https://github.com/ceph/ceph/blob/5a2b1d66ae17b78addc14fee68c73985412f3c8c/src/osd/ErasureCodeInterface.h
> 
> which matches the proposal described at
> 
> https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasure-code.rst#erasure-code-library-abstract-api
> 
> The draft is at
> 
> https://github.com/ceph/ceph/commit/5a2b1d66ae17b78addc14fee68c73985412f3c8c
> 
> Thanks in advance :-)

I haven't been following this discussion too closely, but taking a look 
now, the first 3 make sense, but

    virtual map<int, bufferptr> decode(const set<int> &want_to_read, const 
map<int, bufferptr> &chunks) = 0;

it seems like this one should be more like

    virtual int decode(const map<int, bufferptr> &chunks, bufferlist *out);

As in, you'd decode the chunks you have to get the actual data.  If you 
want to get (missing) chunks for recovery, you'd do

  minimum_to_decode(...);  // see what we need
  <fetch those chunks from other nodes>
  decode(...);   // reconstruct original buffer
  encode(...);   // encode missing chunks from original data

sage
