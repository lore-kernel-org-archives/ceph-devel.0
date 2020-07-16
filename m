From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: multiple BLK-MQ queues for Ceph's RADOS Block Device (RBD) and CephFS
Date: Thu, 16 Jul 2020 16:11:45 -0400
Message-ID: <CA+aFP1Am-dQCrd-itiZo5CKEJK44PQzgZR2YuEKkLqU5v_XW=w@mail.gmail.com>
References: <CA+xD70OJhkhH=+5W7M8NM54VPh42FmbD3O0yqKe1p-+=yd9zXQ@mail.gmail.com>
 <CAOi1vP-hmzEkkUWGOwxksQn8ny1HzgNURtnf1D33KQq4-49xgQ@mail.gmail.com>
 <CA+xD70Neac2hpzu-Tg7s+1NCDegwzKs-zdTk8DYTWZPjNaexaA@mail.gmail.com>
 <CAOi1vP9yz7hLuSRWnDtj3wdKZD1qTiF+84_o5F91bw3wZam=0g@mail.gmail.com> <CA+xD70MyfKgn5m3=JvgFfg+Ww=T8eJ2b9bogdbS4ogYAifNCTw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30566 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728907AbgGPUMD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:12:03 -0400
Received: by mail-wm1-f72.google.com with SMTP id z74so5347471wmc.4
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2020 13:11:59 -0700 (PDT)
In-Reply-To: <CA+xD70MyfKgn5m3=JvgFfg+Ww=T8eJ2b9bogdbS4ogYAifNCTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bobby <italienisch1987@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, dev <dev@ceph.io>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 16, 2020 at 3:19 PM Bobby <italienisch1987@gmail.com> wrote:
>
> Hi,
>
> I completely agree to what you said regarding Ceph client. This is exactl=
y my understanding of a Ceph client.
>
> And regarding blk-mq, I meant for a block device. A multi-queue implement=
ation of a block device.

krbd is a blk-mq implementation of a block device. So is the nbd block
device driver -- which can be combined w/ rbd-nbd (or any other NBD
server) to utilize librbd in user-space.

> On Wednesday, July 15, 2020, Ilya Dryomov <idryomov@gmail.com> wrote:
> > On Wed, Jul 15, 2020 at 12:47 AM Bobby <italienisch1987@gmail.com> wrot=
e:
> >>
> >>
> >>
> >> Hi Ilya,
> >>
> >> Thanks for the reply. It's basically both i.e. I have a specific proje=
ct currently and also I am looking to make ceph-fuse faster.
> >>
> >> But for now, let me ask specifically the project based question. In th=
e project I have to write a blk-mq kernel driver for the Ceph client machin=
e. The Ceph client machine will transfer the data to HBA or lets say any em=
bedded device.
> >
> > What is a "Ceph client machine"?
> >
> > A Ceph client (or more specifically a RADOS client) speaks RADOS
> > protocol and transfers data to OSD daemons.  It can't transfer data
> > directly to a physical device because something has to take care of
> > replication, ensure consistency and self healing, etc.  This is the
> > job of the OSD.
> >
> >>
> >> My hope is that there can be an alternative and that alternative is to=
 not implement a blk-mq kernel driver and instead do the stuff in userspace=
. I am trying to avoid writing a blk-mq kernel driver and yet achieve the m=
ulti-queue implementation through userspace. Is it possible?
> >>
> >> Also AFAIK, the Ceph=E2=80=99s block storage implementation uses a cli=
ent module and this client module has two implementations librbd (user-spac=
e) and krbd (kernel module). I have not gone deep into these client modules=
. but can librbd help me with this?
> >
> > I guess I don't understand the goal of your project.  A multi-queue
> > implementation of what exactly?  A Ceph block device, a Ceph filesystem
> > or something else entirely?  It would help if you were more specific
> > because "a multi-queue driver for Ceph" is really vague.
> >
> > Thanks,
> >
> >                 Ilya
> > _______________________________________________
> Dev mailing list -- dev@ceph.io
> To unsubscribe send an email to dev-leave@ceph.io



--=20
Jason
