From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Cluster Network & Public Network w.r.t XIO ?
Date: Fri, 31 Jul 2015 13:04:12 -0400 (EDT)
Message-ID: <1211289190.918749.1438362252889.JavaMail.zimbra@redhat.com>
References: <CAFkUHxddmOdyZHcjzCoEJYu_YkkUZ=3aq_FZ4QfJNqdKJ_xO3A@mail.gmail.com> <1508871103.877228.1438354197061.JavaMail.zimbra@redhat.com> <CAFkUHxcyxHO-0OyB9-v+6TeHAXRPQVS+LFeP7K7ywvEw0g=b_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:35527 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbbGaRES (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jul 2015 13:04:18 -0400
In-Reply-To: <CAFkUHxcyxHO-0OyB9-v+6TeHAXRPQVS+LFeP7K7ywvEw0g=b_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel neophyte <neophyte.hacker001@gmail.com>
Cc: vu@mellanox.com, raju kurunkad <raju.kurunkad@sandisk.com>, ceph-devel@vger.kernel.org, Marcus Watts <mwatts@redhat.com>

Hi Neo,

I'm not sure of the state of current WIP, but Marcus (CC'd) is coordinating atm
from our end.  I'm sure we'd love help, so we'll check back in with updated branch
info--maybe next week?

Matt

----- Original Message -----
From: "kernel neophyte" <neophyte.hacker001@gmail.com>
To: "Matt Benjamin" <mbenjamin@redhat.com>
Cc: vu@mellanox.com, "raju kurunkad" <raju.kurunkad@sandisk.com>, ceph-devel@vger.kernel.org, "Marcus Watts" <mwatts@redhat.com>
Sent: Friday, July 31, 2015 12:20:33 PM
Subject: Re: Cluster Network & Public Network w.r.t XIO ?

On Fri, Jul 31, 2015 at 7:49 AM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> Hi Neo,
>
> On our formerly-internal firefly-based branch, what we did was create additional Messenger
> instances ad infinitum, which at least let you do this, but it's not what anybody wanted for
> upstream or long-term.  What's upstream now doesn't let you IIRC describe that.  The rdma_local
> parameter like you say is insufficient (and actually a hack).
>
> What we plan to do (and have in progress) is extending work Sage started on wip-address, which
> will enable multi-homing and identify instances by their transport type(s).  We might put more
> information there to help with future topologies.  Improved configuration language to let you
> describe your desired network setup would be packaged with that.

This is awesome! could you please point me to your WIP branch ? Also
please let know if I could help speed up the dev/test process ?

-Neo

>
> The plan is that an improved situation might arrive as early as J.  If we need an interim method,
> now would be a good time to start discussion.
>
> Matt
>
> ----- Original Message -----
> From: "kernel neophyte" <neophyte.hacker001@gmail.com>
> To: vu@mellanox.com, "raju kurunkad" <raju.kurunkad@sandisk.com>, ceph-devel@vger.kernel.org
> Sent: Thursday, July 30, 2015 11:21:06 PM
> Subject: Cluster Network & Public Network w.r.t XIO ?
>
> Hi Vu, Raju,
>
> I am trying to bring up ceph cluster on a powerful dell server with
> two 40Gbe ROCEv2 NIC.
>
> I have assigned one as my cluster network (would prefer all osd
> communications happen on that) and have assigned one as my public n/w.
> this works fine for simple messenger case. (ofcourse no rdma)
>
> but when I try to bring this up on XIO, this gets very complicated, as
> in how do I specify two RDMA_LOCAL  ? one for cluster n/w and other
> for public ? can choose XIO for client to osd communication and simple
> for cluster n/w ?
>
> any thoughts ?
>
> Thanks,
> Neo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
