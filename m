From: Sage Weil <sage@newdream.net>
Subject: Re: packaging init systems in a more autoools style way.
Date: Wed, 3 Jun 2015 14:38:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506031438210.26591@cobra.newdream.net>
References: <556F1E19.6080704@suse.com> <alpine.DEB.2.00.1506030919460.9814@cobra.newdream.net> <556F6480.1090901@suse.com> <alpine.DEB.2.00.1506031344370.26591@cobra.newdream.net> <556F7344.4030003@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38073 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbbFCVip (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jun 2015 17:38:45 -0400
In-Reply-To: <556F7344.4030003@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Owen Synge <osynge@suse.com>, ceph-devel@vger.kernel.org

On Wed, 3 Jun 2015, Ken Dreyer wrote:
> On 06/03/2015 02:45 PM, Sage Weil wrote:
> > Sounds good to me.  It could (should?) even error out if no init
> system is
> > specified?  Otherwise someone will likely be in for a surprise.
> 
> I was picturing that we'd just autodetect based on OS version (eg Ubuntu
> 15.04 should default to --with-init=systemd). It's one less thing to get
> wrong during the build process.
> 
> What do you think?

./configure ... --with-init=`src/ceph-detect-init` ?

sage
