From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: set mds message priority to MSG_PRIO_HIGH
Date: Sat, 19 Oct 2013 22:14:51 +0800
Message-ID: <CAAM7YA=ZgFtX-PDPz_ULUsaCGnACu2_ARD23A7shxitAUeE2Gg@mail.gmail.com>
References: <004001ceccca$f7e0fba0$e7a2f2e0$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:62402 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab3JSOOw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Oct 2013 10:14:52 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so1691452lab.4
        for <ceph-devel@vger.kernel.org>; Sat, 19 Oct 2013 07:14:51 -0700 (PDT)
In-Reply-To: <004001ceccca$f7e0fba0$e7a2f2e0$@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hjwsm1989-gmail <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Oct 19, 2013 at 8:58 PM, hjwsm1989-gmail <hjwsm1989@gmail.com> wrote:
> Hi,
> I'm testing ceph with samba.
> I have 20 OSD nodes on 4 hosts
> dy01:1MON, 5 OSDs, 1 samba server
> dy02: 1MDS, 5OSDs, 1 samba server
> dy03: 5 OSDs, 1 samba server
> dy04:5 OSDs, 1 samba server
> every samba server exports the ceph kclient mount point.
>
> When I set 3 samba clients connect to a samba server(dy01), and each write a
> single 18GB file, gets 110MB/s speed each.
> But when I use 4 clients, the cluster will report 'slow request' msg, and
> this time I list files in samba client dir, it gets stuck.
> And the test tool reports frame losing.
> For the list operation related to MDS, I think the MDS op messages should
> have higher priority than clients op.
> Have I understood correctly?

Hi,

I think you are right, the MDS needs higher priority. could you modify
the mds code
and re-test.

In src/ceph_mds.cc, add
"messenger->set_default_send_priority(CEPH_MSG_PRIO_HIGH);"
after
"messenger->set_cluster_protocol(CEPH_MDS_PROTOCOL);"

Regards
Yan, Zheng
>
> thanks
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
