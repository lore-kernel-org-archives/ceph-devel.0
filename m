From: Sage Weil <sage@inktank.com>
Subject: Re: CEPH - messenger rebind race
Date: Wed, 7 May 2014 17:52:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405071725210.24873@cobra.newdream.net>
References: <1399452455.72957.YahooMailNeo@web140901.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbaEHAw2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 20:52:28 -0400
In-Reply-To: <1399452455.72957.YahooMailNeo@web140901.mail.bf1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@yahoo.com>
Cc: greg@inktank.com, ceph-devel@vger.kernel.org

[CCing Greg and ceph-devel]

On Wed, 7 May 2014, Guang Yang wrote:
> Hi Sage,
> Sorry to bother you directly, I am debugging / fixing issue
> http://tracker.ceph.com/issues/8232, during which time I studied the
> messenger component of CEPH. With more understanding of the messenger
> component, I started getting confused by the fix of issue 6992
> (http://tracker.ceph.com/issues/6992) in terms of how it could help to solve
> the problem (though I fully agree we should stop accepter first and then
> clear all PIPEs).
> 
> Looking at the logs posted along with the issue 6992, the failure happened
> at pipe::writter::connect side (it should be a brand new connect instead of
> a re-connect as cs = 0, pgs = 0) after a rebind, and the failed one already
> has the updated local address, it is confused to me how the connection could
> be established? As there is connect_seq check at the remote side which is
> likely to fail for this connection attempt (which is a positive value),
> unless there is some race at remote side updating connet_seq and in_seq.
> 
> Am I missing something obviously on this?

Honestly I haven't looked closely at that old log; I would focus on the 
new log.

Looking at it now (for the first time, sorry), the last line is

    -2> 2014-05-04 06:16:07.957897 7f71063ee700  2 -- 
10.193.207.180:6884/1037605 >> 10.193.207.183:6958/5001307 pipe(0x1cfa1400 
sd=132 :60749 s=1 pgs=0 cs=0 l=0 c=0x12b4e160). got newly_acked_seq 10 vs 
out_seq 0

If I'm reading it right, that's an outgoing connection with the same 
source as the mark_down_all.  If it existed before the mark_down_all, 
something is really broken because mark_dwon_all should have set it to 
STATE_CLOSED and the connect() function checks the state.  Which makes me 
think that it was initiated after.

My guess is that this is a race in OSD.cc.  We do the rebind() stuff, but 
only a bit further down do consume_map() which publishes the map to the 
OSDService with all kind of complicated handoff.  I'm forgetting right now 
how this is supposed to work, but my guess is that this is the heart of 
the problem: some random PG thread is trying to send to an OSD using the 
older map and grabs the older OSDMap ref and opens the connection 
*after* we do the rebind() and mark_down_all().

Does this sound plausible?

sage
