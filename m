From: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Is there any way for ceph-osd to control the max
 fds?
Date: Wed, 19 Sep 2018 06:49:23 -0700
Message-ID: <CAJ4mKGZX_XCVeFXNssJz_hFFvFWE5RWuz5CBusuc1uhoZy-CVA@mail.gmail.com>
References: <CAATxhGf8Qz8NdfgAsVgaXqumRLVPtgGu=sZqcmb7ZSSUB6N4CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAATxhGf8Qz8NdfgAsVgaXqumRLVPtgGu=sZqcmb7ZSSUB6N4CQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jeffrey Zhang <zhang.lei.fly-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Sep 17, 2018 at 5:39 AM, Jeffrey Zhang <zhang.lei.fly-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> In one env, which is deployed through container, i found the ceph-osd always
> be suicide due to "error (24) Too many open files"
>
> Then i increased the LimitNOFILE for the container from 65k to 655k, which
> could fix the issue.
> But the FDs increase all the time. now the max number is around 155k. I am
> afraid
> it will increase forever.
>
> I also found there is a option `max_open_files`, but it seems only used for
> upstart scripts at OS level, and the default value is
> 16384 now[2]. whereas if you are using systemd, it will never load from the
> `max_open_files` options and fixed to 1048576 in default[1].
> So i guess if the ceph-osd live long enough, it will still read the OS level
> strict and suicide at the end.
>
> So here is the question
> 1. since almost all os distro already moved to systemd, so max_open_files is
> uselss now.
> 2. is there any mechanism that ceph-osd could release some fds?

If an OSD actually hits its file limits it just sort of stops; we
don't have mechanisms to trim them down through the whole process.
This is because we need a socket descriptor for every connection
(which you can consider to be every client, plus a monitor and
manager, plus a multiple on the number of OSD peers it has), plus the
files open (which mostly only applies to FileStore and there's a
config, defaults to 1024 I think).
155k is large but I've seen that number before. In systemd we just set
it to 1 million at this point, which has not come up as a limit for
anybody yet. :)
-Greg

>
>
> [0]
> https://github.com/ceph/ceph/commit/16c603b26f3d7dfcf0028e17fe3c04d94a434387
> [1] https://github.com/ceph/ceph/commit/8453a89
> [2]
> https://github.com/ceph/ceph/commit/672c56b18de3b02606e47013edfc2e8b679d8797
>
>
>
> --
> Regards,
> Jeffrey Zhang
> Blog: http://xcodest.me
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
