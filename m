From: Casey Bodley <cbodley@redhat.com>
Subject: Re: inconsistent rados semantics between automake/cmake builds
Date: Fri, 29 Jan 2016 10:55:32 -0500 (EST)
Message-ID: <1919821924.28254854.1454082932621.JavaMail.zimbra@redhat.com>
References: <CAB2gnbUxzE7z6ec39=cPg2sqNOtMc6cS8_GN9ybxxdvB7zXW+g@mail.gmail.com> <20160122024935.GA15962@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:40214 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbcA2Pze (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 10:55:34 -0500
In-Reply-To: <20160122024935.GA15962@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Noah Watkins <noahwatkins@gmail.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Noah,

We were tracking this bug in rgw for a while, and couldn't find a
simple reproducer. Your test case made it so much easier to fix,
thank you!

A pull request with the fix is pending at:
https://github.com/ceph/ceph/pull/7328

Casey

----- Original Message -----
> On 21/01/2016, Noah Watkins wrote:
> > I'm seeing an anomaly of semantics between Ceph built with Automake
> > and with CMake. I've not been lucky so far tracking this down so I
> > thought I'd toss it out here.
> 
> All right.  Commit 9717714cf62eeb7db979b0e6b509ef305cb757eb in
> github.com/cohortfsllc/cohort-ceph should have this. It's the top entry on
> the
> mtime branch in that repository. If you like things web-style,
> https://github.com/cohortfsllc/cohortfs-ceph/commit/9717714cf62eeb7db979b0e6b509ef305cb757eb
> 
> Casey chased this down to the encode/decode functions and once I took a look
> at
> them I realized the cast was screwy. It now passes your unit test reliably
> (at
> least it worked a few times) under cmake.
> 
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC, Freenode}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
> 
