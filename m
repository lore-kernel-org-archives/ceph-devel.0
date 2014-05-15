From: Dietmar Maurer <dietmar-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Does CEPH rely on any multicasting?
Date: Thu, 15 May 2014 17:07:43 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F7559524086@lisa.maurer-it.com>
References: <CADgBPFAc6mSy5qnvgoo7SEwEH-0cM7tPq7dUwj0V3XsX3CqfCw@mail.gmail.com>
	<CADgBPFDb8Eqy4xi=MynHzwdqmrOoomCmoo769CsB3OtzASnE+g@mail.gmail.com>
	<CAPYLRzhUJTma_g+WP0TsCCdVR4ROYwWiO-FfiR6WCssuqndcvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzhUJTma_g+WP0TsCCdVR4ROYwWiO-FfiR6WCssuqndcvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, Amit Vijairania <amit.vijairania-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

> > Does CEPH rely on any multicasting?  Appreciate the feedback..
> 
> Nope! All networking is point-to-point.

Besides, it would be great if ceph could use existing cluster stacks like corosync, ...
Is there any plan to support that?
