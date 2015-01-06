From: Sage Weil <sweil@redhat.com>
Subject: Re: replace fiemap with seek_data/seek_hole?
Date: Tue, 6 Jan 2015 10:13:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501061013180.5967@cobra.newdream.net>
References: <alpine.DEB.2.00.1501060837090.8073@cobra.newdream.net> <CAC6JEv_F_NiS=vDFRu7eXeMRRz+KfNeHbgE3S8V_ikru+MpF4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39537 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932434AbbAFSNy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 6 Jan 2015 13:13:54 -0500
In-Reply-To: <CAC6JEv_F_NiS=vDFRu7eXeMRRz+KfNeHbgE3S8V_ikru+MpF4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: haomaiwang@gmail.com, jianpeng.ma@intel.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 6 Jan 2015, Gregory Farnum wrote:
> On Tue, Jan 6, 2015 at 8:44 AM, Sage Weil <sweil@redhat.com> wrote:
> > Hey,
> >
> > In an exchange on linux-fsdevel yesterday it became clear that even when
> > FIEMAP isn't buggy it's not a good interface to build a map of sparse
> > files.  For example, XFS defrag or other future fs features may muck with
> > fiemap results.  One wouldn't expect those things to change whether a file
> > extent is allocated or not allocated, but given what we've seen so far I
> > wouldn't bet on it.
> >
> > Instead, we should use lseek SEEK_DATA/SEEK_HOLE, which is a more natural
> > interface for what we need.  This should simply be a matter of replacing
> > the fiemap() method implementation in FileStore.cc, I think.
> >
> > See this thread:
> >
> >         http://marc.info/?l=linux-fsdevel&m=142050204317588&w=2
> >
> > The other half of this is we should confirm that xfstests.git has good
> > SEEK_HOLE/SEEK_DATA stress tests (that verify correct results on both
> > recently written, recently synced, and uncached files).
> 
> Is there a ticket covering this? :)

Is now :)

	http://tracker.ceph.com/issues/10463

sage
