From: Matthew Roy <imjustmatthew@gmail.com>
Subject: Cluster Operation over Slow Links
Date: Tue, 4 Jan 2011 23:09:11 -0500
Message-ID: <AANLkTikJ83S2OKuYvU7CaGG3s9YWQj0gRJMsoTPjYbdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49015 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab1AEEJM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jan 2011 23:09:12 -0500
Received: by qyj19 with SMTP id 19so17764765qyj.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jan 2011 20:09:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Has anyone tried to operate (or simulated) a cluster over various link
speeds? There was a mailing list question months ago about ceph over
"WAN" and the consensus was that it would not perform well - but
there's a broad spectrum of link speeds and latencies in the real
world - LAN and WAN are pretty blurry these days, especially in the
datacenters were large clusters will live.

The wiki talks about using crush maps to spread data out over
different racks and servers, but there seems to be no reason crush
couldn't be used to place data copies in different floors or nearby
datacenters (think Equinix DC2 and DC7 in Washington - 1-3ms
'cross-connect' latency, large pipes). Thinking more broadly, the
latency between DC7 and home users in Richmond, Virginia is 10-15ms,
where a user with FiOS can easily get 15Mbps real speed in both
directions. What is the performance impact of bandwidth and latency,
especially between complete replica-sets? How far can ceph be pushed
and what starts to hurt first? Does an entire cluster have to be in
the same data center, the same city, or the same state?

Matthew
