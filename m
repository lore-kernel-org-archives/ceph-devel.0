From: Greg <itooo-xVucS5mfmt0AvxtiuMwx3w@public.gmane.org>
Subject: Re: RBD vs RADOS benchmark performance
Date: Mon, 13 May 2013 17:10:37 +0200
Message-ID: <5191026D.4030004@itooo.com>
References: <518D2B76.9040706@itooo.com> <1368423516.6771.2.camel@localhost>
	<5190DBD9.9070500@itooo.com>
	<CAJH6TXhcgNOLE53eJoJamwE3i-FSfBf9LzpRACHwp_hEriH5zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJH6TXhcgNOLE53eJoJamwE3i-FSfBf9LzpRACHwp_hEriH5zA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Gandalf Corvotempesta <gandalf.corvotempesta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Le 13/05/2013 17:01, Gandalf Corvotempesta a =E9crit :
> 2013/5/13 Greg <itooo-xVucS5mfmt0AvxtiuMwx3w@public.gmane.org>:
>> thanks a lot for pointing this out, it indeed makes a *huge* difference !
>>> # dd if=3D/mnt/t/1 of=3D/dev/zero bs=3D4M count=3D100
>>>
>>> 100+0 records in
>>> 100+0 records out
>>> 419430400 bytes (419 MB) copied, 5.12768 s, 81.8 MB/s
>> (caches dropped before each test of course)
> What if you set 1024 or greater value ?
> Is bandwidth relative to the read ahead size?
Setting the value too high degrades performance, especially random IO =

performance.
You have to determine  the right choice for your usage.

Cheers,
