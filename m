From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Build failed in Jenkins: ceph-master #1762
Date: Fri, 9 Feb 2018 18:52:24 -0500
Message-ID: <20180209235223.GA8943@ultraspiritum.eng.arb.redhat.com>
References: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl>
 <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl>
 <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
 <CA+2bHPbmztw1jg8e33Wwo+N7_1PKyNke_7o7eNJKqBZEJpOfag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753073AbeBIXwZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:52:25 -0500
Content-Disposition: inline
In-Reply-To: <CA+2bHPbmztw1jg8e33Wwo+N7_1PKyNke_7o7eNJKqBZEJpOfag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On 09/02/2018, Patrick Donnelly wrote:
> Perhaps it is deduced because inode_t is now templated and has a
> default template argument?

Yes! Pre C++17 we would have had to use inode_t<> everywhere. Now G++
and Clang are both doing class template argument deduction, but Clang
is doing it /slightly wrong/.

> Also, wouldn't "inode_t bar()" be more appropriate than "inode_t
> bar{}"? Or does the former not work?

inode_t bar() runs into The Most Vexing Parse:

https://en.wikipedia.org/wiki/Most_vexing_parse

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@OFTC, Actinic@Freenode
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
