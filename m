From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: radosstriper build failure on i386
Date: Thu, 26 Jun 2014 15:27:55 +0200
Message-ID: <1403789275.24105.34.camel@sebmain.cern.ch>
References: <alpine.DEB.2.00.1406251427470.24410@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:23608 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbaFZN3C (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Jun 2014 09:29:02 -0400
In-Reply-To: <alpine.DEB.2.00.1406251427470.24410@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Took me some time to set up a build environment on 32 bits but you can
find the fixes in the following pull request :
https://github.com/ceph/ceph/pull/2032

Sebastien

On Wed, 2014-06-25 at 14:28 -0700, Sage Weil wrote:
> Hi Sebastien,
> 
> There are several build errors we didn't notice before merging in 
> radosstriper:
> 
> 	http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-saucy-i386-basic/log.cgi?log=31b59d6626f64d4f5f4a1960b4084eaea7ed79f0
> 
> Do you mind taking a look?
> 
> Thanks!
> sage


