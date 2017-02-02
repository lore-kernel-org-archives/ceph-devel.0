From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Thu, 2 Feb 2017 11:50:44 +0100
Message-ID: <a0e7550c-30e1-2cec-ebba-742c9ce2afb0@suse.cz>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
 <654478439.8953.1485969439774@ox.pcextreme.nl>
 <CAGbvivLcCvcKXjECm4AXb11MCnx57QS+ZF8xRt3--CV416hkyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46711 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbdBBKur (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Feb 2017 05:50:47 -0500
In-Reply-To: <CAGbvivLcCvcKXjECm4AXb11MCnx57QS+ZF8xRt3--CV416hkyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>

> Any chance this one gets fixed in 10.2.6?
>
> http://tracker.ceph.com/issues/14115

That's https://github.com/ceph/ceph/pull/12624 which has not been merged 
to master. It can't be backported until it's merged.

Nathan
