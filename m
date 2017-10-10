From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [ceph-users] ceph-volume: migration and disk partition support
Date: Tue, 10 Oct 2017 10:14:32 +0200
Message-ID: <CABZ+qq=gcHrq_Tgyr2zxhMBRuqabg+Gf_nGpCMWpPUgTcSJELw@mail.gmail.com>
References: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:54201 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbdJJIPQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Oct 2017 04:15:16 -0400
Received: by mail-lf0-f52.google.com with SMTP id l23so23161586lfk.10
        for <ceph-devel@vger.kernel.org>; Tue, 10 Oct 2017 01:15:16 -0700 (PDT)
Received: from mail-lf0-f49.google.com (mail-lf0-f49.google.com. [209.85.215.49])
        by smtp.gmail.com with ESMTPSA id s73sm1689744lfs.96.2017.10.10.01.15.13
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 01:15:14 -0700 (PDT)
Received: by mail-lf0-f49.google.com with SMTP id n69so2207143lfn.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Oct 2017 01:15:13 -0700 (PDT)
In-Reply-To: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Fri, Oct 6, 2017 at 6:56 PM, Alfredo Deza <adeza@redhat.com> wrote:
> Hi,
>
> Now that ceph-volume is part of the Luminous release, we've been able
> to provide filestore support for LVM-based OSDs. We are making use of
> LVM's powerful mechanisms to store metadata which allows the process
> to no longer rely on UDEV and GPT labels (unlike ceph-disk).
>
> Bluestore support should be the next step for `ceph-volume lvm`, and
> while that is planned we are thinking of ways to improve the current
> caveats (like OSDs not coming up) for clusters that have deployed OSDs
> with ceph-disk.
>
> --- New clusters ---
> The `ceph-volume lvm` deployment is straightforward (currently
> supported in ceph-ansible), but there isn't support for plain disks
> (with partitions) currently, like there is with ceph-disk.
>
> Is there a pressing interest in supporting plain disks with
> partitions? Or only supporting LVM-based OSDs fine?
>
> --- Existing clusters ---
> Migration to ceph-volume, even with plain disk support means
> re-creating the OSD from scratch, which would end up moving data.
> There is no way to make a GPT/ceph-disk OSD become a ceph-volume one
> without starting from scratch.
>
> A temporary workaround would be to provide a way for existing OSDs to
> be brought up without UDEV and ceph-disk, by creating logic in
> ceph-volume that could load them with systemd directly. This wouldn't
> make them lvm-based, nor it would mean there is direct support for
> them, just a temporary workaround to make them start without UDEV and
> ceph-disk.
>
> I'm interested in what current users might look for here,: is it fine
> to provide this workaround if the issues are that problematic? Or is
> it OK to plan a migration towards ceph-volume OSDs?

Without fully understanding the technical details and plans, it will
be hard to answer this.

In general, I wouldn't plan to recreate all OSDs. In our case, we
don't currently plan to recreate FileStore OSDs as Bluestore after the
Luminous upgrade, as that would be too much work. *New* OSDs will be
created the *new* way (is that ceph-disk bluestore? ceph-volume lvm
bluestore??) It wouldn't be nice if we created new OSDs today with
ceph-disk bluestore, then have to recreate all those with ceph-volume
bluestore in a few months.

Disks/servers have a ~5 year lifetime, and we want to format OSDs
exactly once. I'd hope those OSDs remain bootable for the upcoming
releases.

(ceph-disk activation works reliably enough here -- just don't remove
the existing functionality and we'll be happy).

-- dan

>
> -Alfredo
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
