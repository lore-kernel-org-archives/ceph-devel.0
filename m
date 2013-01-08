From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD Crashed when runing "rbd list"
Date: Tue, 8 Jan 2013 09:12:25 -0800
Message-ID: <CAPYLRzgsAtwd8Fca9MvM9kaCqNRu-e3yzBCBY_PZXjq6hB1pZg@mail.gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC5D2A50@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:40405 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598Ab3AHRM0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 12:12:26 -0500
Received: by mail-qc0-f171.google.com with SMTP id d1so866989qca.30
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 09:12:25 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5D2A50@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jan 8, 2013 at 7:51 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
> Hi List,
>       Every time I ran "rbd list" after creating a lot of rbd volumes (more than 100s), certain OSDs will die,osd.65 die first and then osd.35 (osd.65,that's the fifth disk on the sixth host) will die.
>   Is it a bug for 0.55? My ceph version is 0.55-1 with 3.7 kernel.
>         I would like to upgrade to 0.56-1 but there is no package for 3.7 kernel(raring)
>
>    Log of osd.35 attached.Key messages are below:
>
> 1 -- 192.101.11.203:6843/19960 mark_down 192.101.11.206:6861/3735 -- 0x7f331867a000
>    -38> 2013-01-08 23:37:37.751473 7f3302fc0700 -1 ./messages/MOSDOp.h: In function 'bool MOSDOp::check_rmw(int)' thread 7f3302fc0700 time 2013-01-08 23:37:37.748254
> ./messages/MOSDOp.h: 57: FAILED assert(rmw_flags)
>
>  ceph version 0.55.1 (8e25c8d984f9258644389a18997ec6bdef8e056b)
>  1: (()+0x22f765) [0x7f3310831765]
>  2: (MOSDOpReply::claim_op_out_data(std::vector<OSDOp, std::allocator<OSDOp> >&)+0) [0x7f3310897850]
>  3: (OSD::handle_op(std::tr1::shared_ptr<OpRequest>)+0x441) [0x7f33108f19c1]
>  4: (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x83) [0x7f33108fd8c3]
>  5: (OSD::do_waiters()+0x104) [0x7f33108fdc64]
>  6: (OSD::ms_dispatch(Message*)+0x317) [0x7f33109027e7]
>  7: (DispatchQueue::entry()+0x353) [0x7f3310b6b743]
>  8: (DispatchQueue::DispatchThread::entry()+0xd) [0x7f3310ac7dad]
>  9: (()+0x7f9f) [0x7f330ffc5f9f]
>  10: (clone()+0x6d) [0x7f330e2800cd]
>
>    Thanks for the help.

Sounds like you've got a v0.56 binary talking to v0.55 daemons. An
upgrade to v0.56.1 should fix it. See
http://tracker.newdream.net/issues/3715
-Greg
