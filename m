From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Logging
Date: Mon, 18 Apr 2011 20:17:05 +0200
Message-ID: <4DAC8021.6000701@provocation.net>
References: <4DAB77FD.4010804@provocation.net>	<BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>	<4DAC0EE7.4080001@provocation.net> <BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:33597 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab1DRSRM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 14:17:12 -0400
In-Reply-To: <BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



On 04/18/2011 07:16 PM, Colin McCabe wrote:

> If you'd like to measure performance without logging, first set all
> the debug levels to 0. You should be able to do this, at least in
> head-of-line, with this:

> Then disable all the log sinks with this:

Thanks, that's the part I was missing.

In the meanwhile I found a major bottleneck in my cluster, namely the fact
that I had mounted the ext4 partitions that hold the stores with atime
enabled. I should have thought of it earlier...

Z


