From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Build failed in Jenkins: ceph-master #1762
Date: Fri, 9 Feb 2018 15:22:04 -0800
Message-ID: <CA+2bHPbmztw1jg8e33Wwo+N7_1PKyNke_7o7eNJKqBZEJpOfag@mail.gmail.com>
References: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl>
 <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl> <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:45676 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeBIXWf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Feb 2018 18:22:35 -0500
Received: by mail-qk0-f176.google.com with SMTP id x127so12038583qkb.12
        for <ceph-devel@vger.kernel.org>; Fri, 09 Feb 2018 15:22:35 -0800 (PST)
In-Reply-To: <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 9, 2018 at 2:40 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Fri, Feb 9, 2018 at 12:54 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi Greg,
>>
>> Clang is rather picky on not initing foo and bar...
>> Suggestion for fixing this?
> <snip>
>
>> /home/jenkins/workspace/ceph-master/src/test/fs/mds_types.cc:24:11: error:
>> declaration of variable 'bar' with deduced type 'inode_t' requires an
>> initializer
>>   inode_t bar;
>
> I don't really get what it's asking for. It's talking about "deduced"
> types, but this code isn't relying on "auto" and indeed the line clang
> points to is declaring the type explicitly. And inode_t has a single
> constructor that doesn't take any parameters. Googling is not leading
> me to anything helpful either. I get the idea maybe the environment
> isn't configured quite right, but I'm not sure how...
> You could try sticking some parens in and see if that changes
> anything, but random mutations like that are the only thing I can come
> up with. :/

Perhaps it is deduced because inode_t is now templated and has a
default template argument?

Also, wouldn't "inode_t bar()" be more appropriate than "inode_t
bar{}"? Or does the former not work?

-- 
Patrick Donnelly
