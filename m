From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: Before deploying a rados cluster, three questions
Date: Wed, 3 Aug 2011 13:13:45 -0700
Message-ID: <CAC-hyiEypHmuhSP5Hjh8giPVFyZ8yaKrSMB8kUUZbhnu+AuVDg@mail.gmail.com>
References: <6514406A-D350-40F2-ADA7-0978DDD20667@research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53892 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab1HCUNr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2011 16:13:47 -0400
Received: by eyx24 with SMTP id 24so1189441eyx.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Aug 2011 13:13:46 -0700 (PDT)
In-Reply-To: <6514406A-D350-40F2-ADA7-0978DDD20667@research.att.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "H. Andres Lagar-Cavilla" <andres@research.att.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 3, 2011 at 12:46 PM, H. Andres Lagar-Cavilla
<andres@research.att.com> wrote:
> Hi all,
> I''ve been looking at ceph for a little while and following the mailing list. We are thinking of using just rados (i.e. no mds) for a data warehouse that does not need posix compliance. Three questions come to mind
>
> 1. what is a good kernel+backing filesystem combo to use on each individual rados node. Recently people have been reporting xattrs issues with 3.0 and ext4, and performance leaks with btrfs. What is recommended by core ceph developers as stable?

We generally recommend the use of btrfs with ceph, as there are
various optimizations that ceph employs with it. We use btrfs on
2.6.38+ and it's reasonably stable.

>
> 2. Layout: we have 10 beefy nodes (maybe more, stick with 10 for now). I'd like to use all ten for osds, but we also need monitors. So:
> 2.1. Do monitors need beefy machines (I guess not)

Usually no.

> 2.2. two/three monitors is ok for O(10) osds?

Three are needed to form a quorum.

>
> 3. API examples. The rgw looks like a prime example of a chunk of code that interfaces directly with rados. Any other examples? librbd?
>

the 'rados' tool, librbd, testrados and testradospp (compile with --with-debug).

Yehuda
