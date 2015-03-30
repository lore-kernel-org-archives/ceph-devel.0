From: Sage Weil <sage@newdream.net>
Subject: Re: Fedora 21 packages
Date: Mon, 30 Mar 2015 08:34:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503300832280.23387@cobra.newdream.net>
References: <CAMWPydSzi4E8YmwL+-0PFbnNTFvEJ3duVFigfmnrTWzwFQY9QQ@mail.gmail.com> <alpine.DEB.2.00.1503281034470.18934@cobra.newdream.net> <551874D0.1090900@redhat.com> <alpine.DEB.2.00.1503291644260.8441@cobra.newdream.net>
 <20150330151731.GA17645@host1.jankratochvil.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60159 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbbC3PeJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Mar 2015 11:34:09 -0400
In-Reply-To: <20150330151731.GA17645@host1.jankratochvil.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Kratochvil <jan.kratochvil@redhat.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 30 Mar 2015, Jan Kratochvil wrote:
> On Mon, 30 Mar 2015 01:45:55 +0200, Sage Weil wrote:
> > These packages are from downstream Fedora.  What's missing are more up 
> > to date packages built and published at ceph.com.  The distro only ships 
> > one version of Ceph (the most recent LTS), while ceph.com gets everything 
> > and ceph-deploy let's you choose which stable series or development branch 
> > to install.  We're also not doing any testing on f21.
> 
> That's not the Fedora way.  LTS-like packages are not for Fedora, those are
> for CentOS/RHEL (but where Ceph LTS is already present).  Latest development
> packages are for Fedora Rawhide.  And for other cases there is also
> https://fedorahosted.org/copr .

In that case, I think the latest stable release (e.g., giant) should go in 
Fedora.  Maybe we could put the latest development release in Rawhide, but 
I'm nto sure.  They're really not intended for end users.

sage

> 
> I have filed for Fedora-shipped ceph-deploy:
> 	https://bugzilla.redhat.com/show_bug.cgi?id=1207275
> 
> 
> Jan
> 
> 
