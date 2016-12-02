From: Sage Weil <sweil@redhat.com>
Subject: Ceph QoS user stories
Date: Fri, 2 Dec 2016 19:01:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612021847590.22800@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbcLBTBn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Dec 2016 14:01:43 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Hi all,

We're working on getting infrasture into RADOS to allow for proper 
distributed quality-of-service guarantees.  The work is based on the 
mclock paper published in OSDI'10

	https://www.usenix.org/legacy/event/osdi10/tech/full_papers/Gulati.pdf

There are a few ways this can be applied:

 - We can use mclock simply as a better way to prioritize background 
activity (scrub, snap trimming, recovery, rebalancing) against client IO.
 - We can use d-mclock to set QoS parameters (e.g., min IOPS or 
proportional priority/weight) on RADOS pools
 - We can use d-mclock to set QoS parameters (e.g., min IOPS) for 
individual clients.

Once the rados capabilities are in place, there will be a significant 
amount of effort needed to get all of the APIs in place to configure and 
set policy.  In order to make sure we build somethign that makes sense, 
I'd like to collection a set of user stores that we'd like to support so 
that we can make sure we capture everything (or at least the important 
things).

Please add any use-cases that are important to you to this pad:

	http://pad.ceph.com/p/qos-user-stories

or as a follow-up to this email.

mClock works in terms of a minimum allocation (of IOPS or bandwidth; they 
are sort of reduced into a single unit of work), a maximum (i.e. simple 
cap), and a proportional weighting (to allocation any additional capacity 
after the minimum allocations are satisfied).  It's somewhat flexible in 
terms of how we apply it to specific clients, classes of clients, or types 
of work (e.g., recovery).  How we put it all together really depends on 
what kinds of things we need to accomplish (e.g., do we need to support a 
guaranteed level of service shared across a specific set of N different 
clients, or only individual clients?).

Thanks!
sage

