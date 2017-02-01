From: John Spray <jspray@redhat.com>
Subject: Re: hammer 0.94.10 QE status
Date: Wed, 1 Feb 2017 19:12:57 +0000
Message-ID: <CALe9h7d6Zf6qiW1ud2Qa_BvYia77Lg4LEKvEEq3X6g=GCLhjzQ@mail.gmail.com>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33531 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdBATNT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 14:13:19 -0500
Received: by mail-wm0-f48.google.com with SMTP id t18so31757219wmt.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 11:13:18 -0800 (PST)
In-Reply-To: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

On Wed, Feb 1, 2017 at 4:52 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
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

The MDL_WriteError one is the bug from when ENOSPC stuff was
backported wrongly, the FileJournal/FileStore assertions are from
btrfs.

Good to go.

John



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
