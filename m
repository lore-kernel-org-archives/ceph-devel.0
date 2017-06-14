From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Wed, 14 Jun 2017 17:20:28 -0400
Message-ID: <CA+aFP1B0ngk-Wkfy0KXnkyRP2XZJqvce1qhdBfpL+5PcjmGNoQ@mail.gmail.com>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com>
 <CADRKj5RCQf8wv+Y3VsL=e_gB9URYzK0SkzGRVfTFQwcJn-OL4g@mail.gmail.com> <alpine.DEB.2.11.1706141943490.32269@piezo.novalocal>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35456 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbdFNVU3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 17:20:29 -0400
Received: by mail-yw0-f174.google.com with SMTP id v7so8389957ywc.2
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 14:20:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706141943490.32269@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 14, 2017 at 3:50 PM, Sage Weil <sweil@redhat.com> wrote:
> Is there anything that is updated at runtime (not startup) that
> doesn't fit into a perfcounter?  It not, then a single call to something
> like rados_register_daemon(name, metadata_map) (and some mechanism
> for cleaning out dead people) ought to suffice?

My 2 cents: for rbd-mirror, I was thinking of injecting dynamic health
state like "X images in error state" so that things like dashboard
could have that data available for display without having to poll the
data from the backing status objects in the OSDs. Low-level details
about which images have issues would still require a pull.

-- 
Jason
