From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: [ceph-users] Help needed porting Ceph to RSockets
Date: Tue, 13 Aug 2013 16:06:12 +0200
Message-ID: <20130813160612.037ea9f2@andylap>
References: <CAJA05UmTDGze7S50_j8RgHmPFYonk2Z94Fi6CQtxND9QxgRr3g@mail.gmail.com>
	<CAJA05Umgio7XftGZtQdRzyWq70pXBb3oEx2jrT3BxcBr6MLoVQ@mail.gmail.com>
	<20130812075513.43c338e1@andylap>
	<CAJA05U=i22jHy2xbvCUk+UVN0+hOFDgt-JMSHTWKmr1+DZu0Dg@mail.gmail.com>
	<20130812180644.447ca089@andylap>
	<CAJA05U=KqzYis14sYXusbpk-T-F=uqvNz1XPurutmdeRz6BAdg@mail.gmail.com>
	<20130813075312.7cac0d46@andylap>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from port-212-202-108-184.static.qsc.de ([212.202.108.184]:48147
	"EHLO mail.itxperts.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751466Ab3HMOGR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 10:06:17 -0400
In-Reply-To: <20130813075312.7cac0d46@andylap>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Matthew Anderson <manderson8787@gmail.com>, ceph-devel@vger.kernel.org

Hi Matthew,

I found a workaround for my (our) problem: in the librdmacm
code, rsocket.c, there is a global constant polling_time, which
is set to 10 microseconds at the moment.

I raise this to 10000 - and all of a sudden things work nicely.

I think we are looking at two issues here:
1. the thread structure of ceph messenger
   For a given socket connection, there are 3 threads of interest
   here: the main messenger thread, the Pipe::reader and the
   Pipe::writer.

   For a ceph client like the ceph admin command, I see the following
   sequence
     - the connection to the ceph monitor is created by the
       main messenger  thread, the Pipe::reader and
       Pipe::writer are instantiated.
     - the requested command is sent to the ceph monitor, the
       answer is read and printed
     - at this point the Pipe::reader already has called
       tcp_read_wait(), polling for more data or connection termination
     - after the response had been printed, the main loop calls the
       shutdown routines which in in turn shutdown() the socket

    There is some time between the last two steps - and this gap is
    long enough to open a race:

2. rpoll, ibv and poll
   the rpoll implementation in rsockets is split in 2 phases:
   - a busy loop which checks the state of the underlying ibv queue pai=
r
   - the call to real poll() system call (i.e. the uverbs(?)
     implementation of poll() inside the kernel)

   The busy loop has a maximum duration of polling_time (10 microsecond=
s
   by default) - and is able detect the local shutdown and returns a
   POLLHUP.

   The poll() system call (i.e. the uverbs implementation of poll()=20
   in the kernel) does not detect the local shutdown - and only returns
   after the caller supplied timeout expires.

Increasing the rsockets polloing_time from 10 to 10000 microseconds
results in the rpoll to detect the local shutdown within the busy loop.

Decreasing the ceph "ms tcp read timeout" from the default of 900 to 5
seconds serves a similar purpose, but is much coarser.

=46rom my understanding, the real issue is neither at the ceph nor at t=
he
rsockets level: it is related to the uverbs kernel module.

An alternative way to address the current problem at the rsockets level
would be w re-write of the rpoll(): instead of the busy loop at the
beginning followed by the reall poll() call with the full user
specificed timeout value ("ms tcp read timeout" in our case), I would
embed the real poll()  into a loop, splitting the user specified timeou=
t
into smaller portions and doing the rsockets specific rs_poll_check()
on every timeout of the real poll().


Best Regards

Andreas Bluemle
    =20

On Tue, 13 Aug 2013 07:53:12 +0200
Andreas Bluemle <andreas.bluemle@itxperts.de> wrote:

> Hi Matthew,
>=20
> I can confirm the beahviour whichi you describe.
> I too believe that the problem is on the client side (ceph command).
> My log files show the very same symptom, i.e. the client side
> not being able to shutdown the pipes properly.
>=20
> (Q: I had problems yesterday to send a mail to ceph-users list
> with the log files attached to it because of the size of=20
> the attachments exceeding some limit; I hadn=C3=84t been subscribed
> to the list at that point. Is the uses of pastebin.com the better
> way to provide such lengthy information in general?
>=20
>=20
> Best Regards
>=20
> Andreas Bluemle
>=20
> On Tue, 13 Aug 2013 11:59:36 +0800
> Matthew Anderson <manderson8787@gmail.com> wrote:
>=20
> > Moving this conversation to ceph-devel where the dev's might be abl=
e
> > to shed some light on this.
> >=20
> > I've added some additional debug to my code to narrow the issue dow=
n
> > a bit and the reader thread appears to be getting locked by
> > tcp_read_wait() because rpoll never returns an event when the socke=
t
> > is shutdown. A hack way of proving this was to lower the timeout in
> > rpoll to 5 seconds. When command like 'ceph osd tree' completes you
> > can see it block for 5 seconds until rpoll times out and returns 0.
> > The reader thread is then able to join and the pipe can be reaped.
> >=20
> > Ceph log is here - http://pastebin.com/rHK4vYLZ
> > Mon log is here - http://pastebin.com/WyAJEw0m
> >=20
> > What's particularly weird is that the monitor receives a POLLHUP
> > event when the ceph command shuts down it's socket but the ceph
> > command never does. When using regular sockets both sides of the
> > connection receive a POLLIN | POLLHUP | POLRDHUP event when the
> > sockets are shut down. It would seem like there is a bug in rsocket=
s
> > that causes the side that calls shutdown first not to receive the
> > correct rpoll events.
> >=20
> > Can anyone comment on whether the above seems right?
> >=20
> > Thanks all
> > -Matt
> >=20
> >=20
> > On Tue, Aug 13, 2013 at 12:06 AM, Andreas Bluemle <
> > andreas.bluemle@itxperts.de> wrote:
> >=20
> > > Hi Matthew,
> > >
> > > I am not quite sure about the POLLRDHUP.
> > > On the server side (ceph-mon), tcp_read_wait does see the
> > > POLLHUP - which should be the indicator that the
> > > the other side is shutting down.
> > >
> > > I have also taken a brief look at the client side (ceph mon stat)=
=2E
> > > It initiates a shutdown - but never finishes. See attached log
> > > file from "ceph --log-file ceph-mon-stat.rsockets --debug-ms 30
> > > mon stat". I have also attached the corresponding log file for
> > > regualr TCP/IP sockets.
> > >
> > > It looks to me that in the rsockets case, the reaper is able to
> > > cleanup even though there is still sth. left to do - and hence th=
e
> > > shutdown never completes.
> > >
> > >
> > > Best Regards
> > >
> > > Andreas Bluemle
> > >
> > >
> > > On Mon, 12 Aug 2013 15:11:47 +0800
> > > Matthew Anderson <manderson8787@gmail.com> wrote:
> > >
> > > > Hi Andreas,
> > > >
> > > > I think we're both working on the same thing, I've just changed
> > > > the function calls over to rsockets in the source instead of
> > > > using the pre-load library. It explains why we're having the
> > > > exact same problem!
> > > >
> > > > From what I've been able to tell the entire problem revolves
> > > > around rsockets not supporting POLLRDHUP. As far as I can tell
> > > > the pipe will only be removed when tcp_read_wait returns -1.
> > > > With rsockets it never receives the POLLRDHUP event after
> > > > shutdown_socket() is called so the rpoll call blocks until
> > > > timeout (900 seconds) and the pipe stays active.
> > > >
> > > > The question then would be how can we destroy a pipe without
> > > > relying on POLLRDHUP? shutdown_socket() always gets called when
> > > > the socket should be closed so could there might be a way to
> > > > trick tcp_read_wait() into returning -1 by doing somethere in
> > > > shutdown_socket() but I'm not sure how to go about it.
> > > >
> > > > Any ideas?
> > > >
> > >
>=20
>=20
>=20



--=20
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
Heinrich Boell Strasse 88           Phone: (+49) 89 4317582
D-81829 Muenchen (Germany)          Mobil: (+49) 177 522 0151
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
