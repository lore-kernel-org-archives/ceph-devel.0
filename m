From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: releasing jewel v10.2.3 ?
Date: Fri, 19 Aug 2016 16:05:30 +0300
Message-ID: <20160819130529.GC17630@gmail.com>
References: <57B698D0.1050409@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36837 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754444AbcHSNFd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2016 09:05:33 -0400
Received: by mail-lf0-f42.google.com with SMTP id g62so32420136lfe.3
        for <ceph-devel@vger.kernel.org>; Fri, 19 Aug 2016 06:05:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57B698D0.1050409@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Loic,

I think this regression is highly desirable to be merged to jewel
before the release:

http://tracker.ceph.com/issues/16654

I have just merged Jason's PR to master.

On Fri, Aug 19, 2016 at 07:27:44AM +0200, Loic Dachary wrote:
> Hi Sage,
> 
> Here are the issues that would be in jewel v10.2.3 if we decided to release it now: http://tracker.ceph.com/versions/518
> And here is the backport queue : http://tracker.ceph.com/projects/ceph/issues?query_id=96
> 
> Do you think it is time to cut the release and ask QE to start testing ?
> 
> Cheers
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
