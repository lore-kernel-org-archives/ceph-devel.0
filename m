From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: throttles
Date: Tue, 13 Oct 2015 15:59:53 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9192520646@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91925201E3@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1510130541070.6589@cobra.newdream.net>
 <BC97738F8E7C8742BABED7F06FB9DF919252061D@SATLEXDAG01.amd.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F31741523@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0054.outbound.protection.outlook.com ([65.55.169.54]:43476
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932274AbbJMP77 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 11:59:59 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F31741523@SACMBXIP02.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I remember previously there were some options that could be reset
thru the admin socket and some that required an osd restart.
Do the ones below require an osd restart?

-- Tom

> -----Original Message-----
> From: Somnath Roy [mailto:Somnath.Roy@sandisk.com]
> Sent: Tuesday, October 13, 2015 10:57 AM
> To: Deneau, Tom; Sage Weil
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: throttles
> 
> BTW, you can completely turn off these throttles ( other than the
> filestore throttle ) by setting the value to 0.
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Deneau, Tom
> Sent: Tuesday, October 13, 2015 8:55 AM
> To: Sage Weil
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: throttles
> 
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@newdream.net]
> > Sent: Tuesday, October 13, 2015 7:44 AM
> > To: Deneau, Tom
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: throttles
> >
> > On Mon, 12 Oct 2015, Deneau, Tom wrote:
> > > Looking at the perf counters on my osds, I see wait counts for the
> > > following throttle related perf counters:  (This is from trying to
> > > benchmark using multiple rados bench client processes).
> > >
> > >    throttle-filestore_bytes
> >
> > OPTION(filestore_queue_max_ops, OPT_INT, 50)
> > OPTION(filestore_queue_max_bytes, OPT_INT, 100 << 20)
> >
> > >    throttle-msgr_dispatch_throttler-client
> >
> > OPTION(ms_dispatch_throttle_bytes, OPT_U64, 100 << 20)
> >
> > >    throttle-osd_client_bytes
> > >    throttle-osd_client_messages
> >
> > OPTION(osd_client_message_size_cap, OPT_U64, 500*1024L*1024L) //
> > client data allowed in-memory (in bytes)
> > OPTION(osd_client_message_cap, OPT_U64, 100)              // num client
> > messages allowed in-memory
> >
> > > What are the config variables that would allow me to experiment with
> > these throttle limits?
> > > (When I look at the output from --admin-daemon osd.xx.asok config
> > > show, it's not clear which items these correspond to).
> >
> > These are all involved in slowing down clients to the rate of the
> > storage...
> >
> > sage
> 
> Thanks, Sage and Somnath --
> 
> The reason I was interested is that I am seeing a levelling off of read
> bandwidth while the sar data shows we are not anywhere near the limits for
> cpu utilization (client or osd node) nor for disk utilization (no disk
> above 40% utilization) nor for network utilization (this is with 10Gig
> Ethernet).
> 
> -- Tom
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is
> intended only for the use of the designated recipient(s) named above. If
> the reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please
> notify the sender by telephone or e-mail (as shown above) immediately and
> destroy any and all copies of this message in your possession (whether
> hard copies or electronically stored copies).

