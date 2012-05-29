From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 23:08:20 +0200
Message-ID: <4FC53AC4.5020600@profihost.ag>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr> <4FC4E0A9.8010008@profihost.ag> <4FC50C4A.4090101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59320 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab2E2VIW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 17:08:22 -0400
In-Reply-To: <4FC50C4A.4090101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Yann Dupont <Yann.Dupont@univ-nantes.fr>, ceph-devel@vger.kernel.org

Am 29.05.2012 19:50, schrieb Mark Nelson:
> I did some quick tests on a couple of nodes I had laying around this
> morning.

I just noticed that i get a constant rate of 40MB/s while using 1 
thread. When i use two thread or more i get drop to 0MB/s and crazy 
jumping values.

~# rados -p rbd bench 90 write -t 1
Maintaining 1 concurrent writes of 4194304 bytes for at least 90 seconds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
     1       1        10         9    35.994        36  0.100147  0.101133
     2       1        20        19   37.9931        40  0.096893  0.100719
     3       1        31        30   39.9921        44   0.09784 0.0999607
     4       1        41        40   39.9929        40  0.099156 0.0999003
     5       1        51        50   39.9932        40  0.098239 0.0996518
     6       1        61        60   39.9932        40  0.098682 0.0994851
     7       1        71        70   39.9933        40  0.094397  0.099184
     8       1        81        80   39.9931        40  0.099823 0.0993327
     9       1        91        90   39.9931        40  0.101013 0.0992236
    10       1       101       100    39.993        40  0.098277  0.099237



# rados -p rbd bench 90 write -t 2
Maintaining 2 concurrent writes of 4194304 bytes for at least 90 seconds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
     1       2        15        13   51.9888        52    0.0956  0.115315
     2       2        22        20   39.9928        28  0.120065  0.193125
     3       2        41        39   51.9917        76   0.09557   0.15246
     4       2        58        56   55.9912        68   0.09875  0.137688
     5       2        67        65    51.992        36  0.111211  0.139465
     6       2        85        83   55.3251        72  0.136967  0.143079
     7       2       101        99   56.5625        64  0.098664  0.136263
     8       2       101        99   49.4919         0         -  0.136263
     9       2       112       110   48.8808        22  0.099479  0.160563

Stefan
