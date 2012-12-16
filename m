From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw: partially uploaded files never reclaim space
Date: Sat, 15 Dec 2012 20:37:46 -0800
Message-ID: <CAC-hyiHRYwyGi6wRk60p7g6kv7a2O3-LTuHDKnmpYGVRS68p4g@mail.gmail.com>
References: <CAPHxCcQ8mF6Zv1v4g9Xx0T_e6aOoWf6JJ+VrbHhhbJhOs1z4bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:62577 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab2LPEhr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 23:37:47 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so4458645iay.19
        for <ceph-devel@vger.kernel.org>; Sat, 15 Dec 2012 20:37:46 -0800 (PST)
In-Reply-To: <CAPHxCcQ8mF6Zv1v4g9Xx0T_e6aOoWf6JJ+VrbHhhbJhOs1z4bQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lorieri <lorieri@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Dec 15, 2012 at 7:05 PM, Lorieri <lorieri@gmail.com> wrote:
> Hi,
>
>
> I was doing some tests with radosgw and one of the tests were
> interrupt a file transfer on its middle.
> The result was to get some disc space that is never reclaimed.
> I run the temp delete command, then waited 24 hours, then upgraded to
> 0.55, then removed the radosgw bucket (not the rados bucket), and the
> partial files are still there.

That's a bug. Looking at the code I'm missing some cleanup that is
supposed to be there. I opened issue #3628

>
> Is there anything else I can do ?
>

Remove the rados objects manually (using the 'rados' command).. Their
names have the original object name plus a prefix and some random
suffix.


Thanks,
Yehuda
