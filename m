From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: building boost statically
Date: Fri, 29 Apr 2016 16:55:02 -0600
Message-ID: <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
	<CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33070 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbcD2WzE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2016 18:55:04 -0400
Received: by mail-vk0-f43.google.com with SMTP id o133so7483362vka.0
        for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2016 15:55:02 -0700 (PDT)
In-Reply-To: <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Apr 28, 2016 at 8:31 PM, Haomai Wang <haomai@xsky.com> wrote:
> Yes, I'm always glad to see more deps removed!

It's not removed, it's just moved. The Ceph project will then be on
the hook for all boost security updates.

I think we should bundle less not more. Build times are already long enough...

- Ken
