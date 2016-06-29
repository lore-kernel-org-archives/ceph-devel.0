From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: cephfs: status of directory fragmentation and multiple filesystems
Date: Wed, 29 Jun 2016 10:53:34 -0700
Message-ID: <CAJ4mKGZQ3C8HT=m=0afmEe3tLA=xpxb==VHfKtPpOAgSC-gxPQ@mail.gmail.com>
References: <CA+H5UW0Uu_+GYNq6EKw7GguiL-w3bEv3AKV72APLSbqgkLzS6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35655 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbcF2Rxg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 13:53:36 -0400
Received: by mail-vk0-f44.google.com with SMTP id u68so33834720vkf.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2016 10:53:35 -0700 (PDT)
In-Reply-To: <CA+H5UW0Uu_+GYNq6EKw7GguiL-w3bEv3AKV72APLSbqgkLzS6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 29, 2016 at 10:47 AM, Radoslaw Zarzynski
<rzarzynski@mirantis.com> wrote:
> Hello,
>
> I saw the recent question about having more than 1 active
> MDS in a cluster. I would like to ask similar ones but in
> the matter of 1) directory fragmentation and 2) running
> multiple filesystems within same cluster.
>
> When those features are expected to be production-ready?
> What do we need to achieve this status?

These are both all about the QA work of just making sure they're
well-tested in the nightlies, and demonstrating that the functionality
isn't broken. We're expecting dirfrags to be enabled in Kraken; I
don't know if there's a target timeline around multi-fs.

There are available tickets in the tracker that basically come out to
"demonstrate dirfrags actually get exercised in the nightlies", etc if
you're interested in contributing!
-Greg
