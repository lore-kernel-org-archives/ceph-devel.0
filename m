From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: BUG ON librbd or libc
Date: Tue, 23 Aug 2016 07:57:33 -0400
Message-ID: <CA+aFP1AHRUdp46CUQHuXd0WpmS8pc7m8iuLxKPRjP6ESRmRhSQ@mail.gmail.com>
References: <CALZt5jz5K_+bduZg6DgQxjm4E6L4Eizp_aW8pOgiEWB33Vc=ng@mail.gmail.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALZt5jz5K_+bduZg6DgQxjm4E6L4Eizp_aW8pOgiEWB33Vc=ng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ning Yao <zay11022-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

There was almost the exact same issue on the master branch right after
the switch to cmake because tcmalloc was incorrectly (and partially)
linked into librados/librbd. What occurred was that the std::list
within ceph::buffer::ptr was allocated via tcmalloc but was freed
within librados/librbd via the standard malloc.

On Tue, Aug 23, 2016 at 3:45 AM, Ning Yao <zay11022-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi, all
>
> Our vm is terminated unexpectedly when using librbd in our production
> environment with CentOS 7.0 kernel 3.12 with Ceph version 0.94.5 and
> glibc version 2.17. we get log from libvirtd as below
>
> *** Error in `/usr/libexec/qemu-kvm': invalid fastbin entry (free):
> 0x00007f7db7eed740 ***
>
> ======= Backtrace: =========
>
> /lib64/libc.so.6(+0x7d1fd)[0x7f8520fe61fd]
>
> /lib64/librbd.so.1(_ZNSt10_List_baseIN4ceph6buffer3ptrESaIS2_EE8_M_clearEv+0x2f)[0x7f8527589b3f]
>
> /lib64/librados.so.2(+0xb8a06)[0x7f8525080a06]
>
> /lib64/librados.so.2(+0xb9457)[0x7f8525081457]
>
> /lib64/librados.so.2(+0x718f7)[0x7f85250398f7]
>
> /lib64/librados.so.2(+0x2bffe5)[0x7f8525287fe5]
>
> /lib64/librados.so.2(+0x2cbaad)[0x7f8525293aad]
>
> /lib64/libpthread.so.0(+0x7df5)[0x7f852ab12df5]
>
> /lib64/libc.so.6(clone+0x6d)[0x7f852105f1ad]
>
> but the log does not show symbols so that we cannot know which
> functions cause the error, any suggestions?
>
>
>
> Regards
> Ning Yao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
