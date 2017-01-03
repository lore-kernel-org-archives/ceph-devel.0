From: Casey Bodley <cbodley@redhat.com>
Subject: Re: ceph-ci.git and pull requests
Date: Tue, 3 Jan 2017 16:25:42 -0500
Message-ID: <0444043b-d29d-36da-f63e-8f91015e17f2@redhat.com>
References: <7ca73dab-23d4-6725-79d4-c3bac274dc3b@redhat.com>
 <CAN=+7FX9jb712_ddmx4GgPKQW47R-QhB4fqfZ6gmCWuU-EiW2A@mail.gmail.com>
 <CALqRxCznKbjq8x38NGO3=HQCR17a59iXvcq8HPvprNAJ_XyxHw@mail.gmail.com>
 <93a45df1-4c2d-1509-8533-e5d28396460a@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35786 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757679AbdACVZp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 16:25:45 -0500
Received: by mail-qk0-f178.google.com with SMTP id u25so377679179qki.2
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 13:25:44 -0800 (PST)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id c2sm44420522qkg.8.2017.01.03.13.25.42
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2017 13:25:43 -0800 (PST)
In-Reply-To: <93a45df1-4c2d-1509-8533-e5d28396460a@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Fair enough. In this case, I was going to push a backport to ceph-ci.git 
so that packages would be available when the backport team was ready to 
validate it. In other cases, it can be useful to target a PR against a 
public branch so that other devs with access can add fixes and continue 
testing.

Casey


On 01/03/2017 04:08 PM, Nathan Cutler wrote:
> Hi Casey:
>
> Here's what I do, which I think is essentially the same as Sam and Ken 
> are doing:
>
> git clone https://github.com/smithfarm/ceph
> git remote add ceph-ci https://github.com/ceph/ceph
> <prepare wip-foo branch>
> git push origin wip-foo
> <open PR>
> git push ceph-ci wip-foo
> <wait for http://shaman.ceph.com to build>
> <test in Sepia>
>
> HTH,
> Nathan

