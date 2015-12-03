From: Dan Mick <dmick@redhat.com>
Subject: Re: Troublesome documentation link on http://ceph.com
Date: Wed, 2 Dec 2015 21:26:33 -0800
Message-ID: <565FD289.6030302@redhat.com>
References: <565D9611.3000109@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbbLCF0e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 00:26:34 -0500
In-Reply-To: <565D9611.3000109@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, ceph-devel@vger.kernel.org

On 12/01/2015 04:44 AM, Nathan Cutler wrote:
> So I go to http://ceph.com and click on the "Documentation" link. In the
> HTML source code the linked URL is http://ceph.com/docs but the HTTP
> server rewrites this to:
> 
> http://docs.ceph.com/docs/v0.80.5/
> 
> Could someone arrange for this to be changed s/v0.80.5/master/ ?
> 
> ( Searching for Ceph documentation is already difficult as it is,
> because Google does not provide links to the master version, but only to
> old outdated versions - see for example the first two search results in
> a Google search for "troubleshoot pgs in ceph":
> http://tinyurl.com/nfuohss )
> 

Yes, agreed; we were in the process of relocating that webserver, so had
been neglecting the old configuration.  Hopefully we'll get it redone
tomorrow (one in a list of a zillion things around the move, but an
important one).

-- 
Dan Mick
Red Hat, Inc.
