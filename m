From: Marcus Sorensen <shadowsor@gmail.com>
Subject: cmds,cmon,cosd 100% cpu
Date: Wed, 27 Jul 2011 08:56:34 -0600
Message-ID: <CALFpzo5s1DCSkjGsbn5eN0SGR-GKZU3rZkWawcnQUHNj1Vs5iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43242 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab1G0O4f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 10:56:35 -0400
Received: by wyg8 with SMTP id 8so1040881wyg.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 07:56:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I feel like this is probably something I should be able to find info
on in an existing faq or archive, but I haven't been able to find
anything. Are these daemons supposed to use a whole core 24x7? The
setup *seems* to be functioning normally in initial testing

PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Flags
WCHAN     COMMAND
 4576 root      20   0  580m 468m 4528 S 100.0  2.9   1259:56 ..4.214.
futex_wai cmds
 4480 root      20   0  138m  39m 2904 S 100.1  0.2   1259:39 ..4.214.
futex_wai cmon

PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  WCHAN
Flags    COMMAND
 2540 root      20   0 1140m 861m 3656 S 100.0  2.7   1269:59
futex_wai ..4.214. cosd

As you can see almost all of the time is spent in futex wait, strace
reveals a billion polling events on one of the threads (on each of
cmds,cmon,cosd), e.g:

[pid  4583] poll([{fd=7, events=POLLIN|POLLRDBAND}, {fd=5,
events=POLLIN|POLLRDBAND}], 2, 0) = 0 (Timeout)
