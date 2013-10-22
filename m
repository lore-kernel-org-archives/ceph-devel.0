From: Gregory Farnum <greg@inktank.com>
Subject: Re: set mds message priority to MSG_PRIO_HIGH
Date: Mon, 21 Oct 2013 21:59:54 -0700
Message-ID: <CAPYLRzhgCsM9r_xFbWG7HWj9QH68s7EOW-xUWC9ZAZZpJanGxw@mail.gmail.com>
References: <004001ceccca$f7e0fba0$e7a2f2e0$@gmail.com>
	<CAAM7YA=ZgFtX-PDPz_ULUsaCGnACu2_ARD23A7shxitAUeE2Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33419 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab3JVE74 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Oct 2013 00:59:56 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so4981185wid.17
        for <ceph-devel@vger.kernel.org>; Mon, 21 Oct 2013 21:59:54 -0700 (PDT)
In-Reply-To: <CAAM7YA=ZgFtX-PDPz_ULUsaCGnACu2_ARD23A7shxitAUeE2Gg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: hjwsm1989-gmail <hjwsm1989@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Oct 19, 2013 at 7:14 AM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Sat, Oct 19, 2013 at 8:58 PM, hjwsm1989-gmail <hjwsm1989@gmail.com=
> wrote:
>> Hi,
>> I'm testing ceph with samba.
>> I have 20 OSD nodes on 4 hosts
>> dy01:1MON, 5 OSDs, 1 samba server
>> dy02: 1MDS, 5OSDs, 1 samba server
>> dy03: 5 OSDs, 1 samba server
>> dy04:5 OSDs, 1 samba server
>> every samba server exports the ceph kclient mount point.
>>
>> When I set 3 samba clients connect to a samba server(dy01), and each=
 write a
>> single 18GB file, gets 110MB/s speed each.
>> But when I use 4 clients, the cluster will report 'slow request' msg=
, and
>> this time I list files in samba client dir, it gets stuck.
>> And the test tool reports frame losing.
>> For the list operation related to MDS, I think the MDS op messages s=
hould
>> have higher priority than clients op.
>> Have I understood correctly?
>
> Hi,
>
> I think you are right, the MDS needs higher priority. could you modif=
y
> the mds code
> and re-test.
>
> In src/ceph_mds.cc, add
> "messenger->set_default_send_priority(CEPH_MSG_PRIO_HIGH);"
> after
> "messenger->set_cluster_protocol(CEPH_MDS_PROTOCOL);"
>
> Regards
> Yan, Zheng

If this actually turns out to be useful, we'll want to briefly go
through the code base and adjust the other levels =97 a quick grep
indicates the MDS sets some traffic to LOW that should correspondingly
be bumped up to NORMAL; the OSDs are currently using HIGH for acks and
commits, but we probably want those messages to continue having a
higher priority than any clients (MDS included) are setting messages
at.
(I'm not sure it actually will; I suspect what's happening here is
just that 4 clients are passing some limit that 3 aren't.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
