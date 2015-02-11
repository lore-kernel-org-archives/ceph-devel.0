From: Sage Weil <sage@newdream.net>
Subject: Re: Standardization of perf counters comments
Date: Wed, 11 Feb 2015 10:00:17 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502110958030.3035@cobra.newdream.net>
References: <loom.20150211T183150-492@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36574 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbBKSAR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 13:00:17 -0500
In-Reply-To: <loom.20150211T183150-492@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alyona Kiseleva <akiselyova@mirantis.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 11 Feb 2015, Alyona Kiseleva wrote:
> Hi,
> I would like to propose something.
> 
> There are a lot of perf counters in different places in code, but the most
> of them are undocumented. I found only one commented counter in OSD.cc code,
> but not for all metrics. Name of counter is not very clear as it's
> description, sometimes isn't at all.
> 
> So, I have an idea, that it would be great, if perf schema would contain not
> only the counter type, but some description too. It can be added in
> PerfCountersBuilder methods - at first as optional parameter with empty
> string by default, later, may be, as required parameter. This short
> description could be saved in perf_counter_data_any_d struct together with
> other counter properties and appear in perf schema as the second counter
> property.
> It is more useful, than just comment all counters in code, because in this
> case we would be able to get counter's description outside ceph in any
> analize program, which will use counter's values for any performance reports.
> 
> I can implement it, if it would be interesting.

This would be very interesting!  We talked about this a while back.  See

http://wiki.ceph.com/Planning/Blueprints/Giant/annotate_perfcounters
http://wiki.ceph.com/Planning/Blueprints/Giant/annotate_config_options
http://pad.ceph.com/p/cdsgiant-annotate-config-perfcounters
http://www.youtube.com/watch?v=bQuGZ-3u8Xw&feature=share&t=3m58s

from the giant CDS.  It's mainly been waiting for a motivated 
developer...  :)

sage
