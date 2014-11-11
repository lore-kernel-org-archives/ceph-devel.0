From: Sage Weil <sage@newdream.net>
Subject: Re: Pull requests : speed up the reviews
Date: Tue, 11 Nov 2014 10:07:32 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411111003550.24475@cobra.newdream.net>
References: <545E53B5.3070600@dachary.org> <CAC6JEv_xbv54VoFfU+6rOKS7ytR7TbzJM3NZSk_sVKjpDEyQFA@mail.gmail.com> <alpine.DEB.2.00.1411101116110.24475@cobra.newdream.net> <5461171F.8080401@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54680 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbaKKSHc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Nov 2014 13:07:32 -0500
In-Reply-To: <5461171F.8080401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Gregory Farnum <greg@gregs42.com>, Ceph Development <ceph-devel@vger.kernel.org>

We spent some time going through the backlog yesterday and made quite a 
bit of progress (down to 57 open).  A few changes:

- got rid of the firefly, giant, dumpling, etc. tags
- added firefly, giant, dumpling, hammer, next 'milestones'
- rgw and rbd projects have all items assigned
- only 14 unassigned

I also created a wip-sam-testing label to make it a bit easier to track 
what Sam is currently testing (tho nothing is tagged that way yet).

sage
