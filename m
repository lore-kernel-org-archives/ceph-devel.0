From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph/rbd benchmarks
Date: Wed, 24 Aug 2011 09:36:02 -0700
Message-ID: <CAF3hT9BdUqoCzSEYYWfa0dckVOzDgKVP2s3zyGK5EeAqNR8AFA@mail.gmail.com>
References: <CALFpzo5NuPHxqtj0qtP7mafy5TG2BTSo-2=Y+jCPsy5xUm42PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46492 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab1HXQgF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2011 12:36:05 -0400
Received: by ywf7 with SMTP id 7so994732ywf.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2011 09:36:03 -0700 (PDT)
In-Reply-To: <CALFpzo5NuPHxqtj0qtP7mafy5TG2BTSo-2=Y+jCPsy5xUm42PQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 24, 2011 at 8:29 AM, Marcus Sorensen <shadowsor@gmail.com> wrote:
> Just thought I'd share this basic testing I did, comparing cephfs 0.32
> on 3.1-rc1 to nfs as well as rbd to iscsi. I'm sure you guys see a lot
> of this. Any feedback would be appreciated.
>
> The data is here:
>
> http://learnitwithme.com/wp-content/uploads/2011/08/ceph-nfs-iscsi-benchmarks.ods
>
> and the writeup is here:
>
> http://learnitwithme.com/?p=303

We see less of it than you'd think, actually. Thanks!

To address a few things specifically
Ceph is both the name of the project and of the POSIX-compliant
filesystem. RADOS stands for Reliable Autonomous Distributed Object
Store. Apparently we should publish this a bit more. :)

Looks like most of the differences in your tests have to do with our
relatively lousy read performance -- this is probably due to lousy
readahead, which nobody's spent a lot of time optimizing as we focus
on stability. Sage made some improvements a few weeks ago but I don't
remember what version of stuff they ended up in. :) (Optimizing
cross-server reads is hard!)
