From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Question on ceph deployment
Date: Mon, 30 Aug 2010 22:45:53 -0700
Message-ID: <AANLkTimTbH1wDdO+-txt3xFwHnddBxyrO6+vy90cuE4F@mail.gmail.com>
References: <AANLkTi=AP6E7GEZdAkjbnL4=ghiXZFgJWUyzgrVGAHaJ@mail.gmail.com>
	<AANLkTinDKCs4LQDYe-yF61N8+2JTdctHh8Pwj0kde4js@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62758 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab0HaFpz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Aug 2010 01:45:55 -0400
Received: by wwb28 with SMTP id 28so674501wwb.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 Aug 2010 22:45:54 -0700 (PDT)
In-Reply-To: <AANLkTinDKCs4LQDYe-yF61N8+2JTdctHh8Pwj0kde4js@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Min Zhou <coderplay@gmail.com>
Cc: ceph-devel@vger.kernel.org

The ceph utility is used for controlling the cluster after it runs. In
order to start the cluster up, you should either use the
/etc/init.d/ceph script, or the init-ceph script (or the
ceph/src/vstart.sh), all depends on your distribution and how you
actually installed it. There are some examples in the wiki (look under
'Starting and Stopping').

Yehuda

On Mon, Aug 30, 2010 at 8:01 PM, Min Zhou <coderplay@gmail.com> wrote:
>
> Below is the detailed information after promoted the debug level.
>
> # ceph -c /home/ceph/ceph_conf/ceph.conf start
> 10.07.30_10:53:39.747643 2b7b527bca20 -- :/0 register_entity client?
> 10.07.30_10:53:39.747779 2b7b527bca20 -- :/0 register_entity client? =
at :/0
> 10.07.30_10:53:39.747793 2b7b527bca20 -- :/0 ready :/0
> 10.07.30_10:53:39.747871 2b7b527bca20 -- :/2233 messenger.start
> 10.07.30_10:53:39.748003 2b7b527bca20 -- :/2233 --> mon1
> 192.168.0.3:6789/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0x11408b0
> 10.07.30_10:53:39.756916 2b7b527bca20 -- :/2233 submit_message
> auth(proto 0 30 bytes) v1 remote, 192.168.0.3:6789/0, new pipe.
> 10.07.30_10:53:39.756989 2b7b527bca20 -- :/2233 connect_rank to
> 192.168.0.3:6789/0, creating pipe and registering
> 10.07.30_10:53:39.757128 2b7b527bca20 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).register_pipe
> 10.07.30_10:53:39.757260 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).writer: state =3D 1 poli=
cy.server=3D0
> 10.07.30_10:53:39.757306 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).connect 0
> 10.07.30_10:53:39.757369 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).connecting to 192.168.0.3=
:6789/0
> 10.07.30_10:53:39.757551 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).connect error 192.168.0.3=
:6789/0,
> 111: Connection refused
> 10.07.30_10:53:39.757617 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).fault 111: Connection ref=
used
> 10.07.30_10:53:39.757697 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 10.07.30_10:53:39.757740 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).writer: state =3D 1 poli=
cy.server=3D0
> 10.07.30_10:53:39.757777 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).connect 0
> 10.07.30_10:53:39.757831 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).connecting to 192.168.0.3=
:6789/0
> 10.07.30_10:53:39.757977 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).connect error 192.168.0.3=
:6789/0,
> 111: Connection refused
> 10.07.30_10:53:39.758039 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).fault 111: Connection ref=
used
> 10.07.30_10:53:39.758097 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault waiting 0.200000
> 10.07.30_10:53:39.959700 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault done waiting or wo=
ke up
> 10.07.30_10:53:39.959753 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).writer: state =3D 1 poli=
cy.server=3D0
> 10.07.30_10:53:39.959810 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).connect 0
> 10.07.30_10:53:39.959856 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).connecting to 192.168.0.3=
:6789/0
> 10.07.30_10:53:39.959998 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).connect error 192.168.0.3=
:6789/0,
> 111: Connection refused
> 10.07.30_10:53:39.960054 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).fault 111: Connection ref=
used
> 10.07.30_10:53:39.960112 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault waiting 0.400000
> 10.07.30_10:53:40.361707 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault done waiting or wo=
ke up
> 10.07.30_10:53:40.361727 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).writer: state =3D 1 poli=
cy.server=3D0
> 10.07.30_10:53:40.361742 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).connect 0
> 10.07.30_10:53:40.361763 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).connecting to 192.168.0.3=
:6789/0
> 10.07.30_10:53:40.361880 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).connect error 192.168.0.3=
:6789/0,
> 111: Connection refused
> 10.07.30_10:53:40.361902 42493940 -- :/2233 >> 192.168.0.3:6789/0
> pipe(0x11422e0 sd=3D5 pgs=3D0 cs=3D0 l=3D0).fault
>
>
>
>
> On Tue, Aug 31, 2010 at 10:34 AM, Min Zhou <coderplay@gmail.com> wrot=
e:
> > Hi all,
> > After creating a new file system followed by the wiki, I entered a
> > command to start ceph, but came across a failure
> >
> > # ceph -c /home/ceph/ceph_conf/ceph.conf start
> > 10.07.30_10:27:52.183028 42640940 -- :/31251 >> 192.168.0.3:6789/0
> > pipe(0x1c015ff0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > 10.07.30_10:27:55.184319 42741940 -- :/31251 >> 192.168.0.2:6789/0
> > pipe(0x1c014c90 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > 10.07.30_10:27:58.186492 42842940 -- :/31251 >> 192.168.0.3:6789/0
> > pipe(0x1c015b40 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > 10.07.30_10:28:01.188484 42943940 -- :/31251 >> 192.168.0.2:6789/0
> > pipe(0x1c015860 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > 10.07.30_10:28:04.190674 42a44940 -- :/31251 >> 192.168.0.3:6789/0
> > pipe(0x1c011060 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > 10.07.30_10:28:07.192592 42b45940 -- :/31251 >> 192.168.0.2:6789/0
> > pipe(0x1c01a200 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > 10.07.30_10:28:10.194772 42c46940 -- :/31251 >> 192.168.0.3:6789/0
> > pipe(0x1c01a660 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > 10.07.30_10:28:13.196713 42d47940 -- :/31251 >> 192.168.0.2:6789/0
> > pipe(0x1c01c010 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > 10.07.30_10:28:16.198918 42e48940 -- :/31251 >> 192.168.0.3:6789/0
> > pipe(0x1c01c8d0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> >
> > Can anyone help me with this?
> >
> > Thanks,
> > Min
> > --
> > My research interests are distributed systems, parallel computing a=
nd
> > bytecode based virtual machine.
> >
> > My profile:
> > http://www.linkedin.com/in/coderplay
> > My blog:
> > http://coderplay.javaeye.com
> >
>
>
>
> --
> My research interests are distributed systems, parallel computing and
> bytecode based virtual machine.
>
> My profile:
> http://www.linkedin.com/in/coderplay
> My blog:
> http://coderplay.javaeye.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
