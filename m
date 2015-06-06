From: Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: rbd delete operation hangs, ops blocked
Date: Sat, 6 Jun 2015 09:06:15 +0300
Message-ID: <CAE63xUNPSDxt8Xd3Y-a-d+DoiAW-xQwF4gM1bQZ6WZDLvnJf1g@mail.gmail.com>
References: <CAE63xUOybtrxaJCb0UyGfgcWnFfDUBjm=QrNPZ15rGGBb8-AYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAE63xUOybtrxaJCb0UyGfgcWnFfDUBjm=QrNPZ15rGGBb8-AYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Update: I wonder if I cah follow advice here:
http://cephnotes.ksperis.com/blog/2014/07/04/remove-big-rbd-image

There is shown how to delete rbd objects directly via rados:
$rados -p rbd rm rbd_id.rbdname
$rados -p rbd rm rbd_header.18b3c2ae8944a
$rados -p temp1 ls | grep '^rbd_data.18b3c2ae8944a.'

Could that help and can I run this in parallel with stuck "rbd rm"?
I can reboot client that issued rbd rm command(if rbd rm is not simply
killable proces)  but would ceph cluster drop that operation there or
I would get some hanged forever operations internal to cluster? I need
to delete that rbd anyway.

Ugis


2015-06-06 8:53 GMT+03:00 Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi,
>
> I had recent problem with flapping hdd and in result I need to delete
> broken rbd.
> Problem is all operations towards this rbd stuck. I even cannot delete
> rbd - it sits on 6% done and I found this line in one of osds logs:
> 2015-06-06 08:03:31.770812 7fe5002c2700  0 log_channel(default) log
> [WRN] : slow request 30720.717642 seconds old, received at 2015-06-05
> 23:31:31.032740: osd_op(client.2457394.0:8430
> rbd_data.18b3c2ae8944a.00000000000020e5 [delete] 4.fac8e26
> ack+ondisk+write+known_if_redirected e136905) currently reached_pg
>
> How can I remove broken rbd? Fast way would be desirable, but any way
> will do that eventually helps to delete that rbd.
>
> Ugis
