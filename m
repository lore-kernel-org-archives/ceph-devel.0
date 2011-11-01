From: Sage Weil <sage@newdream.net>
Subject: Re: BUG at fs/inode.c
Date: Tue, 1 Nov 2011 09:51:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1111010907470.30839@cobra.newdream.net>
References: <201110241239.13157.a.ott@m-privacy.de> <201110251038.06482.a.ott@m-privacy.de>
 <201110251635.11474.a.ott@m-privacy.de> <201111010923.18074.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39478 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab1KAQvC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2011 12:51:02 -0400
In-Reply-To: <201111010923.18074.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 1 Nov 2011, Amon Ott wrote:
> On Tuesday 25 October 2011 wrote Amon Ott:
> > On Tuesday 25 October 2011 wrote Amon Ott:
> > > On Monday 24 October 2011 wrote Yehuda Sadeh Weinraub:
> > > > Also, the client logs could help shedding a light on the issue. You
> > > > should have dynamic debugging turned on (CONFIG_DYNAMIC_DEBUG), and
> > > > something along the lines of:
> > > >
> > > > # mount -t debugfs none /sys/kernel/debug
> > > > # echo 'module ceph +p' > /sys/kernel/debug/dynamic_debug/control
> > > > # echo 'module libceph +p' > /sys/kernel/debug/dynamic_debug/control
> > >
> > > New kernels are building right now. Upgraded to 3.0.8, put in new
> > > ceph-client master fix 8ba1683acc83aee4bcab304844f8e60330e5ef1f and added
> > > CONFIG_DYNAMIC_DEBUG. This kernel will go into two big servers this time
> > > to give it some real load. Let's see whether I can reproduce there, too.
> > > If so, I will provide debug output as requested.
> >
> > Finally, I could reproduce with debugging on and keep the system alive long
> > enough to copy the kernel log. Attached are two examples of the BUG
> > happening with surrounding Ceph logs. Before and after these extracts are
> > some seconds without logging, so I assume they are complete.
> 
> Any news on this bug? Do you need more info? I would really like to go on 
> testing, but this bug is a show stopper for me.

Sorry, I dropped this one. Just added it to the tracker at
	http://tracker.newdream.net/issues/1667

There is enough in those logs to tell that there is a bad iput() 
somewhere.  In bug1, we create a new inode, link it to dn A, and shortly 
thereafter dn B sees it is also linked to it (incorrectly) and we iput().  
Presumably we reused an inode address that was still in use (and the same 
thing happens with the new inode right after that).

Can you capture a larger log segment?  The hope is to catch the first 
use-after-free, and not the subsequent side-effects.

Also, the below patch may help us parse the output with multiple threads.

Thanks!
sage


diff --git a/kernel/printk.c b/kernel/printk.c
index 28a40d8..9fcf993 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -929,9 +929,10 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 
                                t = cpu_clock(printk_cpu);
                                nanosec_rem = do_div(t, 1000000000);
-                               tlen = sprintf(tbuf, "[%5lu.%06lu] ",
+                               tlen = sprintf(tbuf, "[%5lu.%06lu %6lu] ",
                                                (unsigned long) t,
-                                               nanosec_rem / 1000);
+                                              nanosec_rem / 1000,
+                                              current->pid);
 
                                for (tp = tbuf; tp < tbuf + tlen; tp++)
                                        emit_log_char(*tp);



