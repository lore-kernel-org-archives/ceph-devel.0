From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [Ceph-maintainers] can we stop packaging sysvinit scripts?
Date: Wed, 10 Jan 2018 08:05:24 -0700
Message-ID: <CALqRxCz=nU8dL2euhwQ25Try3G0z6ECf9d0WFrTDdNy=DpTtRQ@mail.gmail.com>
References: <alpine.DEB.2.11.1801101440550.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:38581 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeAJPF0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jan 2018 10:05:26 -0500
Received: by mail-vk0-f49.google.com with SMTP id l63so11707367vke.5
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jan 2018 07:05:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801101440550.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com

I'm good with dropping them.

On Wed, Jan 10, 2018 at 7:44 AM, Sage Weil <sweil@redhat.com> wrote:
> We've had systemd unit files for several releases now and all major
> distros are using systemd by default.  Can we stop packaging the sysvinit
> scripts?
>
> I realize that Debian allows you to switch init systems... do any users
> actually do this?  Is it required that debs include the sysvinit scripts
> or is there some glue that lets packages avoid maintaining sysvinit
> scripts?
>
> I ask because the init scripts are one of the few remainining bits that
> use the ceph-conf utility, which I would like to deprecate (and eventually
> remove).  It parses local config files but we are migrating this to the
> mon.  We could make ceph-conf pull configs from the mon but I would
> like to simplify if possible!
>
> Thanks-
> sage
>
> _______________________________________________
> Ceph-maintainers mailing list
> Ceph-maintainers@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-maintainers-ceph.com
