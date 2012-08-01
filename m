From: Wido den Hollander <wido@widodh.nl>
Subject: Re: ceph data store size
Date: Wed, 01 Aug 2012 15:33:21 +0200
Message-ID: <50193021.7070009@widodh.nl>
References: <5018E379.4030208@lanning.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:55708 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab2HANdY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 09:33:24 -0400
In-Reply-To: <5018E379.4030208@lanning.cc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lanning@lanning.cc
Cc: ceph development <ceph-devel@vger.kernel.org>

On 08/01/2012 10:06 AM, Robert Hajime Lanning wrote:
> Anyone using ceph on multi petabyte data stores?

I don't think so

> For example, a cluster of 12 systems with a combined storage of 2.3P.
>

With 12 systems, you mean 12 servers with a lot of disks? That's roughly 
200TB per server.

On that scale I don't think Ceph would work, it would mean you would 
need a HUGE amount of CPU and memory on those boxes to run the OSD's.

If you want to scale to 2.3P you should be looking in the direction of 
hunderds of small machines all storing a couple of TB.

Wido


