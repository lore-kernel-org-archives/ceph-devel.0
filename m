From: Gregory Farnum <greg@gregs42.com>
Subject: Re: performance latency analysis with LTTng
Date: Thu, 11 Dec 2014 10:36:42 -0800
Message-ID: <CAC6JEv-u97JE0rE-wP=_pOVHLuy9YBBnSaFNwnVb1pEbPiw9VQ@mail.gmail.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB119F0@FMSMSX106.amr.corp.intel.com>
	<20141204102524.663f3804@doppio>
	<3649A15A2562B54294DE14BCE5AC79120AB1432F@FMSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:40153 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758098AbaLKSgn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Dec 2014 13:36:43 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so114741igb.11
        for <ceph-devel@vger.kernel.org>; Thu, 11 Dec 2014 10:36:43 -0800 (PST)
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com. [209.85.213.172])
        by mx.google.com with ESMTPSA id l5sm103093igu.10.2014.12.11.10.36.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Dec 2014 10:36:42 -0800 (PST)
Received: by mail-ig0-f172.google.com with SMTP id hl2so102363igb.17
        for <ceph-devel@vger.kernel.org>; Thu, 11 Dec 2014 10:36:42 -0800 (PST)
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120AB1432F@FMSMSX106.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Cc: Andreas Bluemle <andreas.bluemle@itxperts.de>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Dec 10, 2014 at 10:54 PM, Blinick, Stephen L
<stephen.l.blinick@intel.com> wrote:
> Hi Andreas,  Thanks for providing this info last week.  I've reviewed the data, the annotated spreadsheet is very helpful to interpret the results.    I do think we're seeing similar measurements even though I'm characterizing a more simplified environment.  The key differences are that I'm running with no replication (pool has size=1) and memstore backend.  The client (smallio_bench) in this environment, with a single OSD, qd of 1 (t=1), is seeing a latency on average of about 1200us.  My goal was to account for 100% of this latency via traces in order to determine where to focus  (with other tools, profilers, etc).  So far I'm covering about 750us of the 1200us, missing the time the commit message takes to be dispatched (received) by the client.
>
> In order to do this, I had to run the client on the same node as the OSD, and Vishal Verma on my team added some additional traces to the librados code.  In queue_aio_write, I don't think there's a transaction ID yet so we traced the OID in several places, and then used a script written in perl to attempt to correlate things and process the results.
>
> Beyond that, I think the analysis data is very similar to yours, I need to annotate it. I opted to trace out the time as "delta since last trace" instead of time since start of transaction, and so the entries with higher elapsed times indicate whatever was between those traces took a long time, not necessarily the code at the tracepoint.
>
> I haven't yet accounted for the entire time seen by the client.  From the time the aio_write is queued, until ms_fast_dispatch, I have about 300us of time.. quite large.   I didn't trace the pipe:reader/writer, and I see for you that's ~90us of time.     So that would cover about a third of it.    Additionally, I would like to be able to trace the dispatch of the commit ack (complete_aio_write) but at that point I don't have an OID or tid to correlate to.
>
> One question about the tracing code:  I am a bit concerned about using static sized arrays on the stack to populate with timing..  The reason is, any change by adding a tracepoint to a function would require updating a #define for the index, the array size, and the tracepoint (3 spots).  If one of those is missed it could result in a stack overwrite.  Is the reason for this to reduce the # of traces, or is it to make correlating times easier?
>
> Anyone have any ideas about the relatively high time spent between the client & pipe reader in the OSD?

It sounds like you're not measuring any of the time between giving the
write to the client library and when the OSD finishes receiving it. I
don't have any good intuition about what parts of those take the most
time, but some things that have to happen:
1) librados runs CRUSH calculation on the object
2) librados serializes write operation into a message
3) librados writes into kernel networking stack
4) networking stack does stuff to send
5) networking stack does stuff to receive
6) OSD messenger reads in message
7) OSD messenger deserializes message
8) OSD messenger fast dispatches message

So, lots of that could take up some time. Some of it is covered by
throttlers that will block if there's too much data in-flight at any
given moment.
-Greg
