From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: Status of ceph ITP?
Date: Wed, 01 Dec 2010 06:20:45 +0100
Message-ID: <1291180845.14018.537.camel@julia.gcs.org.hu>
References: <1290365977.9821.3.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
	 <1290436452.9821.5.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
	 <1291075213.14018.101.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:48751 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab0LAFVW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Dec 2010 00:21:22 -0500
In-Reply-To: <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Clint Byrum <clint@ubuntu.com>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org

Hi Sage,

On Tue, 2010-11-30 at 10:21 -0800, Sage Weil wrote:
> > Sage: may you let me handle the packaging for Debian and Ubuntu? [...]
> Whatever you think would work best.  I would like to keep the debian/ 
> files in some form or another (although whether they live in ceph.git is 
> an open question) since I build packages for sid, squeeze, and lenny for 
> the ceph.newdream.net site, and would like to do so immediately when a 
> release is made.  But if you can handle the packaging changes and 
> uploading to debian that would (continue to be) helpful.  Or if the 
> packaging stuff is managed by you separately, but still available 
> somewhere for me pull and build my packages against.  What do you suggest?
 It's not an easy situation as its packaging goes on three way. First is
yours, to make it up-to-date quickly as new release happens. The other
two is for Debian and Ubuntu. Divergency will be minimum, expect
debian/changelog I think. Still it would be good to use quilt format for
packaging[1].
On the other hand, do you really need so fast package release cycles?
Usually I'm fast and active, still you'll lose at least a day or two
waiting on me for release an updated package. I don't know Clint, but he
seems to be active as well. Also I may apply for a per-package Ubuntu
upload rights which means I can upload the package simultaneously to
Debian and Ubuntu. This would help users in two ways: they don't need to
look for and setup an external package pool (Debian and Ubuntu already
have a backports archive) and ceph would be consistent on all archs
(backports have autobuild on all archs, including but not limited to
alpha, mips, sparc, s390).

Only one question remains, if we go three way packaging, how should we
version our package versions? Yours should have a priority, but official
backports from me and Clint should override it. I propose that your
version number should be upstream_version-[123...] and ours should be
upstream_version-[123...][lenny|squeeze|maverick][123...]. Clint?

[ about hdparm dependency ]
> Currently it's only used by os/FileJournal.cc to check for a journal on a 
> block device with write caching off.
 Would it be hard to get this info by yourself somehow?
Please note that I'm not a security expert, but as I see you create your
temp file in a very deterministic way. What if I'm evil and I make a
symlink named as your soon-to-be tempfile to a system binary / file?
Of course I see that you test for root (euid == 0) and if not, you don't
run hdparm. It's not a set[ug]id binary (I mean ceph), so we are safe as
normal user really can't start it.

> This is only a problem for kernels 
> prior to 2.6.33 (which unfortunately includes squeeze!), so I'm inclined 
> to keep it for now. [...]
 OK, it can remain as a dependency for user safety.

> Great!  There are a handful of bug fixes I'd like to roll into v0.23.2 
> first, if it isn't too much trouble.  I can do that today.
 We can wait for the release to be safe. Some more days to upload it
doesn't make the world.

> Clint, do you see any remaining issues I should fix first?
 He prompted for checking upgrades of previous ceph versions to this
one on Ubuntu Maverick. Don't know how it goes, today I'll check it
myself as well.

Regards,
Laszlo/GCS
[1] http://raphaelhertzog.com/2010/10/21/the-secret-plan-behind-the-3-0-quilt-debian-source-package-format/

