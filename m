From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: [ceph-users] rbd rm snap on image with exclusive lock
Date: Wed, 25 Oct 2017 15:54:21 +0200
Message-ID: <b1b7b3c9-679d-5371-5fe5-320348da7cec@corp.ovh.com>
References: <6a5fdefb-cd9e-8a29-b668-945312e9827f@corp.ovh.com>
 <CA+aFP1BA-PvFSeJTYbJYmz1guee+N7CvM0E8p_h0pbP=4dO+4g@mail.gmail.com>
 <49a2cf70-fb3b-45bb-fa36-283c4a6bc310@corp.ovh.com>
 <CA+aFP1DHuYzsrsvoowukkGWGowe1P06vyYSk2oqRjXqkRtstjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 2.mo302.mail-out.ovh.net ([137.74.110.75]:48406 "EHLO
        2.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdJYNyY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Oct 2017 09:54:24 -0400
In-Reply-To: <CA+aFP1DHuYzsrsvoowukkGWGowe1P06vyYSk2oqRjXqkRtstjg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 17-10-25 03:30 PM, Jason Dillaman wrote:
> Hmm, hard to say off the top of my head. If you could enable "debug
> librbd = 20" logging on the buggy client that owns the lock, create a
> new snapshot, and attempt to delete it, it would be interesting to
> verify that the image is being properly refreshed.

I'd love to, but that would require us to restart that client - not an 
option. We'll try to reproduce this somehow anyway and let you know if 
something interesting shows up.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
