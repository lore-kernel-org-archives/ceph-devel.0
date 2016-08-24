From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: CephFS and the next jewel release v10.2.3
Date: Wed, 24 Aug 2016 11:11:22 -0700
Message-ID: <CAJ4mKGZ0DAH8Osa4mS8dupxg49GxBeutnvv3e55wSfsO0vt2SQ@mail.gmail.com>
References: <57BC1089.9080209@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:34335 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbcHXSLY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 14:11:24 -0400
Received: by mail-ua0-f182.google.com with SMTP id k90so42711880uak.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 11:11:23 -0700 (PDT)
In-Reply-To: <57BC1089.9080209@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

On Tue, Aug 23, 2016 at 1:59 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi John,
>
> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel passed the fs suite (http://tracker.ceph.com/issues/16344#note-30 except for three valgrind failures). Do you think the jewel branch is ready for QE to start their own round of testing ?
>
> Cheers
>
> P.S. CC'ing Greg because John is on vacation, in case a decision is to be made before he returns.

Ugh, I went to check these valgrind failures and they're a failed
mutex assert on shutdown. Let me dig into what's happening. :(
-Greg
