From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: CephFS and the next hammer release v0.94.4
Date: Thu, 8 Oct 2015 13:50:28 -0700
Message-ID: <CAJ4mKGZ3GRVwRMdpM3cqEi2gKELVkjDpxoE08ggPyvMCeM9r9g@mail.gmail.com>
References: <5613E5CA.2060903@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35916 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbbJHUu3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Oct 2015 16:50:29 -0400
Received: by wicgb1 with SMTP id gb1so42287148wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Oct 2015 13:50:28 -0700 (PDT)
In-Reply-To: <5613E5CA.2060903@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

On Tue, Oct 6, 2015 at 8:16 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> The next hammer release as found at https://github.com/ceph/ceph/tree/hammer passed the fs suite (http://tracker.ceph.com/issues/12701#note-66). Do you think the hammer branch is ready for QE to start their own round of testing ?
>
> Cheers
>
> P.S. http://tracker.ceph.com/issues/12701#Release-information has direct links to the pull requests merged into hammer since v0.94.3 in case you need more context about one of them.

I don't see any FS patches in that list. The only thing I'm aware of
which CephFS would like to see backported is
https://github.com/ceph/ceph/pull/5885, which isn't in that list but
has been merged since...would it be difficult to add that one?
-Greg
