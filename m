From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Ceph-deploy for FreeBSD
Date: Fri, 14 Apr 2017 22:44:21 +0200
Message-ID: <76dc3a7e-80bb-6c9d-d502-535258ce0b54@digiware.nl>
References: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:60326 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbdDNUoY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Apr 2017 16:44:24 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 841BA1D936
        for <ceph-devel@vger.kernel.org>; Fri, 14 Apr 2017 22:44:21 +0200 (CEST)
In-Reply-To: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Having solved the first few step in ceph-deploy, I can now get to the
point where it actually wants to start the first monitor.
Like:
    /usr/local/bin/ceph-deploy mon create-initial

And if I look at the other platform booting the inital monitor is
started thru the init|systemd|upstart....

However under FreeBSD bsdrc I require atleast in ceph.conf
[mon]
    host = cephtest

This is not the case on the other platforms?

And how would I otherwise get this into the ceph.conf?

--WjW

