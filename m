From: Sage Weil <sage@inktank.com>
Subject: Re: deb/rpm package purge
Date: Tue, 19 Mar 2013 13:51:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net> <5148C4EE.5090205@inktank.com> <5148CEC2.2050405@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51774 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933611Ab3CSUvX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 16:51:23 -0400
In-Reply-To: <5148CEC2.2050405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, james.page@ubuntu.com, gcs@debian.hu

On Tue, 19 Mar 2013, Dan Mick wrote:
> Is there a way out if you remove the keyrings?

Yeah; you can use the keyring in the mon data dir to refetch any keyrings 
you deleted from /etc/ceph/.

...

I don't disagree with any of this discussion, BTW; I ask the question 
because I want to understand what the packaging best-practices are before 
we put our foot down for what is "right".

sage
