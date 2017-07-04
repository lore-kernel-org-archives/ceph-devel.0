From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: ceph-mon leader election problem, should it be improved ?
Date: Tue, 4 Jul 2017 14:25:06 +0100
Message-ID: <cfb3c139-7423-644f-ce4c-00d55cce5756@suse.de>
References: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751902AbdGDNZJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Jul 2017 09:25:09 -0400
In-Reply-To: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Z Will <zhao6305@gmail.com>, ceph-devel@vger.kernel.org, Ceph Users <ceph-users@lists.ceph.com>, Sage Weil <sage@newdream.net>

On 07/04/2017 06:57 AM, Z Will wrote:
> Hi:
>    I am testing ceph-mon brain split . I have read the code . If I
> understand it right , I know it won't be brain split. But I think
> there is still another problem. My ceph version is 0.94.10. And here
> is my test detail :
>
> 3 ceph-mons , there ranks are 0, 1, 2 respectively.I stop the rank 1
> mon , and use iptables to block the communication between mon 0 and
> mon 1. When the cluster is stable, start mon.1 .  I found the 3
> monitors will all can not work well. They are all trying to call  new
> leader  election . This means the cluster can't work anymore.
>
> Here is my analysis. Because mon will always respond to leader
> election message, so , in my test, communication between  mon.0 and
> mon.1 is blocked , so mon.1 will always try to be leader, because it
> will always see mon.2, and it should win over mon.2. Mon.0 should
> always win over mon.2. But mon.2 will always responsd to the election
> message issued by mon.1, so this loop will never end. Am I right ?
>
> This should be a problem? Or is it  was just designed like this , and
> should be handled by human ?

This is a known behaviour, quite annoying, but easily identifiable by 
having the same monitor constantly calling an election and usually 
timing out because the peon did not defer to it.

In a way, the elector algorithm does what it is intended to. Solving 
this corner case would be nice, but I don't think there's a good way to 
solve it. We may be able to presume a monitor is in trouble during the 
probe phase, to disqualify a given monitor from the election, but in the 
end this is a network issue that may be transient or unpredictable and 
there's only so much we can account for.

Dealing with it automatically would be nice, but I think, thus far, the 
easiest way to address this particular issue is human intervention.

   -Joao
