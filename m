From: Sage Weil <sweil@redhat.com>
Subject: Re: hammer 0.94.10 QE status
Date: Wed, 1 Feb 2017 20:36:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702012006050.3654@piezo.novalocal>
References: <CAMMFjmEwGeC5JT4WBe=+YFj=tC2NreQhQBhG7Au0vrvxzHZObQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbdBAUgb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 15:36:31 -0500
In-Reply-To: <CAMMFjmEwGeC5JT4WBe=+YFj=tC2NreQhQBhG7Au0vrvxzHZObQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

On Wed, 1 Feb 2017, Yuri Weinstein wrote:
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

ok to skip

> ======================
> rest  - PASSED
> ======================
> ceph-deploy - Vasu is fixing, need approval Sage

what's the story here?

> ======================
> upgrade/client-upgrade - PASSED
> ======================
> upgrade/firefly-x (hammer) - need Sage approval. maybe deprecate?

somethign is wrong with teh teuthology test, it's looping dumping ops in 
flight.  i don't have time to look at it, anybody else want to take a 
look?

> ======================
> upgrade/hammer - PASSED
> ======================
> upgrade/hammer-x (jewel) - FAILED, need Sage approval. maybe deprecate?

Looks like this test suite is broken, fixing here:

	https://github.com/ceph/ceph/pull/13222

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
> 
> 
