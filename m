From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Jewel 10.2.6 QE validation status
Date: Tue, 28 Feb 2017 14:41:58 -0800
Message-ID: <CAMMFjmHXZLB7Y3JPOA9tQEpv7N-uUDMXdPkSKu4ihkCz+yhAFw@mail.gmail.com>
References: <CAMMFjmHgp5NSAxtdEVVPggjqUL7a8p9T7AEztb4Zzxdocjg7xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:32786 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdB1Wu3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2017 17:50:29 -0500
Received: by mail-wm0-f51.google.com with SMTP id i17so5374668wmf.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2017 14:50:23 -0800 (PST)
In-Reply-To: <CAMMFjmHgp5NSAxtdEVVPggjqUL7a8p9T7AEztb4Zzxdocjg7xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "gmeno@redhat.com" <gmeno@redhat.com>

Added ceph-ansible to the list of suites.

On Tue, Feb 28, 2017 at 2:09 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
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
>
> samba- http://tracker.ceph.com/issues/19101, need John's approval/fix
>
> upgrade/client-upgrade - http://tracker.ceph.com/issues/19080, need
> Jason, Nathan approval/and or backport
>
> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/18089, can
> be approved for release, Sage?
>
> Thx
> YuriW
