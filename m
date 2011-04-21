From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: long object names
Date: Fri, 22 Apr 2011 00:58:24 +0200
Message-ID: <4DB0B690.4060104@provocation.net>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>	<20110421185606.GC9431@dreamer>	<BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>	<20110421193240.GA26545@dreamer>	<99672323C62444DFA181A0659E4D37FC@gmail.com>	<BANLkTimvdNXA+F6sTS0HqkdUqE1uqFNkJA@mail.gmail.com>	<BANLkTikVQcMKsR1WY8uBQOk1KQ+tO+ezXA@mail.gmail.com>	<BANLkTikfqcYyiqirZ9zY+ZMiLbc-=BodRg@mail.gmail.com>	<BANLkTi=Nx2=mC0C_70vjwxuJ94UKB93xhw@mail.gmail.com> <BANLkTikdCJUxcO6yDjCTANonftqgRZD51w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:59164 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab1DUW62 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 18:58:28 -0400
In-Reply-To: <BANLkTikdCJUxcO6yDjCTANonftqgRZD51w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


>> It needs to be populated first before being efficient. And it'll be
>> less efficient now that you populate it with extra entries.

At the risk of being run out of town covered in tar and feathers, I'll
venture voicing the opinion of an end-user who doesn't know ceph, is not
a developer, and doesn't even understand half of the technicalities of
this discussion.

From my end-user point of view, efficiency is great and very desirable,
but is still secondary. Simplicity of code and the reduction of bugs that
comes with it is great and adds elegance to intelligence, but is still
secondary. The safety of data though, now, that is primary and above
everything else when it comes to a file system. A file system's *only*
purpose is to store and retrieve data. Efficiency and speed are features,
positive qualities that make a file system better, but only as long as
it actually can fulfil its purpose of storing and retrieving data without
losing or corrupting them.

Looking at it this way, the potential of a hash collision is catastrophic
no matter how small it might be. The measure of this problem is not the
objective likelihood that it will occur, but the subjective level of worry
that it might occur. Simply put, even if there's one chance of a hash
collision in 10 billion and I only have a couple of million files, I still
end up being unable to trust the integrity of *any* of them.

One might argue here that no file system in this world offers a 100% file
integrity guarantee. That's absolutely true, but it is and should remain
a shortcoming and not be elevated to an intentional design feature.

Z

