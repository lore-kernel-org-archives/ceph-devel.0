From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: hammer 0.94.10 QE status
Date: Wed, 1 Feb 2017 15:47:57 -0800
Message-ID: <CAKPXa=ZUkgYrYm1fsn31rtf118rDR8=n9z9TkQc6fFWuZhdz2Q@mail.gmail.com>
References: <CAMMFjmEwGeC5JT4WBe=+YFj=tC2NreQhQBhG7Au0vrvxzHZObQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:36560 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdBAXr6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 18:47:58 -0500
Received: by mail-ot0-f177.google.com with SMTP id 32so144403622oth.3
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 15:47:58 -0800 (PST)
In-Reply-To: <CAMMFjmEwGeC5JT4WBe=+YFj=tC2NreQhQBhG7Au0vrvxzHZObQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

Sorry resending as text

On Wed, Feb 1, 2017 at 8:55 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>
> Here is snapshot of hammer 0.94.10 point release testing status.
>
> Suites were not tested on ubuntu 16.06 due to
> http://tracker.ceph.com/issues/18382 and as a result were forced to
> test on ubuntu 14.04 and centos 7.2 (note we don't have smithi with
> centos 7.3).
>
> There was an additional noise created by fact that since we tested
> last hammer release in August 2016 we moved from gitbuilders to shaman
> build system and it resulted in issues with some packages.
>
> Details of tests can be found here http://tracker.ceph.com/issues/17151#note-61
>
> ======================
> rados ubuntu - packaging issues, need approval - Josh
> rados centos - packaging issues, need approval - Josh
> ======================
> rbd - PASSED
> ======================
> rgw ubuntu - PASSED
> rgw centos - valgrind issues http://tracker.ceph.com/issues/18735,
> need approval Yehuda, Sage
> ======================
> fs ubuntu - looks similar to v0.94.8, need Greg, John approval
> fs centos - noise? need Greg, John review/approval
> ======================
> krbd ubuntu - looks like the same in v0.94.8
> http://tracker.ceph.com/issues/15895#note-33 need approval Jason, Ilya
> krbd centos -  looks like the same in v0.94.8
> http://tracker.ceph.com/issues/15895#note-33 need approval Jason, Ilya
> ======================
> kcephfs - PASSED
> ======================
> knfs - PASSED
> ======================
> hadoop - PASSED
> ======================
> samba - packaging issues, need approval - Greg, Sage
> ======================
> rest  - PASSED
> ======================
> ceph-deploy - Vasu is fixing, need approval Sage

This one is difficult to test due to package split that happened after
hammer+,  It is problem only for *new* installs of hammer.
Old version of ceph-deploy(1.5.27) works but it uses gitbuilder
instead of shaman, so we can test that only with some hacks. you
will have to pass on this for now, once its released we could check
the install with --stable flag instead of --dev flag.

>
> ======================
> upgrade/client-upgrade - PASSED
> ======================
> upgrade/firefly-x (hammer) - need Sage approval. maybe deprecate?
> ======================
> upgrade/hammer - PASSED
> ======================
> upgrade/hammer-x (jewel) - FAILED, need Sage approval. maybe deprecate?
> ======================
> powercycle - PASSED
> ======================
>
> Thx
> YuriW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
