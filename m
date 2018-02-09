From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Build failed in Jenkins: ceph-master #1762
Date: Fri, 9 Feb 2018 14:40:58 -0800
Message-ID: <CAJ4mKGbpTJWwwc1=JH_jvDxyQSyaW2BhQBR=TVo9pQEVKdrASA@mail.gmail.com>
References: <333349266.59.1518165404718.JavaMail.jenkins@cephdev.digiware.nl> <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:51081 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBIWk7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Feb 2018 17:40:59 -0500
Received: by mail-it0-f43.google.com with SMTP id x128so196294ite.0
        for <ceph-devel@vger.kernel.org>; Fri, 09 Feb 2018 14:40:59 -0800 (PST)
In-Reply-To: <36698607-d1d7-fe7d-c887-a7190b548791@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 9, 2018 at 12:54 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi Greg,
>
> Clang is rather picky on not initing foo and bar...
> Suggestion for fixing this?
<snip>

> /home/jenkins/workspace/ceph-master/src/test/fs/mds_types.cc:24:11: error:
> declaration of variable 'bar' with deduced type 'inode_t' requires an
> initializer
>   inode_t bar;

I don't really get what it's asking for. It's talking about "deduced"
types, but this code isn't relying on "auto" and indeed the line clang
points to is declaring the type explicitly. And inode_t has a single
constructor that doesn't take any parameters. Googling is not leading
me to anything helpful either. I get the idea maybe the environment
isn't configured quite right, but I'm not sure how...
You could try sticking some parens in and see if that changes
anything, but random mutations like that are the only thing I can come
up with. :/
-Greg
