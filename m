From: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>
Subject: RE: Ceph watchdog-like thing to reduce IO block during process goes
 down by abort()
Date: Mon, 4 Apr 2016 12:29:23 +0000
Message-ID: <80195f66349b4b8cb7daaf4bd8e30490@R01UKEXCASM222.r01.fujitsu.local>
References: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local>
 <CAOi1vP89OgUmvozXRO9cvNS-KYaSkBGQRkPS3UeNa2+kgAHkmA@mail.gmail.com>
 <CAJ4mKGbDQEyRfeMskBwsTxK_qoJY_4GfGfFz1h1ht6h6E0xhSg@mail.gmail.com>
 <CANP1eJFto2wEGaWt_dgys-cMQn_6t3wFrWwcURwkX0Y+HY_PKQ@mail.gmail.com>
 <alpine.DEB.2.11.1603251109400.26068@cpach.fuggernut.com>
 <9939bca9f29e4dafadf5946cf4392a98@R01UKEXCASM222.r01.fujitsu.local>
 <6be5638226ba40f89bf9bdfb35fefe8e@R01UKEXCASM222.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.164]:31275 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751747AbcDDM3u convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Apr 2016 08:29:50 -0400
Received: from R01UKEXCASM224.r01.fujitsu.local (ex2k13_224.fs.fujitsu.com [10.182.185.122])
	by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id u34CTYZA007702
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Mon, 4 Apr 2016 13:29:38 +0100
In-Reply-To: <6be5638226ba40f89bf9bdfb35fefe8e@R01UKEXCASM222.r01.fujitsu.local>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

First of all I wanted to thank you all for the discussion.

Now, to sum up pros and cons:

1. Separate watchdog process.
Pros:
- prevent of IO block at every case when OSD is going dead by abort(), kill -9, oom kill, whatever
- will work with single hdd down and whole controller
- no additional time to hold process in "bad" state

Cons:
- another process needs to be maintained/tested/documented, cephx keys, files etc.
- additional startups scripts needs to be created/maintained...
- new test needs to be written
- need another connection to monitor (not good for small nodes with one hdd/osd)
- additional open socket from every osd to watchdog  or open/write/close to named pipe before assert()

2. ceph_abort_markmedown() before ceph_abort()
Pros:
- prevent IO block in most cases related with disk access
- done in existing code, nothing new to maintain
- assert cleanups, potential good place from where can gather statistics in the future
- will work with single hdd down and whole controller

Cons:
- tests needs to be written (maybe extending existing ?)
- can be done only in special places when connection to monitor is already been made and working
- needs to be implemented mostly by hand
- some places could be missed
- some additional time to hold process in "bad" state, waiting for MarkMeDown ack

If we go into ceph_abort_markmedown(),  this is basically cxwshawn's past PR 6514, so I would feel bad if I just redo it. He was first with this idea, maybe he could reopen it or somehow we'll do it together. I would like to have clear situation here.


Another idea:
3. Use existing heartbeat for fast-mark dead OSD neighbor.

The idea:
When process goes dead, all sockets are closed, one from HB too. Then OSD::heartbeat_reset(..) is triggered (on other osd) to close old/reopen connections to dead one.

When connection with HB peer was closed and that peer had the same address as we (the same node), we could send MOSDFailure() with out of grace time. This combined with "mon osd min down reporters" set to > 1, could mark the osd down immediately by its neighbors.

So this would change/speedup HB behavior only for local osds.

The question is does it make sense? What would be the case, when all connections on HB from one osd will be closed/restarted, other than abort()/kill/shutdown. Firewall reconfiguration, too many open files/sockets, nf_contrack problem?

If only one/some of those connections will be down (but less than osd min down reporters) and then recreated, osd will start sending new heartbeats and it won't be marked as down.

Pros:
- prevent of IO block at every case when OSD is going dead by abort(), kill -9, oom kill, whatever. BUT only with "mon osd min down reporters" set to proper value and other neighbor OSDs being alive.
- done in one place in existing code
- no additional time to hold process in "bad" state

Cons:
- test need to be written, or maybe existing HB or "min down reporters" could cover this?
- "osd min down reporters" could be wrongly calculated
- will work only when connection to monitor is already been made and working
- messing/changing  already working HB infrastructure, which is tested and stable
- could miss whole drive controller fail, since every osd will be down in small time window
- won't work in environment with one osd per node
- need local neighbors to work
- if something goes wrong (caused by bad implementation of this idea) osd could flap in down/up state


So ... where do we go from here?

Looking on the most visible cons of 1 vs 2 is "maintenance" vs "process at bad state in some time".
Most visible pros:  1 vs 2 is "all osd dead cases covered" vs "better asserts and error tracking"


Regards,
Igor.
