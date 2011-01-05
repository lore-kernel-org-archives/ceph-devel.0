From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Cluster Operation over Slow Links
Date: Tue, 4 Jan 2011 20:55:35 -0800
Message-ID: <AANLkTi=XDf+pF27dcrrzasQ6BfGXXfoku6uFj11g+FU8@mail.gmail.com>
References: <AANLkTikJ83S2OKuYvU7CaGG3s9YWQj0gRJMsoTPjYbdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63167 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1AEEzg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jan 2011 23:55:36 -0500
Received: by eye27 with SMTP id 27so6593388eye.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jan 2011 20:55:35 -0800 (PST)
In-Reply-To: <AANLkTikJ83S2OKuYvU7CaGG3s9YWQj0gRJMsoTPjYbdb@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Roy <imjustmatthew@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 4, 2011 at 8:09 PM, Matthew Roy <imjustmatthew@gmail.com> wrote:
> The wiki talks about using crush maps to spread data out over
> different racks and servers, but there seems to be no reason crush
> couldn't be used to place data copies in different floors or nearby
> datacenters (think Equinix DC2 and DC7 in Washington - 1-3ms
> 'cross-connect' latency, large pipes). Thinking more broadly, the
> latency between DC7 and home users in Richmond, Virginia is 10-15ms,
> where a user with FiOS can easily get 15Mbps real speed in both
> directions. What is the performance impact of bandwidth and latency,
> especially between complete replica-sets? How far can ceph be pushed
> and what starts to hurt first? Does an entire cluster have to be in
> the same data center, the same city, or the same state?
Ceph will operate over whatever latency/bandwidth you give it, it's
just that things will become really slow.
It's possible to massage things around to disguise latency in some
configurations, but the bottom line is that no matter what
configuration you use, the slowest interconnect is going to dominate
everything else. Over a 15Mbps connection, you're going to get 15Mbps
write speeds at best, and that assumes a very careful map which only
sends data one way, etc.
At those kinds of speeds, you really need to use a
filesystem/application which is designed to handle that kind of
network topology. Ceph is designed for the other end of the spectrum.
-Greg
