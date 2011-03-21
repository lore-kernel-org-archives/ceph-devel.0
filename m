From: Sage Weil <sage@newdream.net>
Subject: Re: RPM issues
Date: Mon, 21 Mar 2011 09:32:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103210929280.15399@cobra.newdream.net>
References: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
 <20110321160950.GA17804@dreamer> <AANLkTi=Q=49N5zKB51+VHimOM5K4Vn+TovwtqS_Zz2Oe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52811 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab1CUQ3m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 12:29:42 -0400
In-Reply-To: <AANLkTi=Q=49N5zKB51+VHimOM5K4Vn+TovwtqS_Zz2Oe@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, Brian Chrisman <brchrisman@gmail.com>, Terrance Hutchinson <terrance.hutchinson@gmail.com>, Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

On Mon, 21 Mar 2011, Colin McCabe wrote:
> On Mon, Mar 21, 2011 at 9:09 AM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
> > On Fri, Mar 18, 2011 at 05:29:51PM -0700, Colin McCabe wrote:
> >> 3. How should we handle tcmalloc, if at all? Google-perftools is not
> >> bundled for 64 bit on CentOS. (It seems like this decision was made
> >> because some of the stuff in this package is buggy on 64 bit x86.
> >> However, tcmalloc itself is not buggy on 64 bit.). And in general, how
> >> do we handle things that are "good to have" but which shouldn't be
> >> dependencies?
> >
> > Hmm. The whole point of commit a2c02d was that it'd be harder to
> > accidentally build a non-desired variant of Ceph. That is, just
> > because you reinstalled the machine you use for building the package,
> > and forgot to install libatomic-ops-dev, doesn't mean you should
> > create packages with completely different behavior in the future.
> >
> > So, you need to figure out whether libatomic-ops is desired or not,
> > for the relevant platform/architecture. If yes, then builds must fail
> > without it (./configure will complain, debs have build-dependency). If
> > not, then say ./configure --without-libatomic-ops. But don't let it
> > depend on unpredictable factors.
> 
> I agree that libatomic-ops should be mandatory.
> 
> The more annoying dependencies are things like GTK2, which don't
> really affect the behavior of the rest of the project, but which will
> have to be "mandatory" in the RPM, it seems.

We should really break that into a separate package at some point.  The 
main roadblock there iirc is breaking it into a separate binary.  
Originally I thought we should have it launched via the ceph tool (similar 
to the git subcommands) but at this point I don't really care either way.

> Also, as I said, tcmalloc
> will present somewhat of a problem because it's just not packaged on
> RedHat/CentOS at the moment for 64-bit. I will report a bug with Red
> Hat and see what they think...

Yeah, getting it packaged would be ideal.  Let's see how that goes.  
Maybe stick something in the wiki that people can modify the .spec to 
build without it in the meantime?

sage

