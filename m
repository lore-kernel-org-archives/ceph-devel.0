From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: devicemapper and udev events
Date: Tue, 1 Sep 2015 10:44:40 +0300
Message-ID: <CAOi1vP_ME6TyKtTS9PQbfJmwUu4LP4Vh7rAqbHTLY-QGcAv9UQ@mail.gmail.com>
References: <55E4D0A2.6040302@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:35433 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbbIAHom (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Sep 2015 03:44:42 -0400
Received: by lanb10 with SMTP id b10so51593238lan.2
        for <ceph-devel@vger.kernel.org>; Tue, 01 Sep 2015 00:44:40 -0700 (PDT)
In-Reply-To: <55E4D0A2.6040302@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 1, 2015 at 1:09 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ilya,
>
> While working on multipath, I noticed that udev add event are not triggered when /dev/dm-0 etc. are created. Should I expect a udev add event for every device ? Or does it not apply to devices created by / with devicemapper ?

I'd expect an event - are you sure it's not triggered?  Are you using
udevadm monitor or is it just some udev rule not getting executed?

Thanks,

                Ilya
