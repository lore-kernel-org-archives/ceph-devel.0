From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: [ceph-users] rbd rm snap on image with exclusive lock
Date: Wed, 25 Oct 2017 15:23:31 +0200
Message-ID: <49a2cf70-fb3b-45bb-fa36-283c4a6bc310@corp.ovh.com>
References: <6a5fdefb-cd9e-8a29-b668-945312e9827f@corp.ovh.com>
 <CA+aFP1BA-PvFSeJTYbJYmz1guee+N7CvM0E8p_h0pbP=4dO+4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 11.mo301.mail-out.ovh.net ([37.187.190.77]:57021 "EHLO
        11.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdJYNXf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Oct 2017 09:23:35 -0400
In-Reply-To: <CA+aFP1BA-PvFSeJTYbJYmz1guee+N7CvM0E8p_h0pbP=4dO+4g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 17-10-25 02:39 PM, Jason Dillaman wrote:
> That log is showing that a snap remove request was made from a client
> that couldn't acquire the lock to a client that currently owns the
> lock. The client that currently owns the lock responded w/ an -ENOENT
> error that the snapshot doesn't exist. Depending on the maintenance
> operation requested, different errors codes are filtered out to handle
> the case where Ceph double (or more) delivers the request message to
> the lock owner. Normally this isn't an issue since the local client
> pre-checks the image state before sending the RPC message (i.e. snap
> remove will first locally ensure the snap exists and respond w/
> -ENOENT if it doesn't).
> 
> Therefore, in this case, the question is who is this rogue client that
> still owns the lock and is responding the a snap remove request but
> hasn't refreshed its state to know that the snapshot exists.

Thanks, that makes things clear.

Seems like we have some Cinders utilizing Infernalis (9.2.1) librbd. Are you 
aware of any bugs in 9.2.x that could cause such behavior? We've seen that 
for the first time...

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
