From: Sage Weil <sage@inktank.com>
Subject: Re: monitor not starting
Date: Tue, 24 Jul 2012 16:55:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207241653540.20649@cobra.newdream.net>
References: <4FF42CD7.1060000@smart-weblications.de> <D2569975C9B14D6B974C162C58FA7401@inktank.com> <4FF47717.1030401@smart-weblications.de> <9A431747660F45EB8122D5A66F0DEF1A@inktank.com> <500EBBE2.5070406@smart-weblications.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40503 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932625Ab2GXXz3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 19:55:29 -0400
In-Reply-To: <500EBBE2.5070406@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Smart Weblications GmbH - Florian Wiessner <f.wiessner@smart-weblications.de>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Tue, 24 Jul 2012, Smart Weblications GmbH - Florian Wiessner wrote:
> --- end dump of recent events ---
> 2012-07-24 17:03:22.791401 7fd3045af780  1 mon.1@-1(probing) e1 init fsid
> 4553d0f6-1b31-4ba5-9d97-edae55bcaab4
> 2012-07-24 17:03:22.791890 7fd3045af780 -1 mon/Paxos.cc: In function 'bool
> Paxos::is_consistent()' thread 7fd3045af780 time 2012-07-24 17:03:22.791528
> mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping == 1))

Was this monitor previously starting with 0.48?  This looks a lot like 
older bugs that were fixed before then.

If you can attach a tarball of the mon data directory and send it to me 
directly (off-list :), I can find out exactly what is inconsistent.

Thanks!
sage


> 
>  ceph version 0.48argonaut-125-g4e774fb
> (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
>  1: /usr/bin/ceph-mon() [0x497317]
>  2: (Monitor::init()+0xc5a) [0x4857fa]
>  3: (main()+0x2789) [0x46ac79]
>  4: (__libc_start_main()+0xfd) [0x7fd302967c8d]
>  5: /usr/bin/ceph-mon() [0x468309]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
> 
> 
> Well, again my cluster rebootet and now only 1 of 4 monitors is willing to start...
> 
>  ceph version 0.48argonaut-125-g4e774fb
> (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
>  1: /usr/bin/ceph-mon() [0x497317]
>  2: (Monitor::init()+0xc5a) [0x4857fa]
>  3: (main()+0x2789) [0x46ac79]
>  4: (__libc_start_main()+0xfd) [0x7fd302967c8d]
>  5: /usr/bin/ceph-mon() [0x468309]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
> 
> --- begin dump of recent events ---
>     -3> 2012-07-24 17:03:22.729549 7fd3045af780  1 store(/data/ceph/mon) mount
>     -2> 2012-07-24 17:03:22.729667 7fd3045af780  0 ceph version
> 0.48argonaut-125-g4e774fb (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8),
> process ceph-mon, pid 6962
>     -1> 2012-07-24 17:03:22.791401 7fd3045af780  1 mon.1@-1(probing) e1 init
> fsid 4553d0f6-1b31-4ba5-9d97-edae55bcaab4
>      0> 2012-07-24 17:03:22.791890 7fd3045af780 -1 mon/Paxos.cc: In function
> 'bool Paxos::is_consistent()' thread 7fd3045af780 time 2012-07-24 17:03:22.791528
> mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping == 1))
> 
> 
> --- end dump of recent events ---
> 2012-07-24 17:03:22.792461 7fd3045af780 -1 *** Caught signal (Aborted) **
>  in thread 7fd3045af780
> 
>  ceph version 0.48argonaut-125-g4e774fb
> (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
>  1: /usr/bin/ceph-mon() [0x52f9c9]
>  2: (()+0xeff0) [0x7fd304198ff0]
>  3: (gsignal()+0x35) [0x7fd30297b1b5]
>  4: (abort()+0x180) [0x7fd30297dfc0]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fd30320fdc5]
>  6: (()+0xcb166) [0x7fd30320e166]
>  7: (()+0xcb193) [0x7fd30320e193]
>  8: (()+0xcb28e) [0x7fd30320e28e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x940)
> [0x55b310]
>  10: /usr/bin/ceph-mon() [0x497317]
>  11: (Monitor::init()+0xc5a) [0x4857fa]
>  12: (main()+0x2789) [0x46ac79]
>  13: (__libc_start_main()+0xfd) [0x7fd302967c8d]
>  14: /usr/bin/ceph-mon() [0x468309]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
> 
> --- begin dump of recent events ---
>      0> 2012-07-24 17:03:22.792461 7fd3045af780 -1 *** Caught signal (Aborted) **
>  in thread 7fd3045af780
> 
>  ceph version 0.48argonaut-125-g4e774fb
> (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
>  1: /usr/bin/ceph-mon() [0x52f9c9]
>  2: (()+0xeff0) [0x7fd304198ff0]
>  3: (gsignal()+0x35) [0x7fd30297b1b5]
>  4: (abort()+0x180) [0x7fd30297dfc0]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fd30320fdc5]
>  6: (()+0xcb166) [0x7fd30320e166]
>  7: (()+0xcb193) [0x7fd30320e193]
>  8: (()+0xcb28e) [0x7fd30320e28e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x940)
> [0x55b310]
>  10: /usr/bin/ceph-mon() [0x497317]
>  11: (Monitor::init()+0xc5a) [0x4857fa]
>  12: (main()+0x2789) [0x46ac79]
>  13: (__libc_start_main()+0xfd) [0x7fd302967c8d]
>  14: /usr/bin/ceph-mon() [0x468309]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
> 
> --- end dump of recent events ---
> 
> 
> 
> How can i fix this or prevent this from happening?
> 
> -- 
> 
> Mit freundlichen Gr??en,
> 
> Florian Wiessner
> 
> Smart Weblications GmbH
> Martinsberger Str. 1
> D-95119 Naila
> 
> fon.: +49 9282 9638 200
> fax.: +49 9282 9638 205
> 24/7: +49 900 144 000 00 - 0,99 EUR/Min*
> http://www.smart-weblications.de
> 
> --
> Sitz der Gesellschaft: Naila
> Gesch?ftsf?hrer: Florian Wiessner
> HRB-Nr.: HRB 3840 Amtsgericht Hof
> *aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
