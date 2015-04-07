From: John Spray <john.spray@redhat.com>
Subject: RFC: progress bars
Date: Tue, 07 Apr 2015 13:54:32 +0100
Message-ID: <5523D388.6010008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36573 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754441AbbDGMye (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Apr 2015 08:54:34 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t37CsY39025753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 7 Apr 2015 08:54:34 -0400
Received: from [10.36.4.133] (vpn1-4-133.ams2.redhat.com [10.36.4.133])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t37CsXoC025884
	for <ceph-devel@vger.kernel.org>; Tue, 7 Apr 2015 08:54:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

[this is a re-send of a mail from yesterday that didn't make it, 
probably due to an attachment]

It has always annoyed me that we don't provide a simple progress bar 
indicator for things like the migration of data from an OSD when it's 
marked out, the rebalance that happens when we add a new OSD, or 
scrubbing the PGs on an OSD.

I've experimented a bit with adding user-visible progress bars for some 
of the simple cases (screenshot at http://imgur.com/OaifxMf). The code 
is here:
https://github.com/ceph/ceph/blob/wip-progress-events/src/mon/ProgressEvent.cc 


This is based on a series of "ProgressEvent" classes that are 
instantiated when certain things happen, like marking and OSD in or 
out.  They provide an init() hook that captures whatever state is needed 
at the start of the operation (generally noting which PGs are affected) 
and a tick() hook that checks whether the affected PGs have reached 
their final state.

Clearly, while this is simple for the simple cases, there are lots of 
instances where things will overlap: a PG can get moved again while it's 
being backfilled following a particular OSD going out. These progress 
indicators don't have to capture that complexity, but the goal would be 
to make sure they did complete eventually rather than getting 
stuck/confused in those cases.

This is just a rough cut to play with the idea, there's no persistence 
of the ProgressEvents, and the init/tick() methods are peppered with 
correctness issues.  Still, it gives a flavour of how we could add 
something friendlier like this to expose simplified progress indicators.

Ideas for further work:
  * Add in an MDS handler to capture the progress of an MDS rank as it 
goes through replay/reconnect/clientreplay
  * A handler for overall cluster restart, that noticed when the mon 
quorum was established and all the map timestamps were some time in the 
past, and then generated progress based on OSDs coming up and PGs peering.
  * Simple: a handler for PG creation after pool creation
  * Generate estimated completion times from the rate of progress so far
  * Friendlier PGMap output, by hiding all PG states that are explained 
by an ongoing ProgressEvent, to only indicate low level PG status for 
things that the ProgressEvents don't understand.

Cheers,
John
