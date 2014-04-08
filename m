From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Switch to RBD format 2 by default after Firefly
Date: Tue, 8 Apr 2014 16:56:07 +0400
Message-ID: <CALFYKtD1U_-Ckq0VpvDJ3iaqnmBAjGS4VNmRL+SFPdF5+YdnGg@mail.gmail.com>
References: <5343EFF4.9010808@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:47575 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369AbaDHM4I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 08:56:08 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so814734qaq.10
        for <ceph-devel@vger.kernel.org>; Tue, 08 Apr 2014 05:56:08 -0700 (PDT)
In-Reply-To: <5343EFF4.9010808@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Apr 8, 2014 at 4:47 PM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> With Ubuntu 14.04 now shipping with the 3.13 kernel it fully supports Format
> 2 in both librbd and krbd.
>
> For RHEL 7 there will be a extra yum repo with a module which supports
> format 2, so isn't it that that after Firefly we change 'rbd_default_format'
> to 2?
>
> I still see a lot of images being created with format 1 and that will
> otherwise be hunting us for a long time.
>
> I'd vote for making format 2 the default or at least patch the 'rbd' tool to
> create format 2 images.

Fancy format 2 striping is not supported by krbd.  We've had a couple
people who confused format 2 support with the ability to set their own
stripe settings, so we'll need to be more vocal about it.

Thanks,

                Ilya
