From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] Ceph mon quorum
Date: Fri, 5 Apr 2013 10:50:38 -0700
Message-ID: <CAPYLRzgoF0my7dQwknKSt=8YMo8uqVpweE4qATXM4jgUbD9GvA@mail.gmail.com>
References: <CAEqYNSY3yfa2W1c3OXZOFgipJyvyquHz5+mNdJjpGex2jEq9OA@mail.gmail.com>
	<515ECA2A.9000505@42on.com>
	<515EE76C.1000204@bmrb.wisc.edu>
	<515EE9FB.80402@42on.com>
	<515F09D4.8070202@bmrb.wisc.edu>
	<CAPYLRzjhJ8HN4d7RBAt9TbVHMb0UtGC1HmhjwDeOLOicnROUog@mail.gmail.com>
	<515F0E08.8010301@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:60945 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162230Ab3DERuj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 13:50:39 -0400
Received: by mail-qc0-f180.google.com with SMTP id b40so1708346qcq.39
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 10:50:38 -0700 (PDT)
In-Reply-To: <515F0E08.8010301@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Apr 5, 2013 at 10:46 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
> On 04/05/2013 12:32 PM, Gregory Farnum wrote:
> ...
>> Or just a VM running somewhere that's got a VPN connection to your
>> room-based monitors, yes. Ceph is a strongly consistent system and
>> you're not going to get split brains, period. This is the price you
>> pay for that.
>
> Yeah, well. You are in building A talking to the servers in room A. The
> building catches fire, you run over to building B and connect to the
> servers in room B. Unfortunately your uplink was in A's basement, it is
> now powered off and flooded, and so mon.b has no connection to
> mon.in.the.cloud and your data is unreachable.
>
> Which means both building B and mon.in.the.cloud were a total waste of
> your time and money.

Obviously you would need them each to have their own independent
connection, yes. I'm sorry if this aspect of the system is problematic
for you, but it's pretty fundamental to any distributed or cloudy
system that chooses consistency over availability.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
