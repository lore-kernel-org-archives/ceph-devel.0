From: Samuel Just <sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ceph -w warning "I don't have pgid 0.2c8"?
Date: Wed, 17 Jul 2013 11:16:49 -0700
Message-ID: <CA+4uBUbASJWUME+zOZRh=NrZLEGdJcmwXMoMWvvmgGRzG04C0w@mail.gmail.com>
References: <51E64EE7.3090902@vccloud.vn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51E64EE7.3090902-QlevPasa8l681eZEIcUDRw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

What version are you running?  How did you move the osds from 2TB to 4TB?
-Sam

On Wed, Jul 17, 2013 at 12:59 AM, Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org> wrote:
> Hi everyone,
>
> I converted every osds from 2TB to 4TB, and when moving complete, show log
> Ceph realtime"ceph -w":
> displays error: "I don't have pgid 0.2c8"
>
> after then, I run:  "ceph pg force_create_pg 0.2c8"
> Ceph warning: pgmap v55175: 22944 pgs: 1 creating, 22940 active+clean, 3
> stale+active+degraded
>
> then, I can't read/write data to mounted CephFS on Client-side ==> notify on
> client side: "Operation not permitted"
>
> now, "ceph -w" still notify "22944 pgs: 1 creating, 22940 active+clean, 3
> stale+active+degraded"
> and I don't understand something occuring?
> Please, help me!!!
>
> Thanks to everyone.
>
> --tuantaba
>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
