From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Build failed in Jenkins: ceph-master #1762
Date: Fri, 9 Feb 2018 14:43:09 -0800
Message-ID: <CAJ4mKGYdiuQKSEvFbcwtVict7y5amaS1OBy9rNKVGfeFv5b0eQ@mail.gmail.com>
References: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl>
 <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl> <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:42897 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeBIWnL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Feb 2018 17:43:11 -0500
Received: by mail-io0-f174.google.com with SMTP id g14so5148384iob.9
        for <ceph-devel@vger.kernel.org>; Fri, 09 Feb 2018 14:43:11 -0800 (PST)
In-Reply-To: <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Oh, I see now that Adam did this: https://github.com/ceph/ceph/pull/20392

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
> -Greg
