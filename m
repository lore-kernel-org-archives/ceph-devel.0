From: Jeff Layton <jlayton@redhat.com>
Subject: Re: extend cephadm to do minimal client setup for kcephfs (and
 maybe krbd)?
Date: Fri, 20 Mar 2020 11:26:15 -0400
Message-ID: <407b958e768145625d6c58a2c09392539bf07144.camel@redhat.com>
References: <833eb05d54ca8338843566a1fce9afee9283bdb2.camel@redhat.com>
         <alpine.DEB.2.21.2003201502120.21681@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32657 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbgCTP0T (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:26:19 -0400
Received: by mail-qv1-f71.google.com with SMTP id ev8so6058357qvb.1
        for <ceph-devel@vger.kernel.org>; Fri, 20 Mar 2020 08:26:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.2003201502120.21681@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "dev@ceph.io" <dev@ceph.io>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 2020-03-20 at 15:04 +0000, Sage Weil wrote:
> On Fri, 20 Mar 2020, Jeff Layton wrote:
> > I've had this PR sitting around for a while:
> > 
> >     https://github.com/ceph/ceph/pull/31885
> > 
> > It's bitrotted a bit, and I'll clean that up soon, but after looking
> > over cephadm, I wonder if it would make sense to also extend it to do
> > these actions on machines that are just intended to be kcephfs or krbd
> > clients.
> 
> If you could just adjust this PR to update doc/cephadm/client-setup.rst or 
> similar instead, that would be great.  We plan to delete the ceph-deploy 
> section of the docs entirely Real Soon Now.
> 

Done. Still waiting on the doc render though to make sure it looks ok.

> > We typically don't need to do a full-blown install on the clients, so
> > being able to install just the minimum packages needed and do a minimal
> > conf/keyring setup would be nice.
> > 
> > Does this make sense? I'll open a tracker if the principal cephadm devs
> > are OK with it.
> 
> With cephadm, you can do this with
> 
>  # curl ....
>  # sudo ./cephadm add-repo --release octopus
>  # sudo ./cephadm install ceph-common
> 
> without having to think about which distro you're using.
> 
> Eventually we might want to teach cephadm how to manage the host-side 
> packages on certain hosts so that it keeps ceph.conf and client package(s) 
> up to date, but that needs some design thinking first... until then, 
> having simple docs would be great!

I'm mostly interested in making it super easy to set up a new client
machine to do a mount or krbd setup. Keeping it all updated would be
bonus of course, but the initial setup is the real pain point I think.

For that, it would be really nice to be able to just run "cephadm
client-setup" and have it do everything needed. Should we be looking to
cephadm for that or is it sort of out of scope of that project since
it's really geared toward managing the server-side cluster?

-- 
Jeff Layton <jlayton@redhat.com>
