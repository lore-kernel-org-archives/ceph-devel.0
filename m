From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Memory Pooling and Containers
Date: Fri, 30 Sep 2016 14:47:05 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1609301112330.8582@ancalagon.suse.de>
References: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1609281316210.19847@piezo.us.to> <alpine.LSU.2.20.1609281413450.13361@ancalagon.suse.de>
 <BLUPR0201MB152427C4BD08DEDB9178C89AE8CF0@BLUPR0201MB1524.namprd02.prod.outlook.com>,<alpine.DEB.2.11.1609301416270.19850@piezo.us.to> <0AA35578-9667-4B81-BE6A-71C8326B76F1@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932687AbcI3VrL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 30 Sep 2016 17:47:11 -0400
In-Reply-To: <0AA35578-9667-4B81-BE6A-71C8326B76F1@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 30 Sep 2016, Allen Samuels wrote:

> I'm expecting the "in-object" capabilities of the slab_xxxxx containers 
> to dramatically reduce malloc/free calls. Also having some visibility 
> into where the memory is actually going will also spur a bit more 
> development that will likely have more significant positive effects.

Definitely sounds useful! I see that some works been done with massif, 
too.

Also, I took a quick peek into boost::pool. It's built exactly as you 
said-- specifically for the manu-small-objects situation. I didn't see an 
"obvious" way to hook in a new freelist scheme.

Have a great weekend,

-Jesse

