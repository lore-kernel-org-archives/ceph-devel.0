From: Sage Weil <sage@inktank.com>
Subject: Re: the autobuild gpg key expired!
Date: Fri, 8 Feb 2013 09:55:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302080955010.21274@cobra.newdream.net>
References: <alpine.DEB.2.00.1302072235180.28547@cobra.newdream.net> <51153B74.3040203@de-punkt.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41296 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946702Ab3BHRzu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 12:55:50 -0500
In-Reply-To: <51153B74.3040203@de-punkt.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher Kunz <chrislist@de-punkt.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 8 Feb 2013, Christopher Kunz wrote:
> Am 08.02.13 07:46, schrieb Sage Weil:
> >  wget -q -O- https://raw.github.com/ceph/ceph/master/keys/autobuild.asc | sudo apt-key add -
> 
> This doesn't work because raw.github.com uses a certificate issued to CN
> = *.a.ssl.fastly.net
> for whatever reason, and wget will complain.
> 
> It complains rightly, because there is no way to verifiy that this is
> *actually* github.com we're speaking to. If you want the key regardless,
> you can use this line:
> 
> wget --no-check-certificate -q -O-
> https://raw.github.com/ceph/ceph/master/keys/autobuild.asc | sudo
> apt-key add -

We're setting up https on ceph.com so that we can publish these securely, 
and will follow up with another email (and an update to the docs).

Thanks!
sage

