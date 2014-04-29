From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: default filestore max sync interval
Date: Tue, 29 Apr 2014 22:36:55 +0200
Message-ID: <53600D67.1000501@profihost.ag>
References: <3B502314D0477C4F9478870C279E14E60118278B1F@CERNXCHG51.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:55688 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbaD2Unb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Apr 2014 16:43:31 -0400
In-Reply-To: <3B502314D0477C4F9478870C279E14E60118278B1F@CERNXCHG51.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Van Der Ster <daniel.vanderster@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Dan,

Am 29.04.2014 22:10, schrieb Dan Van Der Ster:
> Hi all,
> Why is the default max sync interval only 5 seconds?
>
> Today we realized what a huge difference that increasing this to 30 or 60s can do for the small write latency. Basically, with a 5s interval our 4k write latency is above 30-35ms and once we increase it to 30s we can get under 10ms (using spinning disks for journal and data.)
>
> See the attached plot for the affect of this on a running cluster (the plot shows the max, avg, min write latency from a short rados bench every 10 mins). The change from 5s to 60s was applied at noon today. (And our journals are large enough, don't worry).
>
> In the interest of having sensible defaults, is there any reason not to increase this to 30s?

I was playing with them too but didn't get any viewable results. How do 
you get / graph the ceph latency?

Greets,
Stefan
