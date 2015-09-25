From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: Pool setting for recovery priority
Date: Fri, 25 Sep 2015 20:50:43 +0300
Message-ID: <20150925175042.GA3831@gmail.com>
References: <BLU175-W30B038F9EE84A31BF7D842DF5B0@phx.gbl>
 <alpine.DEB.2.00.1509160920120.14342@cobra.newdream.net>
 <20150921133218.GB23240@gmail.com>
 <20150925114440.GA30636@gmail.com>
 <alpine.DEB.2.00.1509250708531.13265@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34346 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932634AbbIYRur (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Sep 2015 13:50:47 -0400
Received: by lacdq2 with SMTP id dq2so51153009lac.1
        for <ceph-devel@vger.kernel.org>; Fri, 25 Sep 2015 10:50:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1509250708531.13265@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, GuangYang <yguang11@outlook.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, David Zafman <dzafman@redhat.com>

On Fri, Sep 25, 2015 at 07:09:53AM -0700, Sage Weil wrote:
> Hi Mykola,
> 
> On Fri, 25 Sep 2015, Mykola Golub wrote:
> > What do you think about this implementation, which adds a dictionary
> > for pool options to pg_pool_t?
> > 
> > https://github.com/ceph/ceph/pull/6081
> > 
> > Although #5922 has already been merged to master, I think it is still
> > not late to change scrub intervals to be stored in options?
> 
> Yeah, I agree that something along these lines is better.  It's too late 
> to add this to infernalis, though.. I think we should revert the scrub 
> interval options and then use the dictionary (post-infernalis).
> 
> How does that sound?

I sounds good to me. I will rebase #6081 against master after the
previous patch is reverted and mark it [DNM].

-- 
Mykola Golub
