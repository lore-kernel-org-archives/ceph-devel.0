From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: OSD crash on 0.48.2argonaut
Date: Thu, 15 Nov 2012 00:01:29 -0800
Message-ID: <50A4A159.7070300@inktank.com>
References: <60E83269D669544E8069A09CB69135EA0CEC66@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51088 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992679Ab2KOIBf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 03:01:35 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so979542pbc.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 00:01:35 -0800 (PST)
In-Reply-To: <60E83269D669544E8069A09CB69135EA0CEC66@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org

On 11/14/2012 11:31 PM, Eric_YH_Chen@wiwynn.com wrote:
> Dear All:
>
> I met this issue on one of osd node. Is this a known issue? Thanks!
>
> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe)
>   1: /usr/bin/ceph-osd() [0x6edaba]
>   2: (()+0xfcb0) [0x7f08b112dcb0]
>   3: (gsignal()+0x35) [0x7f08afd09445]
>   4: (abort()+0x17b) [0x7f08afd0cbab]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f08b065769d]
>   6: (()+0xb5846) [0x7f08b0655846]
>   7: (()+0xb5873) [0x7f08b0655873]
>   8: (()+0xb596e) [0x7f08b065596e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x1de) [0x7a82fe]
>   10: (ReplicatedPG::eval_repop(ReplicatedPG::RepGather*)+0x693) [0x530f83]
>   11: (ReplicatedPG::repop_ack(ReplicatedPG::RepGather*, int, int, int, eversion_t)+0x159) [0x531ac9]
>   12: (ReplicatedPG::sub_op_modify_reply(std::tr1::shared_ptr<OpRequest>)+0x15c) [0x53251c]
>   13: (ReplicatedPG::do_sub_op_reply(std::tr1::shared_ptr<OpRequest>)+0x81) [0x54d241]
>   14: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x1e3) [0x600883]
>   15: (OSD::dequeue_op(PG*)+0x238) [0x5bfaf8]
>   16: (ThreadPool::worker()+0x4d5) [0x79f835]
>   17: (ThreadPool::WorkThread::entry()+0xd) [0x5d87cd]
>   18: (()+0x7e9a) [0x7f08b1125e9a]
>   19: (clone()+0x6d) [0x7f08afdc54bd]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

The log of the crashed osd should show which assert actually failed.
It could be this bug, but I can't tell without knowing which
assert was triggered:

http://tracker.newdream.net/issues/2956

Josh
