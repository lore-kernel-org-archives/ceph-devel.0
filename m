From: Xinying Song <songxinying.ftd@gmail.com>
Subject: Re: mds: where is mdr->slave_commit called?
Date: Sat, 28 Mar 2020 09:46:30 +0800
Message-ID: <CAMWWNq-4eMR_AJHaNLEABRyYLZUzKajPKttvXoPpQ2mCB+b9rA@mail.gmail.com>
References: <CAMWWNq-8H8JJsPdL1JC9pOKMQY9LawZDRxfKa7Ag8MWGJbBY5A@mail.gmail.com>
 <CAAM7YAnSxY8QkZWPLT=mDjjf4PVNd=vsi3zb3DEKKhEdivFXVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35320 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgC1Bqo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2020 21:46:44 -0400
Received: by mail-oi1-f174.google.com with SMTP id t25so10581117oij.2
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2020 18:46:42 -0700 (PDT)
In-Reply-To: <CAAM7YAnSxY8QkZWPLT=mDjjf4PVNd=vsi3zb3DEKKhEdivFXVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for your reply, Yan!
Could you give more explanation about the mechanism for how an
ESlaveUpdate::OP_PREPARE log event is prevented from being trimmed
before slave mds receiving  MMDSSlaveRequest::OP_FINISH message from
master? It seems only when doing replay can an ESlaveUpdate log event
be added to LogSegment::slave_updates, which helps to prevent the log
event from being trimmed. Suppose a scenario that slave mds has
journaled log event, sent an OP_LINKPRPEACK to master, then trimmed
the log event, and crashed. The master also crashed before receiving
the ACK message. So there will no log events to be replayed for both
master and slave, but slave mds has modified the inode link count, and
no way to rollback.

I have been stuck in this question for a few days, can't figure it
out. Sincerely hoping you or anyone else can give some tips.

Thanks!

Yan, Zheng <ukernel@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8812:34=E5=86=99=E9=81=93=EF=BC=9A

>
> On Sun, Mar 22, 2020 at 3:40 PM Xinying Song <songxinying.ftd@gmail.com> =
wrote:
> >
> > Hi, everyone:
> > Could anybody give some tips about how `mdr->slave_commit` is called?
> >
> > As for `link_remote()`, steps are as follows:
> > 1. master mds sends OP_(UN)LINKPREP to salve mds.
> > 2. slave mds replys OP_LINKPREPACK to master mds after its journal has
> > been flushed.
> > 3. master mds continues to process the client request.
> >
> > I only find out there is a chance in MDCache::request_finish() that
> > `mdr->slave_commit` will be called. However, after a successful
> > journal flush, slave mds only sends an ACK to master mds and bypasses
> > MDCache::request_finish().
> > So when or where is `mdr->slave_commit` called?
> >
> > Thanks!
>
> master calls MDCache::request_finsih(),
> MDCache::request_drop_foreign_locks() sends
> MMDSSlaveRequest::OP_FINISH message to slaves.  slaves call
> MDCache::request_finsih() when receiving the message.
