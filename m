From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Additional backport labels and process improvements
Date: Thu, 2 Nov 2017 13:54:42 -0600
Message-ID: <CALqRxCzEJ88hFKjLyA0-kn4qWGQzPqiVCLnwHQAz92YuZoUjfw@mail.gmail.com>
References: <CAKPXa=Z3aXdwRz9OAniOLEpWkLtGUJHyLCTvm2y+n9u8PKXy7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:54719 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934362AbdKBTyn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Nov 2017 15:54:43 -0400
Received: by mail-vk0-f48.google.com with SMTP id n70so448393vkf.11
        for <ceph-devel@vger.kernel.org>; Thu, 02 Nov 2017 12:54:42 -0700 (PDT)
In-Reply-To: <CAKPXa=Z3aXdwRz9OAniOLEpWkLtGUJHyLCTvm2y+n9u8PKXy7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Nov 2, 2017 at 10:16 AM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
> Also I am +1 on NOT creating a new tracker for every backport, this
> seems redundant work, the original tracker can still be used with few
> additional fields to indicate "fixed in master", "fixed in jewel" etc.

I like the additional tickets because it makes it clearer to me what
is complete and what is not. But I agree it's pretty heavyweight to do
it by hand.

I think ceph-workbench (?) automates some of this, but I think we
could automate it further.

- Ken
