From: Sugang Li <sugangli@winlab.rutgers.edu>
Subject: Re: running ceph cluster (built from source) from multiple machines
Date: Sat, 25 Feb 2017 19:13:54 -0500
Message-ID: <CAG0LszmU+H9YJPkB12qA30K2qF37z4obPp2Td46-yBrraHtCxQ@mail.gmail.com>
References: <CAG0LsznANAmgEZJxQv+Gw6Vj=Fyzy-i0-eVCozYkN4UWfviagQ@mail.gmail.com>
 <CA+2bHPZWp9LmPcJd2gZ7X1Vt5RvGUgz0=T3WBk03QTnTSOLxzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36476 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdBZAN4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Feb 2017 19:13:56 -0500
Received: by mail-wr0-f177.google.com with SMTP id u108so1767909wrb.3
        for <ceph-devel@vger.kernel.org>; Sat, 25 Feb 2017 16:13:55 -0800 (PST)
In-Reply-To: <CA+2bHPZWp9LmPcJd2gZ7X1Vt5RvGUgz0=T3WBk03QTnTSOLxzA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks Patrick!  I will give it a try.

Sugang

On Fri, Feb 24, 2017 at 2:16 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> Hello Sugang,
>
> On Fri, Feb 24, 2017 at 10:24 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
>> Recently I modified the source code a little bit and I am trying to test
>> its benchmark performance on multiple machines (one VM for client, one VM
>> for mon, three VMs for OSDs). I realized that vstart.sh script seems only
>> runs cluster on the local machine, so I am wondering is there a way I can
>> do it on multiple ones, which is similar to ceph-deploy?
>
> The recommended way to deploy ceph to a cluster is by using
> ceph-ansible: https://github.com/ceph/ceph-ansible
>
> You may also find it helpful to look at a script I use to start and
> configure Linode VMs for testing Ceph:
>
> https://github.com/batrick/ceph-ansible/blob/95c72ec6880d95063c87060cf2c895f0c11bcc4a/test.sh
>
> --
> Patrick Donnelly
