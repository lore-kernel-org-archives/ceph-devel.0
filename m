From: Ning Yao <zay11022-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph QoS user stories
Date: Sat, 3 Dec 2016 17:58:31 +0800
Message-ID: <CALZt5jyDEDW8vhgFvk5ocn9Cm-_6oOHeOq-+mfD8gGc6eXaMtg@mail.gmail.com>
References: <alpine.DEB.2.11.1612021847590.22800@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1612021847590.22800-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

I think we can refactor the io priority strategy at the same time
based on our consideration below?

2016-12-03 17:21 GMT+08:00 Ning Yao <zay11022-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi, all
>
> Currently,  we can modify osd_client_op_priority to assign different
> clients' ops with different priority such like we can assign high
> priority for OLTP and assign low priority for OLAP. However, there are
> some consideration as below:
>
> 1) it seems OLTP's client op still can be blocked by OLAP's sub_ops
> since sub_ops use the CEPH_MSG_PRIO_DEFAULT.  So should we consider
> sub_op should inherit the message's priority from client Ops (if
> client ops do not give priority  explicitly, use CEPH_MSG_PRIO_DEFAULT
> by default), does this make sense?
>
> 2) secondly, reply message is assigned with
> priority(CEPH_MSG_PRIO_HIGH), but there is no restriction for client
> Ops' priority (use can set 210), which will lead to blocked for reply
> message. So should we think change those kind of message to highest
> priority(CEPH_MSG_PRIO_HIGHEST). Currently, it seems no ops use
> CEPH_MSG_PRIO_HIGHEST.
>
> 3) I think the kick recovery ops should inherit the client ops priority
>
> 4) Is that possible to add test cases to verify whether it works
> properly as expected in ceph-qa-suite as Sam mentioned before? Any
> guidelines?
Regards
Ning Yao


2016-12-03 3:01 GMT+08:00 Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> Hi all,
>
> We're working on getting infrasture into RADOS to allow for proper
> distributed quality-of-service guarantees.  The work is based on the
> mclock paper published in OSDI'10
>
>         https://www.usenix.org/legacy/event/osdi10/tech/full_papers/Gulati.pdf
>
> There are a few ways this can be applied:
>
>  - We can use mclock simply as a better way to prioritize background
> activity (scrub, snap trimming, recovery, rebalancing) against client IO.
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS or
> proportional priority/weight) on RADOS pools
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS) for
> individual clients.
>
> Once the rados capabilities are in place, there will be a significant
> amount of effort needed to get all of the APIs in place to configure and
> set policy.  In order to make sure we build somethign that makes sense,
> I'd like to collection a set of user stores that we'd like to support so
> that we can make sure we capture everything (or at least the important
> things).
>
> Please add any use-cases that are important to you to this pad:
>
>         http://pad.ceph.com/p/qos-user-stories
>
> or as a follow-up to this email.
>
> mClock works in terms of a minimum allocation (of IOPS or bandwidth; they
> are sort of reduced into a single unit of work), a maximum (i.e. simple
> cap), and a proportional weighting (to allocation any additional capacity
> after the minimum allocations are satisfied).  It's somewhat flexible in
> terms of how we apply it to specific clients, classes of clients, or types
> of work (e.g., recovery).  How we put it all together really depends on
> what kinds of things we need to accomplish (e.g., do we need to support a
> guaranteed level of service shared across a specific set of N different
> clients, or only individual clients?).
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
