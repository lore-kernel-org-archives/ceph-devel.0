From: Sage Weil <sage@inktank.com>
Subject: Re: Re: [PATCH] ceph: Don't do set_layout for file which has been
 written.
Date: Fri, 12 Jul 2013 14:00:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307121358570.25223@cobra.newdream.net>
References: <201307111004467716774@gmail.com>,  <alpine.DEB.2.00.1307111154260.5149@cobra.newdream.net> <201307120851431485280@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57461 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965415Ab3GLVAX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jul 2013 17:00:23 -0400
In-Reply-To: <201307120851431485280@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 12 Jul 2013, majianpeng wrote:
> >On Thu, 11 Jul 2013, majianpeng wrote:
> >> Cephfs don't change the layout which has been written.So add this check
> >> before do.
> >
> >This could conceivaably change in the future, and I'm not sure there is 
> >harm is the MDS round trip to get the error code here...?
> >
> Sorry, i can't understand what's your said. Can you explain in detail?

Sorry.  I mean that someday the MDS might be able to adjust the layout of 
an existing file.  That is probably not something that will happen any 
time soon, though.  It is probably worth merging this (along with the 
GETLAYOUT half) for now.

sage
