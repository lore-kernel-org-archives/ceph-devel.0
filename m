From: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Wed, 25 Sep 2019 16:10:25 -0600
Message-ID: <CALqRxCw3Z2HHfszEizVtNbd2f22antp-2CbRpehUVTMO0b3FKw@mail.gmail.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ@mail.gmail.com>
 <CALi_L4_Sz8oFHAFyRfqDfLWGRJSHnSd=dyYUZ6P92o8VY3vGCQ@mail.gmail.com>
 <CALqRxCygXUzA0+4sY6meMO9Smq2rouei7ay0BqJD9+-du7RCYQ@mail.gmail.com>
 <CAN-GepKyROe6CRmKFjFyMvH8b5AGPomh96Q6gRVzQS-Zv-iDtQ@mail.gmail.com>
 <CAA6-MF_OwcHjDTM=48_pbPbp8BPf0Dd+iLTWZ+06E8akKoMxGA@mail.gmail.com> <CALi_L4-QGFaKhRSNUMcC+CfNnh8rBR_A8PBkVqDydSEX5ho7Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <CALi_L4-QGFaKhRSNUMcC+CfNnh8rBR_A8PBkVqDydSEX5ho7Ag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Sasha Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Unknown <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Sep 25, 2019 at 1:56 PM Sasha Litvak
<alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> I guess for me the more crucial  questions should be answered:
>

> 1.  How can a busted release be taken out of repos (some metadata
> update I hope)?

It's hard to define the word "busted" in a way that satisfies everyone.

For example, in the past, we've heard rumors that the releases are
"busted" and we need to pull them, and in reality the impact turned out
to be way smaller than expected. If we let panic reign, we would have
builds appearing and disappearing quite often.

Or to borrow a real example, what happens when the new (buggy) release
fixes a CVE, and we coordinated the disclosure of the CVE to happen on
release day? Then we're hurting some users to help others.

> 2.  Can some fix(es) be added into a test release so they can be
> accessed by community and tested  / used before next general release
> is avaialble.  I was thinking about trying to pick some critical
> backports for internal build / testing but it is not very simple for
> everyone.  It seems that shaman has some test builds going on, so may
> be if a track issue will mention that build xxxyz contains fixes for
> ticket 9999 "for testing purposes only use at your peril", it will
> allow the community to test the build and for someone who in need to
> get to the higher ground quickly.

There's certainly more to explore here. Maybe we need a defined release
criteria so things are less subjective. Or maybe increasing the
frequency and decreasing the size of releases will help. I'm interested
in lowering the barriers for contributors to test early and often so
our cutting-edge users get their builds fast and our more conservative
users get something more stable.
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
