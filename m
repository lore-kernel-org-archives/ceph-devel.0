From: Alfredo Deza <adeza@redhat.com>
Subject: Re: debian jessie gitbuilder repositories ?
Date: Mon, 20 Jul 2015 10:29:58 -0400 (EDT)
Message-ID: <1632231469.695823.1437402598629.JavaMail.zimbra@redhat.com>
References: <166369912.15665099.1437377720957.JavaMail.zimbra@oxygem.tv> <alpine.DEB.2.00.1507200719250.18181@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53722 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932696AbbGTOaD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 10:30:03 -0400
In-Reply-To: <alpine.DEB.2.00.1507200719250.18181@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, sepia@ceph.com



----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
> To: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, sepia@ceph.com
> Sent: Monday, July 20, 2015 10:19:49 AM
> Subject: Re: debian jessie gitbuilder repositories ?
> 
> On Mon, 20 Jul 2015, Alexandre DERUMIER wrote:
> > Hi,
> > 
> > debian jessie gitbuilder is ok since 2 weeks now,
> > 
> > http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-jessie-amd64-basic
> > 
> > 
> > It is possible to push packages to repositories ?
> > 
> > http://gitbuilder.ceph.com/ceph-deb-jessie-x86_64-basic/
> 
> 
> The builds are failing with this:
> 
> + GNUPGHOME=/srv/gnupg reprepro --ask-passphrase -b
> ../out/output/sha1/6ffb1c4ae43bcde9f5fde40dd97959399135ed86.tmp -C main
> --ignore=undef
> inedtarget --ignore=wrongdistribution include jessie
> out~/ceph_0.94.2-50-g6ffb1c4-1jessie_amd64.changes
> Cannot find definition of distribution 'jessie'!
> There have been errors!
> 
> 
> I've seen it before a long time ago, but I forget what the resolution is.

I am not 100% how gitbuilders are setup but the DEB builders are meant to be generic
and they can be only when some setup is run to hold the environments for each distro.

The environments are created/updated with pbuilder, so one needs to exist for jessie. There is a script
that can do that called update_pbuilder.sh but that is missing `jessie`:

https://github.com/ceph/ceph-build/blob/master/update_pbuilder.sh#L22-30

A manual call to create the jessie environment for pbuilder would suffice here I think.
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
