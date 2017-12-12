From: Sage Weil <sage@newdream.net>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Tue, 12 Dec 2017 20:47:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com> <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com> <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:57205 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbdLLUrZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Dec 2017 15:47:25 -0500
In-Reply-To: <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel <ceph-devel@vger.kernel.org>, mbroz@redhat.com

On Tue, 12 Dec 2017, Alfredo Deza wrote:
> On Tue, Dec 12, 2017 at 2:38 PM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
> > Its useful for legacy systems that installed with "plain" back when
> > that was the only option. Since there is no easy migration path for
> > re-keying an encrypted OSD to use a new encryption scheme, keeping
> > support for legacy "plain" is still very useful and desirable.
> 
> Yes, for sure we are going to support that legacy option. But for
> *newly* created OSDs, I was looking forward to follow
> the preferred way with LUKS only.

It's worth mentioning that the "new" way for new ceph-volume OSD 
deployments will also be using LVM, and (presumably?) allow layering 
dm-crypt on top of an LV--not just a PV or raw device.  So this is more a 
question of what, clean slate, we want to do to deploy dm-crypt when the 
end result that we're after is an LV to feed to bluestore or filestore.  
I'm not sure how/where LUKS fits in in the LVM world...

Copying Milan, as I expect he has an opinion here?  :)

sage


> 
> >
> > On Tue, Dec 12, 2017 at 2:27 PM, Alfredo Deza <adeza@redhat.com> wrote:
> >> We have started looking into encryption support in ceph-volume, and
> >> one of the unclear paths is if we really want to support both "plain"
> >> and "LUKS".
> >>
> >> According to the cryptsetup docs [0] :
> >>
> >>     (LUKS) is now the preferred way to set up disk encryption with
> >> dm-crypt using the cryptsetup utility
> >>
> >>
> >> ceph-disk supports both plain and LUKS, but moving forward, I was
> >> interested in understanding if anyone is really expecting the "plain"
> >> type to be a choice?
> >>
> >> The legacy support will mean that ceph-volume will have to deal with
> >> "plain", but moving forward it might be easier if we are supporting a
> >> single type of encryption with LUKS.
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
