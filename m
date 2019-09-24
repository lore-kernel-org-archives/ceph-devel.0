From: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Tue, 24 Sep 2019 14:05:36 -0600
Message-ID: <CALqRxCygXUzA0+4sY6meMO9Smq2rouei7ay0BqJD9+-du7RCYQ@mail.gmail.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ@mail.gmail.com> <CALi_L4_Sz8oFHAFyRfqDfLWGRJSHnSd=dyYUZ6P92o8VY3vGCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <CALi_L4_Sz8oFHAFyRfqDfLWGRJSHnSd=dyYUZ6P92o8VY3vGCQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Sasha Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Sep 17, 2019 at 8:03 AM Sasha Litvak
<alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> * I am bothered with a quality of the releases of a very complex system that
> can bring down a whole house and keep it down for a while.  While I wish the
> QA would be perfect, I wonder if it would be practical to release new
> packages to a testing repo before moving it to a main one.  There is a
> chance then someone will detect a problem before it becomes a production
> issue.  Let it seat for a couple days or weeks in testing.  People who need
> new update right away or just want to test will install it and report the
> problems.  Others will not be affected.

I think it would be a good step forward to have a separate "testing"
repository. This repository would be a little more cutting-edge, and we'd copy
all the binaries over to the "main" repository location after 48 hours or
something.

This would let us all publicly test the candidate GPG-signed packages, for
example.

- Ken
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
