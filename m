From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: mds client reconnect
Date: Fri, 13 Oct 2017 14:10:21 +0800
Message-ID: <CAEYCsVL+_DanFXSCGLxY+WUq2gZoRi8N1D8maFeHsCr5ndOaCA@mail.gmail.com>
References: <CAEYCsVL1MxuYKf3vVN+UQchgaj=X7vxjZ0PfD2Oqsz2To2smRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:56821 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdJMGKW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Oct 2017 02:10:22 -0400
Received: by mail-io0-f178.google.com with SMTP id m81so7857876ioi.13
        for <ceph-devel@vger.kernel.org>; Thu, 12 Oct 2017 23:10:22 -0700 (PDT)
In-Reply-To: <CAEYCsVL1MxuYKf3vVN+UQchgaj=X7vxjZ0PfD2Oqsz2To2smRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

resend with plain txt

2017-10-13 10:56 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
> Hi,
>
>     We sometimes seen client (fs kernel) get evicted by MDS and try to
> reconnect,  even we set  mds_session_blacklist_on_evict = True, client still
> cannot reconnect due to below code:
>
>  if (!mds->is_reconnect() && mds->get_want_state() ==
> CEPH_MDS_STATE_RECONNECT) {
>     dout(10) << " we're almost in reconnect state (mdsmap delivery race?);
> waiting" << dendl;
>     mds->wait_for_reconnect(new C_MDS_RetryMessage(mds, m));
>     return;
>   }
>
>      Could someone share any insight on why MDS only accept reconnect in
> reconnect state? and how, if the client is get evicted , can automatically
> recovered? note that remount is usually impossible as umount will always
> hang(due to cannot talk to mds).
>
>
>
> Xiaoxi
