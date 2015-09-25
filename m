From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Backend ObjectStore engine performance bench with FIO
Date: Fri, 25 Sep 2015 14:22:03 -0400 (EDT)
Message-ID: <720951445.22040695.1443205323581.JavaMail.zimbra@redhat.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03BD7EFC9@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:47252 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764AbbIYSWH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Sep 2015 14:22:07 -0400
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03BD7EFC9@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: Xiaoxi Chen <xiaoxi.chen@intel.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Great work James!

----- Original Message -----
> From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
> To: "Xiaoxi Chen" <xiaoxi.chen@intel.com>, "Casey Bodley" <cbodley@redhat.com>
> Cc: "Sage Weil" <sage@newdream.net>, ceph-devel@vger.kernel.org
> Sent: Friday, September 25, 2015 1:55:29 PM
> Subject: Backend ObjectStore engine performance bench with FIO
> 
> Hi Xiaoxi,
> 
>    With changing the IO mode from aio to sync, we make fio against newstore
>    works. Even  with sync engine(I am still debugging the aio engine in
>    newstore with Xiaoxi) in newstore, Newstore still performing the best
>    among all of backstore engine with our initial setup(Thoroughly test will
>    be run soon). Attachment is the initial data we collected for your
>    reference. Thanks for great help from Xiaoxi from regarding to Newstore
>    development to support FIO.
> 
> Hi Casey,
>   Let me know if you need any help to put fio-ceph-objectstore into upstream.
>   After then , I can commit all of mine into upstream.

My pull request at https://github.com/ceph/ceph/pull/5943 is still pending. If you have patches that you'd like included, I would be happy to pull them in; just point me to a branch.

> 
>   Thanks,
>   James
> 

Thanks,
Casey
