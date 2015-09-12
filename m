From: Mike Almateia <mike.almateia@gmail.com>
Subject: Question about big EC pool.
Date: Sat, 12 Sep 2015 19:01:01 +0300
Message-ID: <55F44C3D.4070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:36751 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbbILQBI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Sep 2015 12:01:08 -0400
Received: by lanb10 with SMTP id b10so63792998lan.3
        for <ceph-devel@vger.kernel.org>; Sat, 12 Sep 2015 09:01:06 -0700 (PDT)
Received: from [192.168.43.78] ([213.87.146.252])
        by smtp.gmail.com with ESMTPSA id an1sm888627lac.43.2015.09.12.09.01.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 09:01:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello!

Ceph have EC pool feature a long time and I thinking how much big EC 
pool can we made and support.

I have task from our a client to make a storage around 5Pb userful space 
for storing video from cams (I ask in ceph-user maillist but nobody 
answer me.)

Ceph by now can handle that huge EC storage or not? May be someone 
testing or useing in prodaction huge EC pools?
I heard, that EC feature not ready for production, it's right?

Thanks for any answer.

--
Mike, yes.
