From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: read/write on RADOS using external buffer
Date: Wed, 20 Oct 2010 10:47:20 -0600
Message-ID: <1287593240.6806.44.camel@sale659.sandia.gov>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
 <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
 <20101019222727.GA1737@enoki.dokukino.com>
 <AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
 <Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
 <AANLkTin0+n+e6Cb_WJcz5JA7xR_XG_K=2k0_bhSDuDRh@mail.gmail.com>
 <Pine.LNX.4.64.1010200821210.3927@cobra.newdream.net>
 <1287589570.6806.20.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010200859050.3927@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:36898 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab0JTQrb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 12:47:31 -0400
In-Reply-To: <Pine.LNX.4.64.1010200859050.3927@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Takuya ASADA <syuu@dokukino.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2010-10-20 at 10:04 -0600, Sage Weil wrote:
> On Wed, 20 Oct 2010, Jim Schutt wrote:
> > Hi,
> > 
> > On Wed, 2010-10-20 at 09:34 -0600, Sage Weil wrote:
> > > 
> > > > I think I can propose a patch which solves this problem without
> > > rados
> > > > client-specific data, threads, tids, maps, thread-local data, or
> > > > changes to SimpleMessenger.
> > > 
> > > SimpleMessenger will change no matter what, because the core problem 
> > > that we're trying to solve is that it allocates a new buffer when a 
> > > message is being read off the wire.  See 
> > > SimpleMessenger::read_message().
> > 
> > FWIW, this buffer allocation is also an issue for trying to
> > implement an RDMA-based messenger. It would be nice to have
> > a pool of buffers to use that are already registered for RDMA,
> > to reduce the memory registration overhead.
> 
> That much is easy enough if it doesn't matter which buffer you use for a 
> particular message.  If the result of a specific read needs to be read 
> into a specific buffer, then something like the mechanism we're talking 
> about will be needed.  Do you know if RDMA will require that?

No, I don't think that will be required.

> 
> That's what the kernel client does, incidentally, except the callback is 
> to find/allocate the whole message struct, not just the data payload 
> portion.  We could do that here as well, although the memory reservation 
> requirements on the userspace side aren't as critical as in the kernel.

I think it will be OK to have the data payload buffer separate:
for RDMA we'd need to receive the header information into a buffer
pre-posted on the receive queue.  It will contain a remote key 
we'd use when queuing the RDMA read operation for the payload.

-- Jim

> 
> sage
> 


