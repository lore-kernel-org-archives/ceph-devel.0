From: John Spray <jspray@redhat.com>
Subject: Re: "Inherit members" on redmine subprojects
Date: Mon, 20 Nov 2017 15:10:23 +0000
Message-ID: <CALe9h7exV_yEY0qj2b5WK28TqgM08C-L39aFDYm9wYMc_2DsTQ@mail.gmail.com>
References: <CALe9h7ffKQ9C86ovTh3oGwQgAVSo93u8fD_OwJ8YvgAUD83auw@mail.gmail.com>
 <CAJ4mKGY7u9Jr5yj-cpgDhPprCopTbyH4ZJiWcCPym73DT7iMjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:39480 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdKTPKo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Nov 2017 10:10:44 -0500
Received: by mail-wm0-f51.google.com with SMTP id x63so6753619wmf.4
        for <ceph-devel@vger.kernel.org>; Mon, 20 Nov 2017 07:10:44 -0800 (PST)
In-Reply-To: <CAJ4mKGY7u9Jr5yj-cpgDhPprCopTbyH4ZJiWcCPym73DT7iMjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 20, 2017 at 3:05 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Mon, Nov 20, 2017 at 11:36 PM, John Spray <jspray@redhat.com> wrote:
>> I just noticed that redmine has this option to have subprojects
>> inherit their permissions from the parent project.  It seems like a
>> sensible idea that if some has a role on the toplevel "Ceph" project
>> they'd have access to the subprojects too -- anybody remember a
>> historical reason we don't have this box ticked for most of the
>> subprojects?
>
> Redmine's preferences make Ceph's look compact. ;) Where exactly are
> you looking at? Sometimes option titles are misleading, and at this
> point I think permission handling is mostly through the groups rather
> than as individuals.

It's the one on the first "Information" tab under settings for each
project, after "subproject of".

John



> -Greg
