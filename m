From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] Ceph killed by OS because of OOM under high load
Date: Mon, 3 Jun 2013 09:36:53 -0700
Message-ID: <CAPYLRzgmPEkzGBYW31XzSAjm44MBK6jNct-QjpJnVWXUXJR1gw@mail.gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E0E095@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46218 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759195Ab3FCQgz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 12:36:55 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so728605lbh.35
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jun 2013 09:36:53 -0700 (PDT)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC01E0E095@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Mark Nelson (mark.nelson@inktank.com)" <mark.nelson@inktank.com>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Mon, Jun 3, 2013 at 8:47 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
> Hi,
>         As my previous mail reported some weeks ago ,we are suffering from OSD crash/ OSD Flipping / System reboot and etc, all these unstable issue really stop us from digging further into ceph characterization.
>         Good news is that we seems find out the cause, I explain our experiments below:
>
>         Environment:
>                 We have 2 machines, one for client and one for ceph, connected via 10GbE.
>                 The client machine is very powerful, with 64 Cores and 256G RAM.
>                 The ceph machine with 32 Cores and 64G RAM, but we limited the available RAM to 8GB by the grub configuration.12 OSDs on top of 12* 5400 RPM 1T disk , 4* DCS 3700 SSDs as journals.
>                 Both client and ceph are v0.61.2.
>                 We run 12 rados bench instances in client node as a stress to ceph node, each instance with 256 concurrent.
>         Experiment and result:
>                 1.default ceph + default client ,   OK
>                 2.tuned ceph  + default client    FAIL,One osd killed by OS due to OOM, and all swap space is run out. (tuning: Large queue ops/Large queue bytes/.No flusher/sync_flush =true)
>                 3.tuned ceph WITHOUT large queue bytes  + default client   OK
>                 4.tuned ceph WITHOUT large queue bytes  + aggressive client  FAILED, One osd killed by OOM and one suicide because 150s op thread timeout.  (aggressive client: objecter_inflight_ops, opjecter_inflight_bytes are both set to 10X of default)
>
>         Conclusion.
>                 We would like to say,
>                 a.      under heavy load, some tuning will make ceph unstable ,especially queue bytes related ( deduce from 1+2+3)
>                 b.      Ceph doesn't do any control on the lenth of OSD Queue, this is a critical issue, with aggressive client or a lot of concurrent clients, the osd queue will become too long to fit in memory ,thus result in osd daemon being killed.(deduce from 3+4)
>                 c.   An observation to osd daemon memory usage show that, if I use "killall rados" to kill all the rados bench instances, the ceph osd daemon cannot free the allocated memory, instead, it still remain very high memory usage(a new started ceph used ~0.5 GB , and with load it used ~ 6GB , if killed rados, it still remain 5~6GB, restart ceph can solve this issue)

You don't have enough RAM for your OSDs. We really recommend 1-2GB per
daemon; 600MB/daemon is dangerous. You might be able to make it work,
but you'll definitely need to change the queue lengths and things.
Speaking of which...yes, the OSDs do control their queue lengths, but
it's not dynamic tuning and by default it will let clients stack up
500MB of in-progress writes. With such wimpy systems you'll want to
turn that down, probably alongside various journal and disk wait
queues.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
