From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 23:49:16 +0200
Message-ID: <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>
References: <1395736765.2823.29.camel@localhost>
	<CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
	<53316D18.7040103@ieee.org>
	<CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
	<53317BC2.9010700@ieee.org>
	<CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
	<1395753516.2823.37.camel@localhost>
	<533184AF.9050101@ieee.org>
	<5331853D.40408@ieee.org>
	<1395767705.9967.5.camel@localhost>
	<5331C05D.1060008@ieee.org>
	<1395773582.2076.10.camel@localhost>
	<5331D2E8.6060002@ieee.org>
	<CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>
	<1395778894.2076.12.camel@localhost>
	<1395780835.2076.15.camel@localhost>
	<1395781847.2076.21.camel@localhost>
	<CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>
	<1395782577.2076.23.camel@localhost>
	<CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>
	<1395783675.2076.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:58876 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbaCYVtR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 17:49:17 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so1581314qcr.11
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 14:49:16 -0700 (PDT)
In-Reply-To: <1395783675.2076.26.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 25, 2014 at 11:41 PM, Olivier Bonvalet <ceph.list@daevel.fr> wrote:
> mmm the cluster seems to be in a really bad state now : all hosts are
> hanging. Is it possible that mounting images without the rbd_assert(0)
> broke some images ?
>

I don't think so.  As far as I can tell all occurrences that you
reported tripped over one of the asserts.  It's probably just that for
some reason you are now hitting this bug much more frequently than once
a week.

Thanks,

                Ilya
