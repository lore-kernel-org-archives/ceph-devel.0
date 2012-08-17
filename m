From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: SimpleMessenger dispatching: cause of performance problems?
Date: Fri, 17 Aug 2012 09:09:03 +0200
Message-ID: <20120817090903.02232a85@andylap2.itxperts.de>
References: <502D1B07.3030101@itxperts.de>
	<CAC-hyiFgdD8EcF1uonkdbAwshDh87aP3NjXBvCPv3gbW7XpazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:41223 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab2HQHJI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 03:09:08 -0400
In-Reply-To: <CAC-hyiFgdD8EcF1uonkdbAwshDh87aP3NjXBvCPv3gbW7XpazQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

please find attached for ceph-0.48argonaut which adds the
timestamp code. The only binary which utilizes these timestamps
is the ceph-osd daemon.

Timestamps are kept in-memory.
Configuration and extraction of timestamps is
achieved through the "ceph osd tell" interface.

Timestamps are only recorded for objects which match a
filtering string.

ceph tell osd.0 code_profile help
 profiling data
 code_profile operations:
    info:  get summary info
    setfilter <regex>: set filter for object IDs
    completed-oids: object IDS for which complete profiling data is available
    pending-oids: object IDS for which incomplete profiling data is available
    get-completed [prefix]:  get profiling data for completed objects
    get-primary-writes [prefix]:  get condensed profiling data for primary write operations
    get-secondary-writes [prefix]:  get condensed profiling data for replica write operations
    get-pending [prefix]:  get profiling data for pending operations
    clear: free storage of profiled data and clear the object ID filter

In order to collect data for an object in a rados block device,
the object ID filter can be set like:

ceph tell osd.0 code_profile setfilter rb.0.0.* 

The timestamp code adds it's own logging susbsystem and hence
is configurable via ceph.conf, like:

debug ITX = 2

From where a timestamp is recorded is specified in the src/common/ITX.h:enum itx_checkpoint.

Note that the patch reflects a just a snapshot in the current
process of anlysis. Example: checkpoints ITX_OSD_DISPATCH4 and ITX_OSD_DISPATCH5
have been used in

       OSD::ms_dispatch(Message *m)

just around the call to _dispatch() and show that
the most of the computing time required for dispatching is spent in this routine.

I threrefore don't believe that throttling is causing the delays.



Best Regards

Andreas




On Thu, 16 Aug 2012 09:44:23 -0700
Yehuda Sadeh <yehuda@inktank.com> wrote:

> On Thu, Aug 16, 2012 at 9:08 AM, Andreas Bluemle
> <andreas.bluemle@itxperts.de> wrote:
> >
> > Hi,
> >
> > I have been trying to migrate a ceph cluster (ceph-0.48argonaut)
> > to a high speed cluster network and encounter scalability problems:
> > the overall performance of the ceph cluster does not scale well
> > with an increase in the underlying networking speed.
> >
> > In short:
> >
> > I believe that the dispatching from SimpleMessenger to
> > OSD worker queues causes that scalability issue.
> >
> > Question: is it possible that this dispatching is causing
> > performance problems?
> >
> >
> > In detail:
> >
> > In order to find out more about this problem, I have added
> > profiling to the ceph code in various place; for write operations
> > to the primary or the secondary, timestamps are recorded for OSD
> > object, offset and length of the such a write request.
> >
> > Timestamps record:
> >  - receipt time at SimpleMessenger
> >  - processing time at osd
> >  - for primary write operations: wait time until replication
> > operation is acknowledged.
> 
> Did you make any code changes? We'd love to see those.
> 
> >
> > What I believe is happening: dispatching requests from
> > SimpleMessenger to OSD worker threads seems to consume a fair
> > amount of time. This ends up in a widening gap between subsequent
> > receipts of requests and the start of OSD processing them.
> >
> > A primary write suffers twice from this problem: first because
> > the delay happens on the primary OSD and second because the
> > replicating OSD also suffers from the same problem - and hence
> > causes additional delays
> > at the primary OSD when it waits for the commit from the
> > replicating OSD.
> >
> > In the attached graphics, the x-axis shows the time (in seconds)
> > The y-axis shows the offset where a request to write happened.
> >
> > The red bar represents the SimpleMessenger receive, i.e. from
> > reading the message header until enqueuing the completely decoded
> > message into the SImpleMessenger dispatch queue.
> 
> Could it be that messages were throttled here?
> There's a configurable that can be set (ms dispatch throttle bytes),
> might affect that.
> 
> >
> > The green bar represents the time required for local processing,
> > i.e. dispatching the the OSD worker, writing to filesystem and
> > journal, send out the replication operation to the replicating OSD.
> > It right end of the green bar is the time when locally everything
> > has finished and a commit could happen.
> >
> > The blue bar represents the time until the replicating OSD has sent
> > a commit
> > back to the primary OSD and the original write request can be
> > committed to the client.
> >
> > The green bar is interrupted by a black bar: the left end represents
> > the time when the request has been enqueued on the OSD worker
> > queue. The right end gives the time when the request is taken off
> > the OSD worker queue and actual OSD processing starts.
> >
> > The test was a simple sequential write to a rados block device.
> >
> > Receiption of the write requests at the OSD is also sequential in
> > the graphics: the bar to the bottom of the graphics shows an
> > earlier write request.
> >
> > Note that the dispatching of a later request in all cases relates
> > to the enqueue time at the OSD worker queue of the previous write
> > request: the left
> > end of a black bar relates nicely to the beginning of a green bar
> > above it.
> >
> >
> 
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
