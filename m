From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Memory Pooling and Containers
Date: Wed, 28 Sep 2016 14:16:32 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1609281413450.13361@ancalagon.suse.de>
References: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1609281316210.19847@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754238AbcI1VQh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Sep 2016 17:16:37 -0400
In-Reply-To: <alpine.DEB.2.11.1609281316210.19847@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 28 Sep 2016, Sage Weil wrote:

> It would be nice to build this on top of existing allocator libraries if
> we can.  For example, something in boost.  I took a quick peek the other
> day and didn't find something that allowed simple interrogation about
> utilization, though, which was surprising.

Boost::pool look to me like it should fufill most of the requirements, but 
I haven't used it in production:
http://www.boost.org/doc/libs/1_62_0/libs/pool/doc/html/index.html

By "iterrogation about utilization", do you mean statistics about the 
allocator activity?

-Jesse
