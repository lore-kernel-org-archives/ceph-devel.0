From: David McBride <dwm37-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: Does CEPH rely on any multicasting?
Date: Fri, 16 May 2014 09:21:21 +0100
Message-ID: <5375CA81.9090000@cam.ac.uk>
References: <CADgBPFAc6mSy5qnvgoo7SEwEH-0cM7tPq7dUwj0V3XsX3CqfCw@mail.gmail.com>	<CADgBPFDb8Eqy4xi=MynHzwdqmrOoomCmoo769CsB3OtzASnE+g@mail.gmail.com>
	<CAPYLRzhUJTma_g+WP0TsCCdVR4ROYwWiO-FfiR6WCssuqndcvA@mail.gmail.com>
	<24E144B8C0207547AD09C467A8259F7559524086@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <24E144B8C0207547AD09C467A8259F7559524086-KlZn3V+I5p1s8ZkLLAvlZtBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dietmar Maurer <dietmar-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>, Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, Amit Vijairania <amit.vijairania-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 15/05/14 18:07, Dietmar Maurer wrote:

> Besides, it would be great if ceph could use existing cluster stacks like corosync, ...
> Is there any plan to support that?

For clarity: To what end?

Recall that Ceph already incorporates its own cluster-management
framework, and the various Ceph daemons already operate in a clustered
manner.

(The documentation at
http://ceph.com/docs/firefly/architecture/#scalability-and-high-availability
may be helpful if you are not already familiar with this.)

Kind regards,
David
-- 
David McBride <dwm37-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Unix Specialist, University Information Services
