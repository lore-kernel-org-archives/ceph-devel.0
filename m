From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Build failed in Jenkins: ceph-master #1762
Date: Sat, 10 Feb 2018 12:55:25 +0100
Message-ID: <ca253fea-b6e8-4fe1-a929-5641b3111790@digiware.nl>
References: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl>
 <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl>
 <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
 <CA+2bHPbmztw1jg8e33Wwo+N7_1PKyNke_7o7eNJKqBZEJpOfag@mail.gmail.com>
 <20180209235223.GA8943@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:45946 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeBJLza (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 10 Feb 2018 06:55:30 -0500
In-Reply-To: <20180209235223.GA8943@ultraspiritum.eng.arb.redhat.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 10-2-2018 00:52, Adam C. Emerson wrote:
> On 09/02/2018, Patrick Donnelly wrote:
>> Perhaps it is deduced because inode_t is now templated and has a
>> default template argument?
> 
> Yes! Pre C++17 we would have had to use inode_t<> everywhere. Now G++
> and Clang are both doing class template argument deduction, but Clang
> is doing it /slightly wrong/.

That would warrant a bug-report, but I'm not all to good into C++ let 
alone the subtile diffs with all new features.
And it looks like it is a known issue in Clang:
https://clang.llvm.org/cxx_dr_status.html, issue 271.

The auto building for Jenkins returned back to normal thru the night.
So I'll have to see what things of the local patches are needed.
But my guess is that HEAD just builds.

--WjW
