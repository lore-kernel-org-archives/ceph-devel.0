From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: mds client reconnect
Date: Fri, 13 Oct 2017 21:59:33 +0800
Message-ID: <CAAM7YAnxQcaBHU=KgZhU9UM-=zksW-h206q2fuzHoM_kBcYsMw@mail.gmail.com>
References: <CAEYCsVL1MxuYKf3vVN+UQchgaj=X7vxjZ0PfD2Oqsz2To2smRg@mail.gmail.com>
 <CAEYCsVL+_DanFXSCGLxY+WUq2gZoRi8N1D8maFeHsCr5ndOaCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:52364 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbdJMN7e (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Oct 2017 09:59:34 -0400
Received: by mail-oi0-f48.google.com with SMTP id c202so14274395oih.9
        for <ceph-devel@vger.kernel.org>; Fri, 13 Oct 2017 06:59:34 -0700 (PDT)
In-Reply-To: <CAEYCsVL+_DanFXSCGLxY+WUq2gZoRi8N1D8maFeHsCr5ndOaCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Oct 13, 2017 at 2:10 PM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
>
> resend with plain txt
>
> 2017-10-13 10:56 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
> > Hi,
> >
> >     We sometimes seen client (fs kernel) get evicted by MDS and try to
> > reconnect,  even we set  mds_session_blacklist_on_evict = True, client still
> > cannot reconnect due to below code:
> >
> >  if (!mds->is_reconnect() && mds->get_want_state() ==
> > CEPH_MDS_STATE_RECONNECT) {
> >     dout(10) << " we're almost in reconnect state (mdsmap delivery race?);
> > waiting" << dendl;
> >     mds->wait_for_reconnect(new C_MDS_RetryMessage(mds, m));
> >     return;
> >   }
> >
> >      Could someone share any insight on why MDS only accept reconnect in
> > reconnect state? and how, if the client is get evicted , can automatically
> > recovered? note that remount is usually impossible as umount will always
> > hang(due to cannot talk to mds).
> >

If reconnect get denied, unflushed dirty metadata on client get lost.

If mds_session_blacklist_on_evict is set to FALSE, recent version kernel client
should re-open session automatically after reconnect get denied. For
fuse client,
client_reconnect_stale need to be set to true.

FYI: 'umount -f' works for evicted client.



>
> >
> >
> > Xiaoxi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
