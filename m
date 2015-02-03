From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Confused about SnapMapper::get_prefix
Date: Tue, 3 Feb 2015 09:15:29 -0800
Message-ID: <CAC6JEv8zKQZ8JVQrfo3bu=AW-xuHfOAC_NN260ywzboFVLuryA@mail.gmail.com>
References: <CANf+_kL0_tYtF+vDvLSTPP5LtP_4P6r9_M5qu7VeyP2GYfFw9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:56280 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966228AbbBCRPb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 12:15:31 -0500
Received: by mail-ie0-f170.google.com with SMTP id y20so26848632ier.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 09:15:30 -0800 (PST)
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com. [209.85.223.175])
        by mx.google.com with ESMTPSA id w140sm8105211iod.13.2015.02.03.09.15.29
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Feb 2015 09:15:29 -0800 (PST)
Received: by mail-ie0-f175.google.com with SMTP id ar1so26762236iec.6
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 09:15:29 -0800 (PST)
In-Reply-To: <CANf+_kL0_tYtF+vDvLSTPP5LtP_4P6r9_M5qu7VeyP2GYfFw9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ding Dinghua <dingdinghua85@gmail.com>, sjust@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 3, 2015 at 4:12 AM, Ding Dinghua <dingdinghua85@gmail.com> wrote:
> Hi all:
>       I don't understand why SnapMapper::get_prefix   static_cast snap
> to unsigned:
>
> string SnapMapper::get_prefix(snapid_t snap)
> {
>   char buf[100];
>   int len = snprintf(
>     buf, sizeof(buf),
>     "%.*X_", (int)(sizeof(snap)*2),
>     static_cast<unsigned>(snap));
>   return MAPPING_PREFIX + string(buf, len);
> }
>
> Will this limit snapshot count in pool to 2^32 -1 ?
>
> Could anyone clarify ? Thanks

I think the code base is a little confused about whether snaps should
be 32 or 64 bits in various places. :( That said, the size of unsigned
can vary across architectures, so this should probably be sized more
explicitly as whatever it's supposed to be on the disk...
