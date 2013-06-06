From: Gregory Farnum <greg@inktank.com>
Subject: Re: How many Pipe per Ceph OSD daemon will keep?
Date: Thu, 6 Jun 2013 09:21:27 -0700
Message-ID: <CAPYLRzjLtvcp3ZDmtT4YRH7itYz1o_1P92uUKMeGj1mETscEJw@mail.gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E172F6@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:40670 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3FFQV2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jun 2013 12:21:28 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so3237497lbh.21
        for <ceph-devel@vger.kernel.org>; Thu, 06 Jun 2013 09:21:27 -0700 (PDT)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC01E172F6@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Thu, Jun 6, 2013 at 12:25 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> w=
rote:
>
> Hi,
>          From the code, each pipe (contains a TCP socket) will fork 2=
 threads, a reader and a writer. We really observe 100+ threads per OSD=
 daemon with 30 instances of rados bench as clients.
>          But this number seems a bit crazy, if I have a 40 disks node=
, thus I will have 40 OSDs, we plan to have 6 such nodes to serve 120 V=
Ms from OpenStack.  Since a RBD is distributed across all the OSDs, we =
can expect, for every single OSD daemon, we will have 120 TCP socket, t=
hat means 240 threads. Thus for 40 OSDs per node, we will have 9600 thr=
eads per node. This thread number seems incredible.
>          Is there any internal mechanism to track and manage the numb=
er of pipes ? and another question may be , why we need such a lot thre=
ads ? why not epoll?
Yep, right now the OSD maintains two threads per connection. That
hasn't been a problem so far (they're fairly cheap threads) and people
run into other limits much earlier =97 40 OSDs/node for instance would
require a lot of compute power anyway.
epoll is a good idea and is something we're aware of, but it hasn't
been necessary yet and would involve mucking around with some fairly
sensitive core code so it hasn't risen to the top of anybody's queue.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
