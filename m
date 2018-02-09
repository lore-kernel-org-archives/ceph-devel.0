From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Build failed in Jenkins: ceph-master #1762
Date: Fri, 9 Feb 2018 15:56:17 -0800
Message-ID: <CA+2bHPbDUo=5Xhga0DEAjhd5YAOc8R2sU-Nn87tM3i1EYe9V2g@mail.gmail.com>
References: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl>
 <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl> <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
 <CA+2bHPbmztw1jg8e33Wwo+N7_1PKyNke_7o7eNJKqBZEJpOfag@mail.gmail.com> <20180209235223.GA8943@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41432 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBIX4s (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Feb 2018 18:56:48 -0500
Received: by mail-qt0-f196.google.com with SMTP id a9so6088827qtj.8
        for <ceph-devel@vger.kernel.org>; Fri, 09 Feb 2018 15:56:48 -0800 (PST)
In-Reply-To: <20180209235223.GA8943@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 9, 2018 at 3:52 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
>> Also, wouldn't "inode_t bar()" be more appropriate than "inode_t
>> bar{}"? Or does the former not work?
>
> inode_t bar() runs into The Most Vexing Parse:
>
> https://en.wikipedia.org/wiki/Most_vexing_parse

Ah, I've seen and been confused by that before. Thanks for the link!

-- 
Patrick Donnelly
