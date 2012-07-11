From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph Upstream Tarball + Re: Ceph status for Wheezy
Date: Wed, 11 Jul 2012 16:32:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207111553050.693@cobra.newdream.net>
References: <4FFC44BE.6090505@ubuntu.com> <1341966632.12180.22.camel@julia> <4FFD40DA.7020408@ubuntu.com> <1342042993.12180.98.camel@julia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41490 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab2GKXcy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 19:32:54 -0400
In-Reply-To: <1342042993.12180.98.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: James Page <james.page@ubuntu.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 11 Jul 2012, Laszlo Boszormenyi (GCS) wrote:
> Hi James, Sage,
> 
> Let me answer you both at once.
> 
> On Wed, 2012-07-11 at 10:01 +0100, James Page wrote:
> > On 11/07/12 01:30, Laszlo Boszormenyi (GCS) wrote:
> > > You are right, the watch file is outdated.
>  An updated watch file is attached. Please commit it Sage. It goes for
> numbers only, so 0.48argonaut will be 0.48 .

Why leave off the argonaut?  The intent was to be able to tell from e.g. 
dpkg -l ceph that this was the argonaut stable release, without having to 
figure out through some other channel that 0.48 is special.

> > Ah-ha!  Thanks for this information - I had not realised the leveldb
> > and libs3 source was overlaid outside of git.
>  Sage still consider it better, to be able to build everything needed
> from one tarball. I've two small patches to build with system leveldb
> and libs3 instead.

It's useful for the tarball, and for our qa infrastructure.  The only 
reason the debs are using the system libraries is because I'd need to 
backport the libs3 and libleveldb dependencies and include those in our 
repo along with the debs we build.

> > This creates a short term issue for me in that leveldb and libs3 are
> > not currently in Ubuntu main (MIR is raised but still pending review
> > and approval) so not having the bundled source for these libraries is
> > a pain as I can't easily use the same upstream tarball that you are
> > using [...]
>  Is there any ETA when/if it will be in Ubuntu main? Sage, would you
> reconsider the all-in-one tarball if Debian and Ubuntu will have leveldb
> and libs3 in their package list? I _may_ become a RedHat / Fedora
> package maintainer as well and when it happens, I'll add them to those
> distributions as well.

Again, using the bundled libs3/leveldb is completely optional.  My only 
concern is that it be an easy option for those trying to build on 
weird/old systems.  I'm all for using the separately packaged ones when 
possible.

> > - guess I could plugin the required bundles in the interim as
> > patches as I would like to push 0.48 to quantal this week.
>  You may wait a bit. At least please see:
> [ Sage and me about "Ceph status for Wheezy" ]
> On Wed, 2012-07-11 at 09:18 -0700, Sage Weil wrote:
> > > What do I miss? Manpages for
> > > ceph-disk-activate , ceph-disk-prepare , rest-bench and maybe
> > > librados-config .
> > Okay, those should be pretty simple.  There will be a point release before 
> > too long that includes all of this stuff.  If there is anything in your 
> > packaging that isn't fixed upstream let me know.
>  It sounds 0.48.1 may happen within a week time. I've added symbol
> versioning, but don't know if it has any use. Currently kvm doesn't
> work when compiled with previous version of Ceph, see Debian bug
> #679686[1]. In answer, my symbol files are created with 0.47.2 and
> updated to 0.48 . Didn't go more back with versions and don't know how
> much Ceph libraries will change in the future.
> Sage, can you please give us more detail how do you plan the releases?
> Is there any plan for more stable releases on every (say) 3 months, with
> bugfixing only? Should we follow the actual development tree, no matter
> what?

Hrm.  We've been adding methods to the library without bumping the 
SONAME, and then ensuring that users only use the new symbols if the 
version info in the header is sufficiently recent.  This means you can't 
compile code against a new -dev package and expect it to work on an older 
library.  My understanding is that this is completely okay, as long as the 
code compiled against the old library still works with the new library 
(i.e. symbols aren't removed and their functionality isn't changed).

Am I misunderstanding the bug?

thanks-
sage

> 
> > I'm hoping to get to a point where the packaging is the same; if
> > nothing else it saves extra work!
>  Sure, that would be better. I've a package of v0.48 ready to upload[2],
> but can wait some days if you would like to check what I may need to
> merge from your package.
> 
> Cheers,
> Laszlo/GCS
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=679686
> [2] dget -x http://www.barcikacomp.hu/gcs/ceph_0.48-1.dsc
> 
