From: Jan Kratochvil <jan.kratochvil@redhat.com>
Subject: Re: Fedora 21 packages
Date: Mon, 30 Mar 2015 17:17:31 +0200
Message-ID: <20150330151731.GA17645@host1.jankratochvil.net>
References: <CAMWPydSzi4E8YmwL+-0PFbnNTFvEJ3duVFigfmnrTWzwFQY9QQ@mail.gmail.com>
 <alpine.DEB.2.00.1503281034470.18934@cobra.newdream.net>
 <551874D0.1090900@redhat.com>
 <alpine.DEB.2.00.1503291644260.8441@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbbC3PRj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Mar 2015 11:17:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1503291644260.8441@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Brad Hubbard <bhubbard@redhat.com>, Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 30 Mar 2015 01:45:55 +0200, Sage Weil wrote:
> These packages are from downstream Fedora.  What's missing are more up 
> to date packages built and published at ceph.com.  The distro only ships 
> one version of Ceph (the most recent LTS), while ceph.com gets everything 
> and ceph-deploy let's you choose which stable series or development branch 
> to install.  We're also not doing any testing on f21.

That's not the Fedora way.  LTS-like packages are not for Fedora, those are
for CentOS/RHEL (but where Ceph LTS is already present).  Latest development
packages are for Fedora Rawhide.  And for other cases there is also
https://fedorahosted.org/copr .

I have filed for Fedora-shipped ceph-deploy:
	https://bugzilla.redhat.com/show_bug.cgi?id=1207275


Jan
