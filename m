From: kefu chai <tchaikov@gmail.com>
Subject: Re: seastar and 'tame reactor'
Date: Tue, 13 Feb 2018 21:35:00 +0800
Message-ID: <CAJE9aOOiSAtgRb9s2G6qGyGhpp-RJ3s7eqRx5d6Ki6mhaWhkRw@mail.gmail.com>
References: <d0f50268-72bb-1196-7ce9-0b9e21808ffb@redhat.com>
 <5b32056c-c6f7-a1c4-d07a-ae04557b59cf@redhat.com> <CAJE9aOOq+HAWZOec0TnSqXFqUx7GD=XgCByh8HFV9Rb8L8qc2A@mail.gmail.com>
 <9e6bc174-c6b3-a37e-abd5-b96d572d1d1b@redhat.com> <CAJ4mKGa6XzhQmK3JkAL3FtnuXDMf2uy1oheQxEL8kcdukSKssw@mail.gmail.com>
 <CAJE9aOO0=VKuqH=7x4M-uNJcK2j4VhTG+-=KAqZn7OkNZGLvfA@mail.gmail.com> <CAKOnar=HjUfq5WDZtqjKC=Wyj1oK0454wszpukSmFf0L46gZsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33411 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964776AbeBMNfB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 08:35:01 -0500
Received: by mail-qt0-f171.google.com with SMTP id d8so3614008qtm.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 05:35:01 -0800 (PST)
In-Reply-To: <CAKOnar=HjUfq5WDZtqjKC=Wyj1oK0454wszpukSmFf0L46gZsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjami@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Casey Bodley <cbodley@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Adam Emerson <aemerson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 12, 2018 at 11:55 PM, Matt Benjamin <mbenjami@redhat.com> wrote:
> How does tame reactor induce more OSD sessions (@greg);  @kefu, in't
> the hybrid model another way of saying, tame reactor?  The intuition

i just realized that it is =)

> I've had to this point is that the interfacing here is essentially
> similar to making seastar interact with anything else, including
> frameworks (disks, memory devices) that it absolutely wants to and
> must.
>


-- 
Regards
Kefu Chai
