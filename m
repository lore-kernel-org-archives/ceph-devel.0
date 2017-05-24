From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Beta testing crush optimization
Date: Wed, 24 May 2017 15:50:42 +0200
Message-ID: <c4186786-d7ff-097d-ac71-1dbb12d58540@profihost.ag>
References: <07dda37f-b8c9-f977-c767-6c1c4bc78fd6@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:56509 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1764760AbdEXNup (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 May 2017 09:50:45 -0400
In-Reply-To: <07dda37f-b8c9-f977-c767-6c1c4bc78fd6@dachary.org>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hello,

great! What means pool 3? Is it just the pool nr from the poll dump / ls
command?

Stefan

Am 24.05.2017 um 15:48 schrieb Loic Dachary:
> Hi Stefan,
> 
> Thanks for volunteering to beta test the crush optimization on a live cluster :-)
> 
> The "crush optimize" command was published today[1] and you should be able to improve your cluster distribution with the following:
> 
> ceph report > report.json
> crush optimize --no-forecast --step 64 --crushmap report.json --pool 3 --out-path optimized.crush
> ceph osd setcrushmap -i optimized.crush
> 
> Note that it will only perform a first optimization step (moving around 64 PGs). You will need to repeat this command a dozen time to fully optimize the cluster. I assume that's what you will want to control the workload. If you want a minimal change at each step, you can try --step 1 but it will require more than a hundred steps.
> 
> If you're not worried about the load of the cluster, you can optimize it in one go with:
> 
> ceph report > report.json
> crush optimize --crushmap report.json --pool 3 --out-path optimized.crush
> ceph osd setcrushmap -i optimized.crush
> 
> Cheers
> 
> [1] http://crush.readthedocs.io/en/latest/ceph/optimize.html
> 
