From: Sage Weil <sage@newdream.net>
Subject: Re: read/write on RADOS using external buffer
Date: Wed, 20 Oct 2010 09:04:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010200859050.3927@cobra.newdream.net>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
 <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
 <20101019222727.GA1737@enoki.dokukino.com> <AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
 <Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
 <AANLkTin0+n+e6Cb_WJcz5JA7xR_XG_K=2k0_bhSDuDRh@mail.gmail.com>
 <Pine.LNX.4.64.1010200821210.3927@cobra.newdream.net>
 <1287589570.6806.20.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34607 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab0JTQBE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 12:01:04 -0400
In-Reply-To: <1287589570.6806.20.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Takuya ASADA <syuu@dokukino.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 20 Oct 2010, Jim Schutt wrote:
> Hi,
> 
> On Wed, 2010-10-20 at 09:34 -0600, Sage Weil wrote:
> > 
> > > I think I can propose a patch which solves this problem without
> > rados
> > > client-specific data, threads, tids, maps, thread-local data, or
> > > changes to SimpleMessenger.
> > 
> > SimpleMessenger will change no matter what, because the core problem 
> > that we're trying to solve is that it allocates a new buffer when a 
> > message is being read off the wire.  See 
> > SimpleMessenger::read_message().
> 
> FWIW, this buffer allocation is also an issue for trying to
> implement an RDMA-based messenger. It would be nice to have
> a pool of buffers to use that are already registered for RDMA,
> to reduce the memory registration overhead.

That much is easy enough if it doesn't matter which buffer you use for a 
particular message.  If the result of a specific read needs to be read 
into a specific buffer, then something like the mechanism we're talking 
about will be needed.  Do you know if RDMA will require that?

That's what the kernel client does, incidentally, except the callback is 
to find/allocate the whole message struct, not just the data payload 
portion.  We could do that here as well, although the memory reservation 
requirements on the userspace side aren't as critical as in the kernel.

sage
