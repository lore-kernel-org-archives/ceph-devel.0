From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: v9.0.0 binaries
Date: Thu, 7 May 2015 19:36:49 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166435117@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166434F20@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1505071212440.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0107.outbound.protection.outlook.com ([207.46.100.107]:55328
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751167AbbEGTww convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 May 2015 15:52:52 -0400
In-Reply-To: <alpine.DEB.2.00.1505071212440.28239@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ah, and I see that this ceph-deploy line will install them...
with
   ceph-deploy install --testing hostname

or
   ceph-deploy install --dev 9.0.0 hostname

(at least this worked on Ubuntu trusty)

-- Tom

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Thursday, May 07, 2015 2:13 PM
> To: Deneau, Tom
> Cc: ceph-devel
> Subject: Re: v9.0.0 binaries
> 
> On Thu, 7 May 2015, Deneau, Tom wrote:
> > Will there be binary packages built for v9.0.0?
> 
> They're already built--look in the -testing repos.  For example,
> ceph.com/debian-testing and ceph.com/rpm-testing.
> 
> sage
