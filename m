From: Sage Weil <sage@inktank.com>
Subject: RE: Slow requests
Date: Sun, 16 Dec 2012 14:54:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212161454110.18820@cobra.newdream.net>
References: <50CDD3DB.7000501@mermaidconsulting.dk> <C4049E4484F13747B672D64B9C12C31328DADAC9@PWMAILM01.cscinfo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60844 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab2LPWyl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Dec 2012 17:54:41 -0500
In-Reply-To: <C4049E4484F13747B672D64B9C12C31328DADAC9@PWMAILM01.cscinfo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Cc: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

v0.52 is also quite old.  This was resolved in v0.55, I believe.  Where 
are you looking for the RPMs?  v0.55 should be there...

sage


On Sun, 16 Dec 2012, Holcombe, Christopher wrote:

> I heard the solution for this was to restart the osd's.  That fixed it for me.
> 
> -Chris
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Jens Kristian S?gaard
> Sent: Sunday, December 16, 2012 9:00 AM
> To: ceph-devel@vger.kernel.org
> Subject: Slow requests
> 
> Hi,
> 
> My log is filling up with warnings about a single slow request that has been around for a very long time:
> 
> osd.1 10.0.0.2:6800/900 162926 : [WRN] 1 slow requests, 1 included below; oldest blocked for > 84446.312051 secs
> 
> osd.1 10.0.0.2:6800/900 162927 : [WRN] slow request 84446.312051 seconds old, received at 2012-12-15 15:27:56.891437:
> osd_sub_op(client.4528.0:19602219 0.fe
> 3807b5fe/rb.0.11b7.4a933baa.00000008629e/head//0 [] v 53'185888 snapset=0=[]:[] snapc=0=[]) v7 currently started
> 
> 
> How can I identify the cause of this and how can I cancel this request?
> 
> I'm running Ceph on Fedora 17 using the latest RPMs available from ceph.com (0.52-6).
> 
> 
> Thanks in advance,
> --
> Jens Kristian S?gaard, Mermaid Consulting ApS,
> jens@mermaidconsulting.dk,
> http://www.mermaidconsulting.com/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> ________________________________
> 
> NOTICE: This e-mail and any attachments is intended only for use by the addressee(s) named herein and may contain legally privileged, proprietary or confidential information. If you are not the intended recipient of this e-mail, you are hereby notified that any dissemination, distribution or copying of this email, and any attachments thereto, is strictly prohibited. If you receive this email in error please immediately notify me via reply email or at (800) 927-9800 and permanently delete the original copy and any copy of any e-mail, and any printout.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
