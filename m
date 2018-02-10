From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Build failed in Jenkins: ceph-master #1762
Date: Fri, 9 Feb 2018 16:58:09 -0800
Message-ID: <CAJ4mKGaYu7=ba5s99xRp8rFV6DTWkw1H1c_HT6GkDgv-QCpQBg@mail.gmail.com>
References: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl>
 <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl> <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
 <CA+2bHPbmztw1jg8e33Wwo+N7_1PKyNke_7o7eNJKqBZEJpOfag@mail.gmail.com> <20180209235223.GA8943@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:36455 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbeBJA6K (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Feb 2018 19:58:10 -0500
Received: by mail-it0-f44.google.com with SMTP id n206so467877itg.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Feb 2018 16:58:10 -0800 (PST)
In-Reply-To: <20180209235223.GA8943@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 9, 2018 at 3:52 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 09/02/2018, Patrick Donnelly wrote:
>> Perhaps it is deduced because inode_t is now templated and has a
>> default template argument?
>
> Yes! Pre C++17 we would have had to use inode_t<> everywhere. Now G++
> and Clang are both doing class template argument deduction, but Clang
> is doing it /slightly wrong/.

Ah, I missed this change. Thanks guys!

>
>> Also, wouldn't "inode_t bar()" be more appropriate than "inode_t
>> bar{}"? Or does the former not work?
>
> inode_t bar() runs into The Most Vexing Parse:
>
> https://en.wikipedia.org/wiki/Most_vexing_parse
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@OFTC, Actinic@Freenode
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
