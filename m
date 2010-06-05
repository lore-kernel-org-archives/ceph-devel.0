From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: cfuse fail on dbench (ceph.git testing)
Date: Sat, 5 Jun 2010 07:02:49 +0000 (UTC)
Message-ID: <hucsqp$5aa$1@dough.gmane.org>
References: <huag5k$te4$1@dough.gmane.org>
	<Pine.LNX.4.64.1006041631460.2384@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:34091 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081Ab0FEHC6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 5 Jun 2010 03:02:58 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OKnPE-0006K9-QO
	for ceph-devel@vger.kernel.org; Sat, 05 Jun 2010 09:02:56 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 09:02:56 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 09:02:56 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Fri, 04 Jun 2010 16:32:54 -0700 schrieb Sage Weil:

> On Fri, 4 Jun 2010, Thomas Mueller wrote:
>> cfuse fails dbench with ceph.git testing. See logs:
> 
> Hi Thomas,
> 
> I've fixed this (and some related ObjectCacher bugs).  dbench exercised
> a bunch of cache code that previous tests apparently hadn't hit.  Pushed
> to the 'unstable' branch of ceph.git.
> 
> sage

thanks, the unstable branch passes the dbench test now (http://
chaschperli.ch/testing/testDetails.php?test=81&build=45)

- Thomas

