From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: Pool setting for recovery priority
Date: Tue, 29 Sep 2015 21:47:42 +0300
Message-ID: <20150929184741.GA19934@gmail.com>
References: <BLU175-W30B038F9EE84A31BF7D842DF5B0@phx.gbl>
 <alpine.DEB.2.00.1509160920120.14342@cobra.newdream.net>
 <20150921133218.GB23240@gmail.com>
 <20150925114440.GA30636@gmail.com>
 <alpine.DEB.2.00.1509250708531.13265@cobra.newdream.net>
 <BLU175-W32A058482A229644D8A329DF4E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:34793 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935252AbbI2Srq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Sep 2015 14:47:46 -0400
Received: by labzv5 with SMTP id zv5so19898713lab.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Sep 2015 11:47:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BLU175-W32A058482A229644D8A329DF4E0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: Weil Sage <sweil@redhat.com>, Mykola Golub <mgolub@mirantis.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, David Zafman <dzafman@redhat.com>

On Tue, Sep 29, 2015 at 10:23:54AM -0700, GuangYang wrote:

> I sort of misunderstood the pain point here, I thought we wanted to
> simplify from CLI side to set those parameters as we have more and
> more pool level setting, not from an internal implementation's
> perspective..
>
> Thanks Mykola for implementing this, I will rebase the priority
> setting stuff against it.

Ah, so you are working on adding per pool priority options? Because I
have just started working on this too, but if you already do this I
will abandon it.

-- 
Mykola Golub
