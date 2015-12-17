From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Subject: RE: Configuration of your benchmark for the performance report with
 functrace
Date: Thu, 17 Dec 2015 00:26:54 +0000
Message-ID: <99767EA2E27DD44DB4E9F9B9ACA458C0561A71C7@SSIEXCH-MB3.ssi.samsung.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C0561A7181@SSIEXCH-MB3.ssi.samsung.com>
 <3649A15A2562B54294DE14BCE5AC79120B904690@FMSMSX119.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:54579 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178AbbLQA05 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 19:26:57 -0500
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120B904690@FMSMSX119.amr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Stephen,
  We setup two methods in house for performance breakdown against ceph repo (wip-blkin branch).
  1. The performance bench and latency breakdown with BLKIN(zipkin+lttng). As far as we know, It needs lot of efforts to get it support on new Ceph release like infernalis.
  2. The performance bench and latency breakdown with lttng(functrace). 
  We might soon to port our work to infernalis once we find bandwidth.  However, I did not quite understand your question like "   We are currently not seeing it capture any traces, but a build based on Hammer works..." . It should be easy to port functrace to support infernalis , right? 

  Regards,
  James

-----Original Message-----
From: Blinick, Stephen L [mailto:stephen.l.blinick@intel.com] 
Sent: Wednesday, December 16, 2015 4:01 PM
To: James (Fei) Liu-SSI
Subject: RE: Configuration of your benchmark for the performance report with functrace

Hi, first of all I'm sorry I didn't respond to your other queries a few weeks back.  I have been buried with end of the year stuff, and the hardware is in use on Infernalis work.

Next -- the full ceph.conf and yaml file with CBT we used for our all-flash stuff is in the backup slides of this deck: http://www.slideshare.net/Inktank_Ceph/accelerating-cassandra-workloads-on-ceph-with-allflash-pcie-ssds

But let me know if you want any more info, like the partition sizing. I think our journal partitions are 20GB each.   Lttng with all the function tracing I did had an impact of about 15% to latency & performance.   Make sure to increase the lttng buffer sizes a reasonable amount.  I did something like this:
       lttng  create
       lttng enable-channel -u cephtrc --subbuf-size 2097152 
       lttng enable-event -u -a -c cephtrc
       lttng add-context -c cephtrc -u -t pthread_id Then lttng start/stop/view/destroy....

Lastly -- did you get lttng to work on infernalis?  We are currently not seeing it capture any traces, but a build based on Hammer works...

Thanks,

Stephen


-----Original Message-----
From: James (Fei) Liu-SSI [mailto:james.liu@ssi.samsung.com]
Sent: Wednesday, December 16, 2015 4:57 PM
To: Blinick, Stephen L
Subject: Configuration of your benchmark for the performance report with functrace

HI Stephen,
  Thanks for your great help. We are successfully duplicate your effort over here to run the functrace and breakdown the latency. However, We got very high latency in our bench. I was wondering whether we can know your hardware configuration and ceph.conf.

Appreciate for your great help as always.

Regards,
James

-----Original Message-----
From: Cbt [mailto:cbt-bounces@lists.ceph.com] On Behalf Of Blinick, Stephen L
Sent: Monday, December 07, 2015 1:49 PM
To: Blyth, Logan; cbt@lists.ceph.com
Subject: Re: [Cbt] Is this list still active?

I still monitor this list (as do some others I believe).  And we still use CBT for our Ceph performance work. 

Thanks,

Stephen


-----Original Message-----
From: Cbt [mailto:cbt-bounces@lists.ceph.com] On Behalf Of Blyth, Logan
Sent: Monday, December 7, 2015 2:43 PM
To: cbt@lists.ceph.com
Subject: [Cbt] Is this list still active?

Or does the discussion take place elsewhere? perhaps ceph-users?

Logan
_______________________________________________
Cbt mailing list
Cbt@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/cbt-ceph.com
_______________________________________________
Cbt mailing list
Cbt@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/cbt-ceph.com
