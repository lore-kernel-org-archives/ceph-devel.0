From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: RPM issues
Date: Mon, 21 Mar 2011 09:09:50 -0700
Message-ID: <20110321160950.GA17804@dreamer>
References: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50071 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab1CUQJu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 12:09:50 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Brian Chrisman <brchrisman@gmail.com>, Terrance Hutchinson <terrance.hutchinson@gmail.com>, Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

On Fri, Mar 18, 2011 at 05:29:51PM -0700, Colin McCabe wrote:
> 3. How should we handle tcmalloc, if at all? Google-perftools is not
> bundled for 64 bit on CentOS. (It seems like this decision was made
> because some of the stuff in this package is buggy on 64 bit x86.
> However, tcmalloc itself is not buggy on 64 bit.). And in general, how
> do we handle things that are "good to have" but which shouldn't be
> dependencies?

Hmm. The whole point of commit a2c02d was that it'd be harder to
accidentally build a non-desired variant of Ceph. That is, just
because you reinstalled the machine you use for building the package,
and forgot to install libatomic-ops-dev, doesn't mean you should
create packages with completely different behavior in the future.

So, you need to figure out whether libatomic-ops is desired or not,
for the relevant platform/architecture. If yes, then builds must fail
without it (./configure will complain, debs have build-dependency). If
not, then say ./configure --without-libatomic-ops. But don't let it
depend on unpredictable factors.

-- 
:(){ :|:&};:
