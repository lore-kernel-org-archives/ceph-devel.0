From: Sage Weil <sweil@redhat.com>
Subject: Re: Jewel 10.2.6 QE validation status
Date: Wed, 1 Mar 2017 00:39:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703010039050.25760@piezo.novalocal>
References: <CAMMFjmHgp5NSAxtdEVVPggjqUL7a8p9T7AEztb4Zzxdocjg7xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbdCAArW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Feb 2017 19:47:22 -0500
In-Reply-To: <CAMMFjmHgp5NSAxtdEVVPggjqUL7a8p9T7AEztb4Zzxdocjg7xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "gmeno@redhat.com" <gmeno@redhat.com>

On Tue, 28 Feb 2017, Yuri Weinstein wrote:
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

If you mean it's just hte xenial nodes failing on the package install, 
yeah, ignore those failures!

sage
