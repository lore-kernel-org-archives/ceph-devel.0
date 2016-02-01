From: Sage Weil <sweil@redhat.com>
Subject: Re: client-facing feature bits and pending kernel changes
Date: Mon, 1 Feb 2016 08:08:40 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602010807130.28963@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1601291104270.28963@cpach.fuggernut.com> <CAAM7YAnygLww6UYemZcFjPxPCnrN8D7xO4wTHZwFjTNAEof61w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53540 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932174AbcBANIZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 1 Feb 2016 08:08:25 -0500
In-Reply-To: <CAAM7YAnygLww6UYemZcFjPxPCnrN8D7xO4wTHZwFjTNAEof61w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Zheng Yan <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 1 Feb 2016, Yan, Zheng wrote:
> On Sat, Jan 30, 2016 at 12:09 AM, Sage Weil <sweil@redhat.com> wrote:
> > Hi Zheng,
> >
> > We have one feature already merged to ceph.git, CRUSH_TUNABLES5, that's a
> > pretty trivial change to crush/mapper.c that we can add to the kernel.
> >
> > But there are two more coming:
> >
> > OSDOPREPLY_ENCODING makes a small change to the OSDOpReply encoding for
> > performance reasons.  Here is the PR
> >
> >         https://github.com/ceph/ceph/pull/7386
> >
> > The other is the file layout changes, which are much more invovled:
> >
> >         https://github.com/ceph/ceph/pull/7098
> 
> Can we avoid changing how file layout is encoded in MClientCaps and
> MClientReply? Instead, we encode the namespace information at the end
> of MClientCaps/MClientReply message. (like how we added inline data
> related fields to these message).

Hmm.. yeah, we do that, at least for MClientCaps.  It just means that if 
we ever add more fields to that struct we need to maintain the message 
encoding in parallel by hand, but that shouldn't be too bad.

The MClientReply one is a bit trickier because there can be N instances of 
InodeStat (or whatever) in there... on that one I'd lean toward switching 
the encoding.  What do you think?

sage
