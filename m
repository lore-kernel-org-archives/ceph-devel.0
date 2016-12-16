From: Igor Fedotov <ifedotov@mirantis.com>
Subject: BlueStore in-memory Onode footprint
Date: Fri, 16 Dec 2016 18:04:51 +0300
Message-ID: <34ee2613-8db3-646e-4470-b3e8fa8855e0@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35686 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757475AbcLPPPG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 10:15:06 -0500
Received: by mail-yw0-f173.google.com with SMTP id i145so32831579ywg.2
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 07:15:05 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id h14sm2371548ywa.9.2016.12.16.07.04.52
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Dec 2016 07:04:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hey All!

Recently I realized that I'm unable to fit all my onodes ( 32768 
objects/4Mb each/4K alloc unit/no csum) in 15G RAM cache.

Hence decided to estimate Onode in-memory size.

At first I filled 4Mb object with a single 4M write - mempools indicate 
~5K mem usage for total onode metadata. Good enough.

Secondly I refill that object with 4K writes. Resulting memusage = 
574K!!! Onode itself 704 bytes in 1 object.  And 4120 other metadata 
items occupies all other space.

Then I removed SharedBlob from mempools. Resulting mem usage = 355K. The 
same Onode size. And 3096 other metadata objects. Hence we had 1024 
SharedBlob instances thata took ~ 220K.


And finally I removed Blob instances from measurements. Resulting mem 
usage = 99K. And 2072 other objects. Hence Blob instances take another ~250K

Yeah, that's the worst case( actually csum enable will give even more 
mem use) but shouldn't we revisit some Onode internals due to such numbers?


Thanks,

Igor


