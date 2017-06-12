From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Mon, 12 Jun 2017 14:09:02 -0400
Message-ID: <73f90019-71aa-2cf1-92e8-0ba7087d62a4@redhat.com>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34186 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbdFLSJF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jun 2017 14:09:05 -0400
Received: by mail-qt0-f174.google.com with SMTP id c10so136304950qtd.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 11:09:04 -0700 (PDT)
In-Reply-To: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


On 06/11/2017 08:04 AM, John Spray wrote:
> MgrClient instances (such as those in the daemons, and those in every
> librados instance) open a session with ceph-mgr where they identify
> themselves by entity name and type.  ceph-mgr sends a MgrConfigure
> message, which tells the client whether to both sending stats and how
> often.  ceph-mgr also keeps a copy of the metadata (a la "ceph osd
> metadata...") for OSD and MDS daemons -- it loads all that up at
> startup, and then also freshens it when it sees a daemon restart or
> sees a new daemon.
>
> We would like to have something similar so that the mgr can be aware
> of the existence of other services like RGW gateways, RBD mirror
> services, perhaps also NFS gateways.
>
> The information about each daemon would at a minimum be its identity,
> type, and some static metadata.  It might also include some dynamic
> state/health structure.  The challenging part here is how to expose
> that to the various daemons, given that things like RGW are not known
> in advance to core Ceph and that they just consume the librados
> interface.
>
> It doesn't feel like a particularly natural thing for librados, but
> ultimately whatever we expose to rgw/rbd is de-facto librados, even if
> we put it in a different library or whatever.
>
> So far I've got as far as thinking we should have an extra call just
> in the C++ bindings that lets callers say "Hi, I'm a service not just
> a client, and here's a map of metadata", that they call one time
> between creating their RadosClient and connecting to the cluster.
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi John,

Is there a reason that radosgw can't instantiate its own MgrClient 
instance and report status through that, instead of having to go through 
librados? If we have to report an entity instance, we could choose from 
one of our Rados clients.

Casey
