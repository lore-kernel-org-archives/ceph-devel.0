From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Kernel crashes with RBD
Date: Fri, 13 Apr 2012 10:48:58 -0700
Message-ID: <4F88670A.7080709@dreamhost.com>
References: <4F860619.5040802@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45957 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab2DMRtE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Apr 2012 13:49:04 -0400
In-Reply-To: <4F860619.5040802@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@dreamhost.com>

On 04/11/2012 03:30 PM, Danny Kukawka wrote:
> Hi,
>
> we are currently testing CEPH with RBD on a cluster with 1GBit and
> 10Gbit interfaces. While we see no kernel crashes with RBD if the
> cluster runs on the 1GBit interfaces, we see very frequent kernel
> crashes with the 10Gbit network while running tests with e.g. fio
> against the RBDs.
>
> I've tested it with kernel v3.0 and also 3.3.0 (with the patches from
> the 'for-linus' branch from ceph-client.git at git.kernel.org).
>
> With more client machines running tests the crashes occur even much
> faster. The issue is fully reproducible here.
>
> Has anyone seen similar problems? See the backtrace below.
>
> Regards
>
> Danny
>
> PID: 10902  TASK: ffff88032a9a2080  CPU: 0   COMMAND: "kworker/0:0"
>   #0 [ffff8803235fd950] machine_kexec at ffffffff810265ee
>   #1 [ffff8803235fd9a0] crash_kexec at ffffffff810a3bda
>   #2 [ffff8803235fda70] oops_end at ffffffff81444688
>   #3 [ffff8803235fda90] __bad_area_nosemaphore at ffffffff81032a35
>   #4 [ffff8803235fdb50] do_page_fault at ffffffff81446d3e
>   #5 [ffff8803235fdc50] page_fault at ffffffff81443865
>      [exception RIP: read_partial_message+816]
>      RIP: ffffffffa041e500  RSP: ffff8803235fdd00  RFLAGS: 00010246
>      RAX: 0000000000000000  RBX: 00000000000009d7  RCX: 0000000000008000
>      RDX: 0000000000000000  RSI: 00000000000009d7  RDI: ffffffff813c8d78
>      RBP: ffff880328827030   R8: 00000000000009d7   R9: 0000000000004000
>      R10: 0000000000000000  R11: ffffffff81205800  R12: 0000000000000000
>      R13: 0000000000000069  R14: ffff88032a9bc780  R15: 0000000000000000
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #6 [ffff8803235fdd38] thread_return at ffffffff81440e82
>   #7 [ffff8803235fdd78] try_read at ffffffffa041ed58 [libceph]
>   #8 [ffff8803235fddf8] con_work at ffffffffa041fb2e [libceph]
>   #9 [ffff8803235fde28] process_one_work at ffffffff8107487c
> #10 [ffff8803235fde78] worker_thread at ffffffff8107740a
> #11 [ffff8803235fdee8] kthread at ffffffff8107b736
> #12 [ffff8803235fdf48] kernel_thread_helper at ffffffff8144c144
>

This looks similar to http://tracker.newdream.net/issues/2261. What do 
you think Alex?

Josh


