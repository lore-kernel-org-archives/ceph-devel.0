From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: hammer 0.94.10 QE status
Date: Wed, 1 Feb 2017 18:03:46 +0100
Message-ID: <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34391 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbdBARDs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 12:03:48 -0500
Received: by mail-wj0-f194.google.com with SMTP id ip10so13758592wjb.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 09:03:48 -0800 (PST)
In-Reply-To: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

On Wed, Feb 1, 2017 at 5:52 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Here is snapshot of hammer 0.94.10 point release testing status.
>
> Suites were not tested on ubuntu 16.06 due to
> http://tracker.ceph.com/issues/18382 and as a result were forced to test on
> ubuntu 14.04 and centos 7.2 (note we don't have smithi with centos 7.3).
>
> There was an additional noise created by fact that since we tested last
> hammer release in August 2016 we moved from gitbuilders to shaman build
> system and it resulted in issues with some packages.
>
> Details of tests can be found here
> http://tracker.ceph.com/issues/17151#note-61
>
> ======================
> rados ubuntu - packaging issues, need approval - Josh
> rados centos - packaging issues, need approval - Josh
> ======================
> rbd - PASSED
> ======================
> rgw ubuntu - PASSED
> rgw centos - valgrind issues http://tracker.ceph.com/issues/18735, need
> approval Yehuda, Sage
> ======================
> fs ubuntu - looks similar to v0.94.8, need Greg, John approval
> fs centos - noise? need Greg, John review/approval
> ======================
> krbd ubuntu - looks like the same in v0.94.8
> http://tracker.ceph.com/issues/15895#note-33 need approval Jason, Ilya
> krbd centos -  looks like the same in v0.94.8
> http://tracker.ceph.com/issues/15895#note-33 need approval Jason, Ilya

I'll need to look at

http://pulpito.ceph.com/teuthology-2017-01-26_20:58:56-krbd-master-testing-basic-smithi/752997
http://pulpito.ceph.com/teuthology-2017-01-26_21:01:15-krbd-master-testing-basic-smithi/753036

These are unexpected.

Thanks,

                Ilya
