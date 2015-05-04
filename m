From: Sage Weil <sweil@redhat.com>
Subject: Re: Draft retirement mail for dumpling
Date: Mon, 4 May 2015 08:39:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505040835591.24939@cobra.newdream.net>
References: <554749D3.1060306@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbbEDPkW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 May 2015 11:40:22 -0400
In-Reply-To: <554749D3.1060306@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 4 May 2015, Loic Dachary wrote:
> Hi Sage,
> 
> Do you think it's worth sending a mail announcing the retirement of 
> dumpling ?

Yeah!  

> It could be something like:
> 
> Hi,
> 
> Dumpling, the first major stable release of Ceph[1] published August 2013 retires after more than 18 months of service. People running a Dumpling cluster should upgrade to Firefly and then to Hammer. 

s/first major stable/major stable/.

Also, I think we should adjust the timeline page to avoid use of the term 
LTS (long term supported) and possibly "support" in general as that word 
means pretty specific things to most people.  Instead, we should say that 
the developer community backports bug fixes to these releases.  I 
don't think it is a good idea to make promises about timeframes either.

Something closer to this?

	https://github.com/liewegas/ceph/commit/0415040f1ac6cc22259fc409ed8fc33f86e58c35

sage
