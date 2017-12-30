From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Moving to Boost 1.66 on FreeBSD
Date: Sat, 30 Dec 2017 01:47:09 +0100
Message-ID: <17cd45dd-8540-ae51-b042-70df9ab32f3f@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:18715 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbdL3ArJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 29 Dec 2017 19:47:09 -0500
Received: from [192.168.11.152] (unknown [192.168.11.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 91D942E44C
        for <ceph-devel@vger.kernel.org>; Sat, 30 Dec 2017 01:47:07 +0100 (CET)
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

I know that we are going to phase out the old Beast lib, and go for the 
Beast implementation that is in 1.66... Or at least that is what I seem 
te remember from some messages on the list that I responded too.

Now FreeBSD is running tests to see what ports will not build when the 
default is upped to 1.66, and needless to say is that my v12.2.{0,1,2} 
ceph port fails. :(

So how far are we in this process?

And how big would the breakage be if v12.2.x would be build against a 1.66?
First errors while building are about Boost::asio.

--WjW
