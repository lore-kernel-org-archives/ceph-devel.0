From: Sage Weil <sage@newdream.net>
Subject: Re: kraken v11.2.1 QE status
Date: Tue, 8 Aug 2017 01:27:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708080127340.20435@piezo.novalocal>
References: <CAMMFjmHRoBZP5YbrJEXUDd5F7JUbB5_r2CubuD_j6pL8J0SP3g@mail.gmail.com> <CAOi1vP83Wfwhxax2S0Hd2Rxht-L5=jtOLL5r14j4WiF=rH0Dvg@mail.gmail.com> <CAMMFjmFhh+U+EH+Qr18DABnNb3dYWD=jB7-wX7zF+Cbdy+DMhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51806 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdHHB1u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Aug 2017 21:27:50 -0400
In-Reply-To: <CAMMFjmFhh+U+EH+Qr18DABnNb3dYWD=jB7-wX7zF+Cbdy+DMhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Deza, Alfredo" <adeza@redhat.com>

Blessed!  :)

Thanks, everyone!
sage


On Mon, 7 Aug 2017, Yuri Weinstein wrote:

> Sage, pending you final blessing.
> 
> Otherwise ready for publishing,  Alfredo!
> 
> Thx
> YuriW
> 
> On Mon, Aug 7, 2017 at 1:12 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> > On Sat, Aug 5, 2017 at 6:04 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> >> Detailed summary of the QE Validation can be found here
> >> http://tracker.ceph.com/issues/19009#note-91
> >>
> >> The following suites were in scope of this point release validation:
> >>
> >> rados (subset 35/50 245 jobs)
> >> rbd  (subset 35/50 100 jobs)
> >> rgw
> >> fs
> >> krbd
> >> kcephfs
> >> knfs
> >> rest
> >> hadoop - EXCLUDED
> >> samba - EXCLUDED
> >> ceph-deploy
> >> ceph-disk
> >> upgrade/client-upgrade
> >> upgrade/jewel-x (kraken)
> >> upgrade/hammer-jewel-x - EXCLUDED
> >> powercycle
> >> ceph-ansible
> >>
> >> (please let me know if any suites are missing from this ^ list)
> >>
> >> Outstanding issues:
> >>
> >> krbd - Ilya, pls review and approve/comment for release as appropriate
> >
> > Approved.
> >
> > Thanks,
> >
> >                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
