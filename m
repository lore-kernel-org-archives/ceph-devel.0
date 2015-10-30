From: shylesh kumar <shylesh.mohan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Is lttng enable by default in debian hammer-0.94.5?
Date: Fri, 30 Oct 2015 12:48:13 +0530
Message-ID: <CAMxOGo0zj=Zxn0Jf0Bk5OZR9HW_JJCE+zDAoStswgo4BU45JvQ@mail.gmail.com>
References: <5632E7E7.1030901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5632E7E7.1030901-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: hzwulibin <hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

Have you disabled apparmor?

Please check apparmor_status if libvirtd is in enforcing mode then
lttng traces will not be generated.

Thanks,
Shylesh

On Fri, Oct 30, 2015 at 9:15 AM, hzwulibin <hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi, everyone
>
> After install hammer-0.94.5 in debian, i want to trace the librbd by lttng, but after done follow steps, i got nothing:
>  2036  mkdir -p traces
>  2037  lttng create -o traces librbd
>  2038  lttng enable-event -u 'librbd:*'
>  2039  lttng add-context -u -t pthread_id
>  2040  lttng start
>  2041  lttng stop
>
> So, is the lttng enabled in this version on debian?
>
> Thanks!
>
> --------------
> hzwulibin
> 2015-10-30
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Thanks & Regards
Shylesh Kumar M
