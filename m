From: Wido den Hollander <wido@42on.com>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Wed, 1 Feb 2017 18:17:19 +0100 (CET)
Message-ID: <654478439.8953.1485969439774@ox.pcextreme.nl>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:38251 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752867AbdBARRZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 12:17:25 -0500
In-Reply-To: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Abhishek Lekshmanan <abhishek@suse.com>
Cc: ceph-devel@vger.kernel.org


> Op 1 februari 2017 om 16:35 schreef Nathan Cutler <ncutler@suse.cz>:
> 
> 
> Hi Abhishek:
> 
> The stable releases and backports team has been working to prepare the 
> Jewel 10.2.6 release and so far we have merged a large number of 
> bugfixes and even some features that were judged to be worth backporting.
> 
> I don't have a full list, yet, because I'm still merging RGW backports 
> and there a few more miscellaneous backports still in the queue. The 
> integration tests are looking better and better, and I expect these will 
> be merged within the next week or two.
> 
> Do you think it's time to publish a 10.2.6 point release?

I would ask to wait a bit. Some long outstanding issues with RGW are data leaks and the orphan scan not working.

These issues:

- http://tracker.ceph.com/issues/18331
- http://tracker.ceph.com/issues/18258

As 10.2.7 might take a long time I would ask to wait for Yehuda. He says to be close. I and many other users would like to see this fixed sooner then later.

Wido

> 
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
