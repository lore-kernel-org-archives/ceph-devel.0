From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: wip-claim-3: Re: wip-claim-2
Date: Tue, 9 Dec 2014 11:49:13 -0500 (EST)
Message-ID: <1838912097.137.1418143753679.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1412081357370.10613@cobra.newdream.net>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2604 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757651AbaLIQtV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Dec 2014 11:49:21 -0500
In-Reply-To: <alpine.DEB.2.00.1412081357370.10613@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Pushed wip-claim-3, which makes the changes you requested in IRC, plus adds a unittest block.

Matt

----- "Sage Weil" <sage@newdream.net> wrote:

> On Mon, 8 Dec 2014, Matt W. Benjamin wrote:
> > Hi devs,
> > 
> > We've created a new branch wip-claim-2, and new pull request
> https://github.com/linuxbox2/linuxbox-ceph/pull/3
> > based on review feedback.
> > 
> > The big change is to replace "volatile" with "sharable", and replace
> "strong_claim()" with "clone_nonsharable()."
> > This may not be perfect, feedback appreciated.  It does remove the
> overloading of "claim()", which people found
> > confusing.
> 
> I made a few comments, but overall it looks okay to me.  Can you make
> the 
> next pull request against the github.com/ceph/ceph repo instead of
> your 
> clone?
> 
> 	https://github.com/ceph/ceph/compare
> 
> Thanks!
> sage

-- 
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
