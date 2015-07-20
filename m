From: Sage Weil <sage@newdream.net>
Subject: Re: [sepia] debian jessie gitbuilder repositories ?
Date: Mon, 20 Jul 2015 11:06:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507201106050.8878@cobra.newdream.net>
References: <166369912.15665099.1437377720957.JavaMail.zimbra@oxygem.tv> <alpine.DEB.2.00.1507200719250.18181@cobra.newdream.net> <55AD2BA2.3050106@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45390 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbbGTSGQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 14:06:16 -0400
In-Reply-To: <55AD2BA2.3050106@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, sepia@ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 20 Jul 2015, Dan Mick wrote:
> On 07/20/2015 07:19 AM, Sage Weil wrote:
> > On Mon, 20 Jul 2015, Alexandre DERUMIER wrote:
> >> Hi,
> >>
> >> debian jessie gitbuilder is ok since 2 weeks now,
> >>
> >> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-jessie-amd64-basic
> >>
> >>
> >> It is possible to push packages to repositories ?
> >>
> >> http://gitbuilder.ceph.com/ceph-deb-jessie-x86_64-basic/
> > 
> > 
> > The builds are failing with this:
> > 
> > + GNUPGHOME=/srv/gnupg reprepro --ask-passphrase -b 
> > ../out/output/sha1/6ffb1c4ae43bcde9f5fde40dd97959399135ed86.tmp -C main 
> > --ignore=undef
> > inedtarget --ignore=wrongdistribution include jessie 
> > out~/ceph_0.94.2-50-g6ffb1c4-1jessie_amd64.changes
> > Cannot find definition of distribution 'jessie'!
> > There have been errors!
> > 
> > 
> > I've seen it before a long time ago, but I forget what the resolution is.
> > 
> > sage
> > _______________________________________________
> > Sepia mailing list
> > Sepia@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/sepia-ceph.com
> 
> https://github.com/ceph/ceph-build/pull/102, probably

That fixed it, thanks!

sage
