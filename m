From: Gregory Farnum <greg@inktank.com>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 13:23:00 -0700
Message-ID: <CAPYLRzhLpmmTX+GjSPtiToY+yRUSwhc1EJ6G9q=pExi4n3A1QQ@mail.gmail.com>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
	<alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net>
	<CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com>
	<CAPYLRzhh4390wjuZkEuEqs0=3SBX729kEou5NkqmVbBaJWG_rQ@mail.gmail.com>
	<CAPrxi5_G1cQ9XK9dnOP0Sgda_PYNQmj9TyqdO7D+Y7TXoYvuOQ@mail.gmail.com>
	<alpine.DEB.2.00.1208301314370.8588@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55006 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab2H3UXB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 16:23:01 -0400
Received: by iahk25 with SMTP id k25so82686iah.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 13:23:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208301314370.8588@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

It's not an MDS problem; it handles the client mount requests in at
most .2 seconds. I'm looking through the client log and I see:

2012-08-30 12:48:21.875546 7f8a6d1f3780 10 client.4105  target mds.0
not active, waiting for new mdsmap
2012-08-30 12:48:21.875771 7f8a68737710  1 -- 192.168.106.225:0/2716
<== mon.0 192.168.106.225:6789/0 5 ==== osd_map(5..5 src has 1..5) v3
==== 1376+0+0 (2208396468 0 0) 0x2e56a00 con 0x2e68640
2012-08-30 12:48:24.872889 7f8a67f36710  1 -- 192.168.106.225:0/2716
--> 192.168.106.225:6789/0 -- mon_subscribe({mdsmap=0+,monmap=2+}) v2
-- ?+0 0x2e65700 con 0x2e68640

So it looks like it's waiting for some internal tick before sending
off the MDSMap request to the monitor?
(Both the monitor and MDS logs indicate they're promptly satisfying
the client requests as soon as received, as well. So this is
definitely the issue.)
-Greg

On Thu, Aug 30, 2012 at 1:15 PM, Sage Weil <sage@inktank.com> wrote:
> I see that Server::handle_client_session is calling mdlog->flush(), so
> it's a bit odd.  Can you generate a log with 'debug ms = 1' on the client
> (and maybe mds) side?
>
> s
>
> On Thu, 30 Aug 2012, Noah Watkins wrote:
>
>> On Thu, Aug 30, 2012 at 1:06 PM, Gregory Farnum <greg@inktank.com> wrote:
>> > On Thu, Aug 30, 2012 at 12:55 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> >> Using a tick interval of 1 drops the cost down to 3 seconds, but still
>> >> a long time for running many unit tests that use fresh mounts.
>> >
>> > Are you using ceph-fuse or the kernel client? And how many of each daemon type?
>>
>> I'm using the C api, and there are 3 mon, 3 mds, 1 osd.
>>
>> > That said; I'm seeing broadly similar numbers ? with one of each
>> > daemon (but otherwise the vstart defaults) "time sudo ceph-fuse mnt"
>> > reports 3.1 seconds.
>>
>>
