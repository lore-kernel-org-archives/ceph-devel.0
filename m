From: David McBride <dwm@doc.ic.ac.uk>
Subject: Re: Braindump: path names, partition labels, FHS, auto-discovery
Date: Wed, 07 Mar 2012 09:55:01 +0000
Message-ID: <1331114101.19173.34.camel@squire.doc.ic.ac.uk>
References: <CAORUGqB-XXXt3Gdx6xdKupg+dwC7XMGptg-K_2QTmn4ybcK+Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cardinal.doc.ic.ac.uk ([146.169.1.194]:46590 "EHLO
	cardinal.doc.ic.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2CGKis (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Mar 2012 05:38:48 -0500
In-Reply-To: <CAORUGqB-XXXt3Gdx6xdKupg+dwC7XMGptg-K_2QTmn4ybcK+Qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 2012-03-06 at 13:19 -0800, Tommi Virtanen wrote:

> - scan the partitions for partition label with the prefix
> "ceph-osd-data-".

Thought: I'd consider not using a numbered partition label as the
primary identifier for an OSD.

There are failure modes that can occur, for example, if you have disks
from multiple different Ceph clusters accessible to a given host, or if
you have a partially failed (or historical copy) of an OSD disk
accessible at the same time as a current instance.

(Though you might reasonably rule these cases as out-of-scope.)

To make handling cases like these straightforward, I suspect Ceph may
want to use something functionally equivalent to an MD superblock --
though in practice, with an OSD, this could simply be a file containing
the appropriate meta-data.

In fact, I imagine that the OSDs could already contain the necessary
fields -- a reference to their parent cluster's UUID, to ensure foreign
volumes aren't mistakenly mounted; something like mdadm's event-counters
to distinguish between current/historical versions of the same OSD.
(Configuration epoch-count?); a UUID reference to that OSD's journal
file, etc.

 - - -

Perhaps related to this, I've been looking to determine whether it's
feasible to build and configure a Ceph cluster incrementally -- building
an initial cluster containing just a single MON node, and then piecewise
adding additional OSDs / MDSs / MONs to build up to the full-set.

In part, this is so that the processes for initially setting up the
cluster and for expanding the cluster once its in operation are
identical.  But this is also to avoid needing to hand-maintain a
configuration file, replicated across all hosts, that enumerates all of
the different cluster elements -- replicating a function already handled
better by the MON elements.

I can almost see the ceph.conf file only being used at cluster
initialization-time, then discarded in favour of run-time commands that
update the live cluster state.

Is this practical?  (Or even desirable?)

Cheers,
David
-- 
David McBride <dwm@doc.ic.ac.uk>
Department of Computing, Imperial College, London

