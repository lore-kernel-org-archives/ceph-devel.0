From: Andreas Calminder <andreas.calminder@klarna.com>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 07:56:58 +0100
Message-ID: <CAA1GxO3OwfhXtMx+82k=NO4BXukEyOE9d+Mz-fD4Sr+2psfy1A@mail.gmail.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:41037 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdK1G5U (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 01:57:20 -0500
Received: by mail-lf0-f43.google.com with SMTP id f134so35656965lfg.8
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 22:57:19 -0800 (PST)
In-Reply-To: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hello,
Thanks for the heads-up. As someone who's currently maintaining a
Jewel cluster and are in the process of setting up a shiny new
Luminous cluster and writing Ansible roles in the process to make
setup reproducible. I immediately proceeded to look into ceph-volume
and I've some questions/concerns, mainly due to my own setup, which is
one osd per device, simple.

Running ceph-volume in Luminous 12.2.1 suggests there's only the lvm
subcommand available and the man-page only covers lvm. The online
documentation http://docs.ceph.com/docs/master/ceph-volume/ lists
simple however it's lacking some of the ceph-disk commands, like
'prepare' which seems crucial in the 'simple' scenario. Does the
ceph-disk deprecation imply that lvm is mandatory for using devices
with ceph or is just the documentation and tool features lagging
behind, I.E the 'simple' parts will be added well in time for Mimic
and during the Luminous lifecycle? Or am I missing something?

Best regards,
Andreas

On 27 November 2017 at 14:36, Alfredo Deza <adeza@redhat.com> wrote:
> For the upcoming Luminous release (12.2.2), ceph-disk will be
> officially in 'deprecated' mode (bug fixes only). A large banner with
> deprecation information has been added, which will try to raise
> awareness.
>
> We are strongly suggesting using ceph-volume for new (and old) OSD
> deployments. The only current exceptions to this are encrypted OSDs
> and FreeBSD systems
>
> Encryption support is planned and will be coming soon to ceph-volume.
>
> A few items to consider:
>
> * ceph-disk is expected to be fully removed by the Mimic release
> * Existing OSDs are supported by ceph-volume. They can be "taken over" [0]
> * ceph-ansible already fully supports ceph-volume and will soon default to it
> * ceph-deploy support is planned and should be fully implemented soon
>
>
> [0] http://docs.ceph.com/docs/master/ceph-volume/simple/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
