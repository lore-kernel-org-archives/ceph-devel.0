From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: read/write on RADOS using external buffer
Date: Wed, 20 Oct 2010 09:46:10 -0600
Message-ID: <1287589570.6806.20.camel@sale659.sandia.gov>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
 <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
 <20101019222727.GA1737@enoki.dokukino.com>
 <AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
 <Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
 <AANLkTin0+n+e6Cb_WJcz5JA7xR_XG_K=2k0_bhSDuDRh@mail.gmail.com>
 <Pine.LNX.4.64.1010200821210.3927@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:51476 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab0JTPq1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 11:46:27 -0400
In-Reply-To: <Pine.LNX.4.64.1010200821210.3927@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Takuya ASADA <syuu@dokukino.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi,

On Wed, 2010-10-20 at 09:34 -0600, Sage Weil wrote:
> 
> > I think I can propose a patch which solves this problem without
> rados
> > client-specific data, threads, tids, maps, thread-local data, or
> > changes to SimpleMessenger.
> 
> SimpleMessenger will change no matter what, because the core problem
> that 
> we're trying to solve is that it allocates a new buffer when a message
> is 
> being read off the wire.  See SimpleMessenger::read_message(). 

FWIW, this buffer allocation is also an issue for trying to
implement an RDMA-based messenger. It would be nice to have
a pool of buffers to use that are already registered for RDMA,
to reduce the memory registration overhead.

-- Jim



