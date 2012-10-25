From: jie sun <0maidou0@gmail.com>
Subject: mon can't start
Date: Thu, 25 Oct 2012 10:21:52 +0800
Message-ID: <CAB6Jr7RvqcPC8bY6F0A5abse1vd2CoRHjBKfabCyaG+SfiDkAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52029 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759122Ab2JYCVx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 22:21:53 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1142476oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 19:21:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

My ceph file system consists of 1 mon, 1 mds and 2 osds, and 1 mon
1mds 1 osd on the same machine(called machine a).

Yesterday, I have to change the IP of mon(because the environment our
machine room changed), I wonder if there is any way to do this without
stop cephfs and deploy it again( the data before will disappear).

My solution is add 2 new mons so that there are 3 mons, then remove 2
mons, and only stay the mon I want to use.
But without enough machines, I add 1 internal IP for the machine a and
then do as "http://ceph.com/docs/master/cluster-ops/add-or-rm-mons/#adding-a-monitor-manual"
says.
I don't understand the 6th step "ceph mon add <name> <ip>[:<port>]\n";
", so I execute "ceph mon add mon.b 192.168.66.146:6790", after this
my mon goes down.
If a start mon with "/etc/ceph/init.d/ceph -a start mon.a", the log is:
"
terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'
  what():  buffer::end_of_buffer
*** Caught signal (Aborted) **
 in thread 7f14069e1760
 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
 1: /usr/local/bin/ceph-mon() [0x55f7a9]
 2: (()+0xf2d0) [0x7f14065d92d0]
 3: (gsignal()+0x35) [0x7f1404fe3ab5]
 4: (abort()+0x186) [0x7f1404fe4fb6]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f1405849a9d]
 6: (()+0xbccb6) [0x7f1405847cb6]
 7: (()+0xbcce3) [0x7f1405847ce3]
 8: (()+0xbcdee) [0x7f1405847dee]
 9: /usr/local/bin/ceph-mon() [0x5fa8af]
 10: (main()+0x1f19) [0x485069]
 11: (__libc_start_main()+0xfd) [0x7f1404fcfbfd]
 12: /usr/local/bin/ceph-mon() [0x482f99]
2012-10-25 18:02:03.725089 7f14069e1760 -1 *** Caught signal (Aborted) **
 in thread 7f14069e1760

 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
 1: /usr/local/bin/ceph-mon() [0x55f7a9]
 2: (()+0xf2d0) [0x7f14065d92d0]
 3: (gsignal()+0x35) [0x7f1404fe3ab5]
 4: (abort()+0x186) [0x7f1404fe4fb6]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f1405849a9d]
 6: (()+0xbccb6) [0x7f1405847cb6]
 7: (()+0xbcce3) [0x7f1405847ce3]
 8: (()+0xbcdee) [0x7f1405847dee]
 9: /usr/local/bin/ceph-mon() [0x5fa8af]
 10: (main()+0x1f19) [0x485069]
 11: (__libc_start_main()+0xfd) [0x7f1404fcfbfd]
 12: /usr/local/bin/ceph-mon() [0x482f99]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

     0> 2012-10-25 18:02:03.725089 7f14069e1760 -1 *** Caught signal
(Aborted) **
 in thread 7f14069e1760

 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
 1: /usr/local/bin/ceph-mon() [0x55f7a9]
 2: (()+0xf2d0) [0x7f14065d92d0]
 3: (gsignal()+0x35) [0x7f1404fe3ab5]
 4: (abort()+0x186) [0x7f1404fe4fb6]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f1405849a9d]
 6: (()+0xbccb6) [0x7f1405847cb6]
 7: (()+0xbcce3) [0x7f1405847ce3]
 8: (()+0xbcdee) [0x7f1405847dee]
 9: /usr/local/bin/ceph-mon() [0x5fa8af]
 10: (main()+0x1f19) [0x485069]
 11: (__libc_start_main()+0xfd) [0x7f1404fcfbfd]
 12: /usr/local/bin/ceph-mon() [0x482f99]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

bash: line 1: 31426 Aborted                 (core dumped)
/usr/local/bin/ceph-mon -i a --pid-file /var/run/ceph/mon.a.pid -c
/tmp/ceph.conf.16468
failed: 'ssh osd01  /usr/local/bin/ceph-mon -i a --pid-file
/var/run/ceph/mon.a.pid -c /tmp/ceph.conf.16468 '
"

Now I don't know how to do with this situation.

Thank you!
