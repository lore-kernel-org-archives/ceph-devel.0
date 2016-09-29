From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: boost submodule update
Date: Thu, 29 Sep 2016 16:42:48 -0600
Message-ID: <CALqRxCzEXgA57EEty2j3vUrt9fm=eY8tTVYT4iy_p8Ad-rVfLw@mail.gmail.com>
References: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35885 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934725AbcI2Wmt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2016 18:42:49 -0400
Received: by mail-vk0-f44.google.com with SMTP id y190so57320850vkd.3
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2016 15:42:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 29, 2016 at 10:00 AM, Sage Weil <sweil@redhat.com> wrote:
>  * There is still the option to use a system boost via a cmake option.  I
> doubt anyone will opt for this in practice given the distros tend to lag,
> but they can if they want.

Can we have it automatically enable the system boost if it's > 1.6.1?
Otherwise I'm afraid no one will set WITH_SYSTEM_BOOST :)

Fedora 26 or 27 will probably have Boost 1.6.2+
(https://bugzilla.redhat.com/1374088)

- Ken
