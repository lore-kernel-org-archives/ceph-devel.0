From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: cap mask differences for `Client::stat` vs `Client::fstat`
Date: Wed, 13 Apr 2016 13:24:08 -0700
Message-ID: <CAJ4mKGZv57utVXNG5rGmDd1W_C2nO4vD1BYVP+bz_2tVY0E6WQ@mail.gmail.com>
References: <CAB2gnbUz9D9VWz6=PtDdAQ7u+hVWeHa3rz=5CypGAFLq-bSboA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36823 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbcDMUYK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 16:24:10 -0400
Received: by mail-vk0-f46.google.com with SMTP id c4so85168873vkb.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 13:24:09 -0700 (PDT)
In-Reply-To: <CAB2gnbUz9D9VWz6=PtDdAQ7u+hVWeHa3rz=5CypGAFLq-bSboA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 13, 2016 at 10:26 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
> In the libcephfs client it looks like both `Client::stat` and
> `Client::lstat` use a default mask of CEPH_STAT_CAP_INODE_ALL and are
> able to return immediately from `Client::_getattr` without making an
> MDS request. However, `Client::fstat` uses hard-coded -1 as the cap
> mask and always issues a MDS request. Is this the intended behavior,
> and if so, what are different semantics of fstat that make this a
> requirement?

Based off of "man fstat" and looking at the git history, I think this
is an accident. I certainly can't think of any reason why we'd need Fb
(for instance) in order to answer a stat request. Send in a PR? :)
-Greg
