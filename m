From: Sage Weil <sage@newdream.net>
Subject: Re: Fedora 21 packages
Date: Sun, 29 Mar 2015 16:45:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503291644260.8441@cobra.newdream.net>
References: <CAMWPydSzi4E8YmwL+-0PFbnNTFvEJ3duVFigfmnrTWzwFQY9QQ@mail.gmail.com> <alpine.DEB.2.00.1503281034470.18934@cobra.newdream.net> <551874D0.1090900@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55183 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbC2Xp4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Mar 2015 19:45:56 -0400
In-Reply-To: <551874D0.1090900@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 30 Mar 2015, Brad Hubbard wrote:
> On 03/29/2015 03:36 AM, Sage Weil wrote:
> > On Sat, 28 Mar 2015, Mustafa Muhammad wrote:
> > > Hi,
> > > I am trying to install ceph on Fedora 21, but I can't find the
> > > packages, is there any?
> > > If not, can you please provide packages? I think they are more
> > > important than Fedora 20 packages since F21 has more support time
> > > remaining.
> > 
> > We don't have f21 packages yet; knee deep in other release issues.
> > 
> > We are always looking for people interested in maintaining the upstream CI
> > and build/release environment, though; it's a surprising amount of work
> > keeping it all running!  There are other distros and architectures we're
> > missing too (e.g. we have armv7l hardware but no time to resurrect the
> > builds) for lack to time.
> > 
> > sage
> 
> They look like they are there to me. Am I missing something?
> 
> $ cat /etc/redhat-release
> Fedora release 21 (Twenty One)
> 
> $ yum list ceph\* --showduplicates
> Loaded plugins: langpacks
> Installed Packages
> ceph.x86_64
> 1:0.80.9-1.fc21
> @updates

These packages are from downstream Fedora.  What's missing are more up 
to date packages built and published at ceph.com.  The distro only ships 
one version of Ceph (the most recent LTS), while ceph.com gets everything 
and ceph-deploy let's you choose which stable series or development branch 
to install.  We're also not doing any testing on f21.

sage
