From: Jeff Layton <jlayton@redhat.com>
Subject: extend cephadm to do minimal client setup for kcephfs (and maybe
 krbd)?
Date: Fri, 20 Mar 2020 10:57:38 -0400
Message-ID: <833eb05d54ca8338843566a1fce9afee9283bdb2.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34850 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbgCTO5p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:57:45 -0400
Received: by mail-qt1-f197.google.com with SMTP id t6so5945359qtj.12
        for <ceph-devel@vger.kernel.org>; Fri, 20 Mar 2020 07:57:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "dev@ceph.io" <dev@ceph.io>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@newdream.net>

I've had this PR sitting around for a while:

    https://github.com/ceph/ceph/pull/31885

It's bitrotted a bit, and I'll clean that up soon, but after looking
over cephadm, I wonder if it would make sense to also extend it to do
these actions on machines that are just intended to be kcephfs or krbd
clients.

We typically don't need to do a full-blown install on the clients, so
being able to install just the minimum packages needed and do a minimal
conf/keyring setup would be nice.

Does this make sense? I'll open a tracker if the principal cephadm devs
are OK with it.

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
