From: Sage Weil <sage@newdream.net>
Subject: Re: throttles
Date: Tue, 13 Oct 2015 05:44:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510130541070.6589@cobra.newdream.net>
References: <BC97738F8E7C8742BABED7F06FB9DF91925201E3@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42317 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbbJMMoG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 08:44:06 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91925201E3@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 12 Oct 2015, Deneau, Tom wrote:
> Looking at the perf counters on my osds, I see wait counts for the following
> throttle related perf counters:  (This is from trying to benchmark using
> multiple rados bench client processes).
> 
>    throttle-filestore_bytes

OPTION(filestore_queue_max_ops, OPT_INT, 50)
OPTION(filestore_queue_max_bytes, OPT_INT, 100 << 20)

>    throttle-msgr_dispatch_throttler-client

OPTION(ms_dispatch_throttle_bytes, OPT_U64, 100 << 20)

>    throttle-osd_client_bytes
>    throttle-osd_client_messages

OPTION(osd_client_message_size_cap, OPT_U64, 500*1024L*1024L) // client data allowed in-memory (in bytes)
OPTION(osd_client_message_cap, OPT_U64, 100)              // num client messages allowed in-memory

> What are the config variables that would allow me to experiment with these throttle limits?
> (When I look at the output from --admin-daemon osd.xx.asok config show, it's
> not clear which items these correspond to).

These are all involved in slowing down clients to the rate of the 
storage...

sage
