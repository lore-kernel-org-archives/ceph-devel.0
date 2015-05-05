From: Sage Weil <sweil@redhat.com>
Subject: Re: Configure dependencies can be the same as make dependencies
Date: Tue, 5 May 2015 12:31:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505051231040.13336@cobra.newdream.net>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com> <5548D57E.3050406@dachary.org> <55491307.8010203@redhat.com> <554914EC.6000102@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757421AbbEETbr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 May 2015 15:31:47 -0400
In-Reply-To: <554914EC.6000102@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 5 May 2015, Loic Dachary wrote:
> > I think the long-term solution to Kefu's issue is that we need to
> > remove the requirement to run through a full "./configure" invocation
> > just to get a tarball. All the RPM and Debian packages internally run
> > ./configure, so running it a second time slows things down. I think it
> > makes sense to implement the tarball-generation functionality using a
> > simpler script at the root of the ceph.git tree. The operation should
> > be about as fast as "git archive".
> 
> I agree. It's going to be significant work but it's worth it.

Yep!

> > The "ceph.spec.in" -> "ceph.spec" suffers from a similar issue. It
> > takes a full "./configure" run to get to a point where Make can write
> > the proper version numbers into that file. Ideally we could skip all
> > of that and simply do the variable interpolation with sed or something.

Yep!

sage
