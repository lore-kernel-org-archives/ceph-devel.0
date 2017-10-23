From: Casey Bodley <cbodley@redhat.com>
Subject: fun with seastar
Date: Mon, 23 Oct 2017 16:17:19 -0400
Message-ID: <91a5fd79-ff50-53f7-d187-97d024cee8ba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:54705 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdJWURV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Oct 2017 16:17:21 -0400
Received: by mail-oi0-f44.google.com with SMTP id a132so33013082oih.11
        for <ceph-devel@vger.kernel.org>; Mon, 23 Oct 2017 13:17:21 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id b44sm2553206otb.36.2017.10.23.13.17.20
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Oct 2017 13:17:20 -0700 (PDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi folks,

I mentioned in last week's perf call that I've been experimenting with 
the Seastar library [1] to see how well it can integrate with the ceph 
codebase. So far I've managed to add bufferlist conversions to/from the 
seastar buffer types, and build up a seastar messenger that can 
send/receive ceph Messages. The branch [2] includes a simple echo server 
unit test and a README with build instructions.

This follows some prototype work a couple years ago by Adam Emerson and 
myself, dubbed Project Crimson [3], to evaluate Seastar as the basis for 
a low-latency OSD. Interesting parts of this project include a Cap'n 
Proto-based messenger and an async ObjectStore interface with Memstore 
implementation.

-Casey

[1] https://github.com/scylladb/seastar
[2] https://github.com/cbodley/ceph/commits/wip-seastar-msg
[3] https://github.com/cohortfsllc/crimson
