From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Fixed URL for latest branch shaman build?
Date: Mon, 27 Feb 2017 07:20:23 -0800
Message-ID: <CAJ4mKGZwH+mq9xtF1hy_rB1jKGVUqen3fOGd6my=o5r4=7jr+Q@mail.gmail.com>
References: <CABZ+qqk+ni5ACoRaRqTd75G77sDMvXnzuSQT7pwyiM8z0tsnMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33228 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdB0PUZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 10:20:25 -0500
Received: by mail-oi0-f41.google.com with SMTP id 2so40029666oif.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 07:20:24 -0800 (PST)
In-Reply-To: <CABZ+qqk+ni5ACoRaRqTd75G77sDMvXnzuSQT7pwyiM8z0tsnMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Andrew Schoen <aschoen@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Dan van der Ster <dan@vanderster.com>

On Mon, Feb 27, 2017 at 6:21 AM, Dan van der Ster <dan@vanderster.com> wrote:
> Hi all,
>
> tl;dr: Is there a fixed URL which points to the latest jewel build on shaman?
>
> We used to use gitbuilder.ceph.com (via a caching proxy) to
> occasionally run the latest build for a given branch. This was
> convenient -- we'd just set a yum repo with url
>
>    http://gitbuilder.ceph.com/ceph-rpm-centos7-x86_64-basic/ref/jewel/x86_64/
>
> And it would always point to the build for the latest commit.
>
> Now with shaman, unless I'm mistaken, we have a unique repo for each
> build. E.g. here's the latest build's repo:
>
> https://1.chacra.ceph.com/r/ceph/jewel/ac3ba2adcd21ac011ad556ac4506623e61fbe696/centos/7/flavors/default/x86_64/
>
> So I think what I'm asking for is a symlink 'latest' which we can use like this:
>
>   https://1.chacra.ceph.com/r/ceph/jewel/latest/centos/7/flavors/default/x86_64/
>
> Is there someway to do this with shaman?

+Alfredo,Andrew
