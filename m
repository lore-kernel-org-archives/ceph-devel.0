From: Gandalf Corvotempesta <gandalf.corvotempesta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RBD vs RADOS benchmark performance
Date: Mon, 13 May 2013 17:01:07 +0200
Message-ID: <CAJH6TXhcgNOLE53eJoJamwE3i-FSfBf9LzpRACHwp_hEriH5zA@mail.gmail.com>
References: <518D2B76.9040706@itooo.com> <1368423516.6771.2.camel@localhost>
	<5190DBD9.9070500@itooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5190DBD9.9070500-xVucS5mfmt0AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Greg <itooo-xVucS5mfmt0AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

2013/5/13 Greg <itooo-xVucS5mfmt0AvxtiuMwx3w@public.gmane.org>:
> thanks a lot for pointing this out, it indeed makes a *huge* difference !
>>
>> # dd if=/mnt/t/1 of=/dev/zero bs=4M count=100
>>
>> 100+0 records in
>> 100+0 records out
>> 419430400 bytes (419 MB) copied, 5.12768 s, 81.8 MB/s
>
> (caches dropped before each test of course)

What if you set 1024 or greater value ?
Is bandwidth relative to the read ahead size?
