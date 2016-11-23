From: Alfredo Deza <adeza@redhat.com>
Subject: Re: ./ceph-deploy gatherkeys $HOST failing on master?
Date: Wed, 23 Nov 2016 08:30:27 -0500
Message-ID: <CAC-Np1zam01+BNbKyoFK0Nvx+MTMh+Jp9OA7hsmgyEh-a2Z-Lw@mail.gmail.com>
References: <f6e89a41-294b-9538-f4dc-d5c026920477@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34808 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936601AbcKWNbe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2016 08:31:34 -0500
Received: by mail-qt0-f171.google.com with SMTP id n6so11330850qtd.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2016 05:30:28 -0800 (PST)
In-Reply-To: <f6e89a41-294b-9538-f4dc-d5c026920477@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 22, 2016 at 8:32 AM, Owen Synge <osynge@suse.com> wrote:
> Dear all,
>
> Yuri and I have been playing timezone ping pong on the subject of:
>
> http://qa-proxy.ceph.com/teuthology/teuthology-2016-11-20_11:50:01-ceph-deploy-master-distro-basic-mira/565105/teuthology.log
>
> Unfortunately this is not a good week for me to move into the western
> hemisphere timezone.
>
> I consider the significant issue to be:
>
>  /usr/bin/ceph --connect-timeout=25 --cluster=ceph --name mon.
> --keyring=/var/lib/ceph/mon/ceph-mira061/keyring auth get client.admin
>
> Where "ceph-mira061" is the mon service name on the local node.
>
> Which seems to be failing on master.
>
> I do not see this with older releases. But until I can replicate this
> bug, I do not yet raise it as a bug.
>
> Do others see this on master or any other release?

Do you mean ceph-deploy master or ceph master?
>
> It should be easy to replicate with:
>
>     ceph-deploy mon create-initial
>
> Or more directly (and easier to see) with:
>
>     ceph-deploy gatherkeys $HOST
>
> Best wishes
>
> Owen
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
