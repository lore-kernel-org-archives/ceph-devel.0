From: Gregory Farnum <greg@inktank.com>
Subject: Re: mon can't start
Date: Thu, 15 Nov 2012 13:10:51 -0800
Message-ID: <CAPYLRzgFNJmGzqoRWW7g_p9Wk0bWVuO3euFjaOo7z6t9TGppRQ@mail.gmail.com>
References: <CAB6Jr7RvqcPC8bY6F0A5abse1vd2CoRHjBKfabCyaG+SfiDkAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47250 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab2KOVlJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 16:41:09 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so2680923iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 13:41:09 -0800 (PST)
In-Reply-To: <CAB6Jr7RvqcPC8bY6F0A5abse1vd2CoRHjBKfabCyaG+SfiDkAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jie sun <0maidou0@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sorry we missed this =97 everybody's been very busy!
If you're still having trouble, can you install the ceph debug symbol
packages and get this again? The backtrace isn't very helpful without
that, unfortunately.
-Greg

On Wed, Oct 24, 2012 at 7:21 PM, jie sun <0maidou0@gmail.com> wrote:
> Hi,
>
> My ceph file system consists of 1 mon, 1 mds and 2 osds, and 1 mon
> 1mds 1 osd on the same machine(called machine a).
>
> Yesterday, I have to change the IP of mon(because the environment our
> machine room changed), I wonder if there is any way to do this withou=
t
> stop cephfs and deploy it again( the data before will disappear).
>
> My solution is add 2 new mons so that there are 3 mons, then remove 2
> mons, and only stay the mon I want to use.
> But without enough machines, I add 1 internal IP for the machine a an=
d
> then do as "http://ceph.com/docs/master/cluster-ops/add-or-rm-mons/#a=
dding-a-monitor-manual"
> says.
> I don't understand the 6th step "ceph mon add <name> <ip>[:<port>]\n"=
;
> ", so I execute "ceph mon add mon.b 192.168.66.146:6790", after this
> my mon goes down.
> If a start mon with "/etc/ceph/init.d/ceph -a start mon.a", the log i=
s:
> "
> terminate called after throwing an instance of 'ceph::buffer::end_of_=
buffer'
>   what():  buffer::end_of_buffer
> *** Caught signal (Aborted) **
>  in thread 7f14069e1760
>  ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2=
bf2030)
>  1: /usr/local/bin/ceph-mon() [0x55f7a9]
>  2: (()+0xf2d0) [0x7f14065d92d0]
>  3: (gsignal()+0x35) [0x7f1404fe3ab5]
>  4: (abort()+0x186) [0x7f1404fe4fb6]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f1405849a9d]
>  6: (()+0xbccb6) [0x7f1405847cb6]
>  7: (()+0xbcce3) [0x7f1405847ce3]
>  8: (()+0xbcdee) [0x7f1405847dee]
>  9: /usr/local/bin/ceph-mon() [0x5fa8af]
>  10: (main()+0x1f19) [0x485069]
>  11: (__libc_start_main()+0xfd) [0x7f1404fcfbfd]
>  12: /usr/local/bin/ceph-mon() [0x482f99]
> 2012-10-25 18:02:03.725089 7f14069e1760 -1 *** Caught signal (Aborted=
) **
>  in thread 7f14069e1760
>
>  ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2=
bf2030)
>  1: /usr/local/bin/ceph-mon() [0x55f7a9]
>  2: (()+0xf2d0) [0x7f14065d92d0]
>  3: (gsignal()+0x35) [0x7f1404fe3ab5]
>  4: (abort()+0x186) [0x7f1404fe4fb6]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f1405849a9d]
>  6: (()+0xbccb6) [0x7f1405847cb6]
>  7: (()+0xbcce3) [0x7f1405847ce3]
>  8: (()+0xbcdee) [0x7f1405847dee]
>  9: /usr/local/bin/ceph-mon() [0x5fa8af]
>  10: (main()+0x1f19) [0x485069]
>  11: (__libc_start_main()+0xfd) [0x7f1404fcfbfd]
>  12: /usr/local/bin/ceph-mon() [0x482f99]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
>      0> 2012-10-25 18:02:03.725089 7f14069e1760 -1 *** Caught signal
> (Aborted) **
>  in thread 7f14069e1760
>
>  ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2=
bf2030)
>  1: /usr/local/bin/ceph-mon() [0x55f7a9]
>  2: (()+0xf2d0) [0x7f14065d92d0]
>  3: (gsignal()+0x35) [0x7f1404fe3ab5]
>  4: (abort()+0x186) [0x7f1404fe4fb6]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f1405849a9d]
>  6: (()+0xbccb6) [0x7f1405847cb6]
>  7: (()+0xbcce3) [0x7f1405847ce3]
>  8: (()+0xbcdee) [0x7f1405847dee]
>  9: /usr/local/bin/ceph-mon() [0x5fa8af]
>  10: (main()+0x1f19) [0x485069]
>  11: (__libc_start_main()+0xfd) [0x7f1404fcfbfd]
>  12: /usr/local/bin/ceph-mon() [0x482f99]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> bash: line 1: 31426 Aborted                 (core dumped)
> /usr/local/bin/ceph-mon -i a --pid-file /var/run/ceph/mon.a.pid -c
> /tmp/ceph.conf.16468
> failed: 'ssh osd01  /usr/local/bin/ceph-mon -i a --pid-file
> /var/run/ceph/mon.a.pid -c /tmp/ceph.conf.16468 '
> "
>
> Now I don't know how to do with this situation.
>
> Thank you!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
