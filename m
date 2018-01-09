From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: shuffle_random removed in C++17 on FreeBSD/Clang??
Date: Tue, 9 Jan 2018 07:25:38 -0800
Message-ID: <CAJ4mKGY+jfhe9+k42FiTSL+fvroKecv0ysA-LffztLMxkiD86Q@mail.gmail.com>
References: <478f46a2-3cd9-ab94-6437-8f6de05f2c25@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:44472 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeAIPZj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jan 2018 10:25:39 -0500
Received: by mail-it0-f43.google.com with SMTP id b5so12023183itc.3
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jan 2018 07:25:39 -0800 (PST)
In-Reply-To: <478f46a2-3cd9-ab94-6437-8f6de05f2c25@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 9, 2018 at 2:10 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> As a consequence of the move to C++17 I'm running into this problem.
>
> --WjW
>
> I'm getting this error:
> /home/jenkins/workspace/ceph-master/src/osd/ReplicatedBackend.cc:1369:8:
> error: no member named 'random_shuffle' in namespace 'std'
>   std::random_shuffle(shuffle.begin(), shuffle.end());
>   ~~~~~^
> 1 error generated.
>
> And the includefile tells me:
> template <class RandomAccessIterator>
>     void
>     random_shuffle(RandomAccessIterator first, RandomAccessIterator last);
> // deprecated in C++14, removed in C++17

Hmm, yep! http://en.cppreference.com/w/cpp/algorithm/random_shuffle

Looks like we're just using it to re-order the list and pick a random
source, so it should be easy enough to replace with a range-restricted
integer selection. Here's a quick hack of a fix:
https://github.com/ceph/ceph/pull/19873
-Greg
