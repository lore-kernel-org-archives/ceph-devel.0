From: Alfredo Deza <adeza@redhat.com>
Subject: Re: reStructuredText vs. AsciiDoc
Date: Wed, 21 Sep 2016 18:38:46 -0400
Message-ID: <CAC-Np1z_cxGx6q0-O=H68hcex3o-6ffAV==P_oT_Hyx=_fh96w@mail.gmail.com>
References: <CALe9h7ewfBg0Q5fUV7zknDEy4pMpwNP9DQ-EYLm53tLmuRnbvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38176 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755629AbcIUWis (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 18:38:48 -0400
Received: by mail-wm0-f42.google.com with SMTP id l132so116503060wmf.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 15:38:47 -0700 (PDT)
In-Reply-To: <CALe9h7ewfBg0Q5fUV7zknDEy4pMpwNP9DQ-EYLm53tLmuRnbvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 20, 2016 at 7:25 AM, John Spray <jspray@redhat.com> wrote:
> Hi all,
>
> Currently the Ceph upstream documentation is mostly written in
> restructuredtext, and built into HTML with Sphinx.
>
> We at Red Hat have some writer colleagues who are more comfortable
> with asciidoc, and it has been suggested that we could get more new
> content upstream (i.e. on github for everyone) if we were using
> asciidoc.

The barrier to contribute from asciidoc to rst is not huge, it is
mainly inconvenient. I think there is much more to gain
from current contributors to raise the bar to improve the current state of docs.

>
> So does anyone have any strong attachment to the restructuredtext
> format currently in use?

I really like RestructuredText, but an important question here is:
*if* we decided to move, are we aware of the burden that means
to generate: html, man pages, and the porting of the extensions
(doxygen, ditaa, and maybe something else I might be missing)

>
> (Opinions especially valued from people/groups who are active
> contributors to the docs)
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
