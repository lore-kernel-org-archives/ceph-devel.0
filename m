From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: "Inherit members" on redmine subprojects
Date: Tue, 21 Nov 2017 02:05:58 +1100
Message-ID: <CAJ4mKGY7u9Jr5yj-cpgDhPprCopTbyH4ZJiWcCPym73DT7iMjA@mail.gmail.com>
References: <CALe9h7ffKQ9C86ovTh3oGwQgAVSo93u8fD_OwJ8YvgAUD83auw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:38320 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdKTPGA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Nov 2017 10:06:00 -0500
Received: by mail-io0-f172.google.com with SMTP id h205so15284797iof.5
        for <ceph-devel@vger.kernel.org>; Mon, 20 Nov 2017 07:06:00 -0800 (PST)
In-Reply-To: <CALe9h7ffKQ9C86ovTh3oGwQgAVSo93u8fD_OwJ8YvgAUD83auw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 20, 2017 at 11:36 PM, John Spray <jspray@redhat.com> wrote:
> I just noticed that redmine has this option to have subprojects
> inherit their permissions from the parent project.  It seems like a
> sensible idea that if some has a role on the toplevel "Ceph" project
> they'd have access to the subprojects too -- anybody remember a
> historical reason we don't have this box ticked for most of the
> subprojects?

Redmine's preferences make Ceph's look compact. ;) Where exactly are
you looking at? Sometimes option titles are misleading, and at this
point I think permission handling is mostly through the groups rather
than as individuals.
-Greg
