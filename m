From: Willem Jan Withagen <wjw@digiware.nl>
Subject: shuffle_random removed in C++17 on FreeBSD/Clang??
Date: Tue, 9 Jan 2018 11:10:39 +0100
Message-ID: <478f46a2-3cd9-ab94-6437-8f6de05f2c25@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:65078 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbeAIKKl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 9 Jan 2018 05:10:41 -0500
Received: from [192.168.11.152] (unknown [192.168.11.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id A76AD2EBDC
        for <ceph-devel@vger.kernel.org>; Tue,  9 Jan 2018 11:10:39 +0100 (CET)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

As a consequence of the move to C++17 I'm running into this problem.

--WjW

I'm getting this error:
/home/jenkins/workspace/ceph-master/src/osd/ReplicatedBackend.cc:1369:8: 
error: no member named 'random_shuffle' in namespace 'std'
   std::random_shuffle(shuffle.begin(), shuffle.end());
   ~~~~~^
1 error generated.

And the includefile tells me:
template <class RandomAccessIterator>
     void
     random_shuffle(RandomAccessIterator first, RandomAccessIterator 
last); // deprecated in C++14, removed in C++17
