From: Sage Weil <sage@inktank.com>
Subject: Re: the autobuild gpg key expired!
Date: Fri, 8 Feb 2013 21:18:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302082116240.5874@cobra.newdream.net>
References: <alpine.DEB.2.00.1302072235180.28547@cobra.newdream.net> <51153B74.3040203@de-punkt.de> <alpine.DEB.2.00.1302080955010.21274@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46793 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab3BIFSM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Feb 2013 00:18:12 -0500
In-Reply-To: <alpine.DEB.2.00.1302080955010.21274@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher Kunz <chrislist@de-punkt.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 8 Feb 2013, Sage Weil wrote:
> On Fri, 8 Feb 2013, Christopher Kunz wrote:
> > Am 08.02.13 07:46, schrieb Sage Weil:
> > >  wget -q -O- https://raw.github.com/ceph/ceph/master/keys/autobuild.asc | sudo apt-key add -
> > 
> > This doesn't work because raw.github.com uses a certificate issued to CN
> > = *.a.ssl.fastly.net
> > for whatever reason, and wget will complain.
> > 
> > It complains rightly, because there is no way to verifiy that this is
> > *actually* github.com we're speaking to. If you want the key regardless,
> > you can use this line:
> > 
> > wget --no-check-certificate -q -O-
> > https://raw.github.com/ceph/ceph/master/keys/autobuild.asc | sudo
> > apt-key add -
> 
> We're setting up https on ceph.com so that we can publish these securely, 
> and will follow up with another email (and an update to the docs).

Ceph.com how has SSL and the docs are updated with new locations for the 
signing keys.

For official releases:

 wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -

For autobuilt packages:

 wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/autobuild.asc' | sudo apt-key add -

sage
