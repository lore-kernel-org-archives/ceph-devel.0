From: Sage Weil <sage@inktank.com>
Subject: Re: how to monitor journal utilization
Date: Wed, 20 Jun 2012 12:30:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206201229290.14284@cobra.newdream.net>
References: <CACkq2mo=3_6QSbeSJvaEdhfkv5A-jQOgnF8UqzEtqfpKXYUKOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42223 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757679Ab2FTTaU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 15:30:20 -0400
In-Reply-To: <CACkq2mo=3_6QSbeSJvaEdhfkv5A-jQOgnF8UqzEtqfpKXYUKOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 20 Jun 2012, Travis Rhoden wrote:
> Is there a way I can monitor the utilization of the OSD journal?  I
> would like to know if data is coming in fast enough to fill the
> journal, and thus slow down all the subsequent writes.
> 
> Once the journal is full, that becomes the bottleneck for writes, no?
> (assuming that writes to the journal are faster than the OSD -- such
> as with tmpfs or an SSD.  I'm using tmpfs).

Not yet.  It should be instrumented with PerfCounters similar to the other 
components, but that hasn't happened yet.  Opening

	http://tracker.newdream.net/issues/2619

sage
