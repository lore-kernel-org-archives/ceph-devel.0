From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph.com
Date: Thu, 16 Apr 2015 12:15:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504161214331.18547@cobra.newdream.net>
References: <CAAZbbf3dnrjC3Y=vODZAsX=K6fhKC9OjOS051s5BnW_gbC67yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53454 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbbDPTP5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 15:15:57 -0400
In-Reply-To: <CAAZbbf3dnrjC3Y=vODZAsX=K6fhKC9OjOS051s5BnW_gbC67yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <pmcgarry@redhat.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>

We've fixed it so that 404 handling isn't done by wordpress/php and 
things are muuuch happier.  We've also moved all of the git stuff to 
git.ceph.com.  There is a redirect from http://ceph.com/git to 
git.ceph.com (tho no https on the new site yet) and a proxy for 
git://ceph.com.

Please let us know if anything still appears to be broken or slow!

Thanks-
sage
