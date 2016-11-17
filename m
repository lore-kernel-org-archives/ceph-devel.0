From: John Spray <jspray@redhat.com>
Subject: Re: Automate PGs calculation in Ceph?
Date: Thu, 17 Nov 2016 21:02:29 +0000
Message-ID: <CALe9h7eKrZmQ1gjv_TT4T8+q9u7nNVL9o7jH-jiMfCXft5co+w@mail.gmail.com>
References: <CA+HUO7LtJANRqMDC8AsFDp-Fr2u1toafiKX6uCSvjCjC-4MoyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33690 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbcKQVC4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Nov 2016 16:02:56 -0500
Received: by mail-qt0-f182.google.com with SMTP id p16so141954450qta.0
        for <ceph-devel@vger.kernel.org>; Thu, 17 Nov 2016 13:02:55 -0800 (PST)
In-Reply-To: <CA+HUO7LtJANRqMDC8AsFDp-Fr2u1toafiKX6uCSvjCjC-4MoyQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <shan@redhat.com>
Cc: Squid Cybernetic <ceph-devel@vger.kernel.org>

On Thu, Nov 17, 2016 at 6:14 PM, Sebastien Han <shan@redhat.com> wrote:
> Hey,
>
> I was wondering, since we have PG calc online to decide the right
> value for our PGs per pool. The logic seems to be easy and well
> understood. Looks like a simple calculation, I don't see anything like
> depending on a use case we are changing the value or anything.
>
> Any reason why this logic is not part of Ceph?
> Mons know about everything on the cluster and since they manage pool
> creations they should be able to take the right decision.
>
> Am I missing something?

I think the reason nobody has done this so far is that there's no
overall (multiple pools at a time) setup interface in Ceph.  To do the
pg calc stuff, you need a user to tell you not just that they want a
pool, but how many pools they want and what they will use them for:
something friendlier than the current "osd pool create" command can
handle.

Having mons do any kind of guessing on a "pool at a time" basis
without visibility of the user's overall intent is pretty dangerous,
because users can never fix a bad automatic choice (can't decrease
pg_num).

John

> Thanks!
>
> --
> Cheers
>
> ––––––
> Sébastien Han
> Principal Storage Architect
>
> "Always give 100%. Unless you're giving blood."
>
> Mail: seb@redhat.com
> Address: 11 bis, rue Roquépine - 75008 Paris
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
