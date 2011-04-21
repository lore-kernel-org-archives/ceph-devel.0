From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 16:04:09 -0700
Message-ID: <BANLkTi=m5=Cwi64Sacgb7GiAmdEG408LJg@mail.gmail.com>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
	<20110421185606.GC9431@dreamer>
	<BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
	<20110421193240.GA26545@dreamer>
	<99672323C62444DFA181A0659E4D37FC@gmail.com>
	<BANLkTimvdNXA+F6sTS0HqkdUqE1uqFNkJA@mail.gmail.com>
	<BANLkTikVQcMKsR1WY8uBQOk1KQ+tO+ezXA@mail.gmail.com>
	<BANLkTikfqcYyiqirZ9zY+ZMiLbc-=BodRg@mail.gmail.com>
	<BANLkTi=Nx2=mC0C_70vjwxuJ94UKB93xhw@mail.gmail.com>
	<BANLkTikdCJUxcO6yDjCTANonftqgRZD51w@mail.gmail.com>
	<4DB0B690.4060104@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46144 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab1DUXEK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 19:04:10 -0400
Received: by iwn34 with SMTP id 34so142627iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 16:04:09 -0700 (PDT)
In-Reply-To: <4DB0B690.4060104@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 21, 2011 at 3:58 PM, Zenon Panoussis <oracle@provocation.net> wrote:
>
>>> It needs to be populated first before being efficient. And it'll be
>>> less efficient now that you populate it with extra entries.
>
> At the risk of being run out of town covered in tar and feathers, I'll
> venture voicing the opinion of an end-user who doesn't know ceph, is not
> a developer, and doesn't even understand half of the technicalities of
> this discussion.
>
> From my end-user point of view, efficiency is great and very desirable,
> but is still secondary. Simplicity of code and the reduction of bugs that
> comes with it is great and adds elegance to intelligence, but is still
> secondary. The safety of data though, now, that is primary and above
> everything else when it comes to a file system. A file system's *only*
> purpose is to store and retrieve data. Efficiency and speed are features,
> positive qualities that make a file system better, but only as long as
> it actually can fulfil its purpose of storing and retrieving data without
> losing or corrupting them.
>
> Looking at it this way, the potential of a hash collision is catastrophic
> no matter how small it might be. The measure of this problem is not the
> objective likelihood that it will occur, but the subjective level of worry
> that it might occur. Simply put, even if there's one chance of a hash
> collision in 10 billion and I only have a couple of million files, I still
> end up being unable to trust the integrity of *any* of them.
>
> One might argue here that no file system in this world offers a 100% file
> integrity guarantee. That's absolutely true, but it is and should remain
> a shortcoming and not be elevated to an intentional design feature.
>

We fully understand your worry, and in any case with the hashing
solution it doesn't mean that when there's a collision you lose the
data, just that the data lookup needs to traverse more objects.

HTH,
Yehuda
