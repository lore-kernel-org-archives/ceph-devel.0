From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: throttles
Date: Tue, 13 Oct 2015 15:54:52 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF919252061D@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91925201E3@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1510130541070.6589@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0088.outbound.protection.outlook.com ([157.56.111.88]:54694
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932298AbbJMPy7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 11:54:59 -0400
In-Reply-To: <alpine.DEB.2.00.1510130541070.6589@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Tuesday, October 13, 2015 7:44 AM
> To: Deneau, Tom
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: throttles
> 
> On Mon, 12 Oct 2015, Deneau, Tom wrote:
> > Looking at the perf counters on my osds, I see wait counts for the
> > following throttle related perf counters:  (This is from trying to
> > benchmark using multiple rados bench client processes).
> >
> >    throttle-filestore_bytes
> 
> OPTION(filestore_queue_max_ops, OPT_INT, 50)
> OPTION(filestore_queue_max_bytes, OPT_INT, 100 << 20)
> 
> >    throttle-msgr_dispatch_throttler-client
> 
> OPTION(ms_dispatch_throttle_bytes, OPT_U64, 100 << 20)
> 
> >    throttle-osd_client_bytes
> >    throttle-osd_client_messages
> 
> OPTION(osd_client_message_size_cap, OPT_U64, 500*1024L*1024L) // client
> data allowed in-memory (in bytes)
> OPTION(osd_client_message_cap, OPT_U64, 100)              // num client
> messages allowed in-memory
> 
> > What are the config variables that would allow me to experiment with
> these throttle limits?
> > (When I look at the output from --admin-daemon osd.xx.asok config
> > show, it's not clear which items these correspond to).
> 
> These are all involved in slowing down clients to the rate of the
> storage...
> 
> sage

Thanks, Sage and Somnath --

The reason I was interested is that I am seeing a levelling
off of read bandwidth while the sar data shows we are not anywhere
near the limits for cpu utilization (client or osd node) nor
for disk utilization (no disk above 40% utilization) nor for
network utilization (this is with 10Gig Ethernet).

-- Tom

