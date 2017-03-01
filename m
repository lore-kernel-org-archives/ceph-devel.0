From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Jewel 10.2.6 QE validation status
Date: Wed, 1 Mar 2017 17:46:09 +0100
Message-ID: <CAOi1vP8Z-4iRZPca30r-DBc+5QSnnZZxgRo8BhZJHoJZ-b-fBA@mail.gmail.com>
References: <CAMMFjmHgp5NSAxtdEVVPggjqUL7a8p9T7AEztb4Zzxdocjg7xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36610 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbdCAQqL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Mar 2017 11:46:11 -0500
Received: by mail-ua0-f175.google.com with SMTP id 72so45275027uaf.3
        for <ceph-devel@vger.kernel.org>; Wed, 01 Mar 2017 08:46:10 -0800 (PST)
In-Reply-To: <CAMMFjmHgp5NSAxtdEVVPggjqUL7a8p9T7AEztb4Zzxdocjg7xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "gmeno@redhat.com" <gmeno@redhat.com>

On Tue, Feb 28, 2017 at 11:09 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Detailed summary of the QE Validation can be found here
> http://tracker.ceph.com/issues/17851#note-92
>
> The following suites were in scope of this point release validation:
>
> rados (subset 35/50 228 jobs)
> rbd
> rgw
> fs
> krbd
> kcephfs
> knfs
> rest
> hadoop
> samba
> ceph-deploy
> ceph-disk
> upgrade/client-upgrade
> upgrade/hammer-x (jewel)
> upgrade/jewel-x/point-to-point-x
> powercycle
>
> (please let me know if any suites are missing from this ^ list)
>
> ==============================
> (overall pretty clean validation cycle, kudos to @Nathan and the
> backporting team !)
>
> Issue http://tracker.ceph.com/issues/18089 resulted in several
> failures, but is infrastructure related.
>
> Issues requiring approval/decision:
>
> rados - one job failed, http://tracker.ceph.com/issues/18089, need Josh approval
>
> krbd - http://tracker.ceph.com/issues/17221, need Ilya's approval/fix

Approved.

Thanks,

                Ilya
