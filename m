From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: upgrade procedure to Luminous
Date: Fri, 14 Jul 2017 15:43:31 +0100
Message-ID: <fc4f8401-b6f1-32a6-fea5-08a308abb29f@suse.de>
References: <fc6ff947-e806-84c8-4eae-099a465482c6@suse.de>
 <alpine.DEB.2.11.1707141407300.27271@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34319 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754298AbdGNOnd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Jul 2017 10:43:33 -0400
In-Reply-To: <alpine.DEB.2.11.1707141407300.27271@piezo.novalocal>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On 07/14/2017 03:12 PM, Sage Weil wrote:
> On Fri, 14 Jul 2017, Joao Eduardo Luis wrote:
>> On top of this all, I found during my tests that any OSD, running luminous
>> prior to the luminous quorum, will need to be restarted before it can properly
>> boot into the cluster. I'm guessing this is a bug rather than a feature
>> though.
> 
> That sounds like a bug.. probably didn't subscribe to map updates from
> _start_boot() or something.  Can you open an immediate ticket?

http://tracker.ceph.com/issues/20631

   -Joao
