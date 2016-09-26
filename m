From: Petr Kovar <pkovar@redhat.com>
Subject: Re: reStructuredText vs. AsciiDoc
Date: Mon, 26 Sep 2016 18:14:55 +0200
Message-ID: <20160926181455.f5f3845cba85e87d857bb0ed@redhat.com>
References: <CALe9h7ewfBg0Q5fUV7zknDEy4pMpwNP9DQ-EYLm53tLmuRnbvw@mail.gmail.com>
        <CAC-Np1z_cxGx6q0-O=H68hcex3o-6ffAV==P_oT_Hyx=_fh96w@mail.gmail.com>
        <188947d4-2386-e401-3ad0-43cb7b21f3eb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161240AbcIZQO5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Sep 2016 12:14:57 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C41D27F7C5
        for <ceph-devel@vger.kernel.org>; Mon, 26 Sep 2016 16:14:54 +0000 (UTC)
In-Reply-To: <188947d4-2386-e401-3ad0-43cb7b21f3eb@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QsOhcmEgQW7EjWluY292w6E=?= <bara@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 23 Sep 2016 15:31:22 +0200
Bára Ančincová <bara@redhat.com> wrote:

> On 09/22/2016 12:38 AM, Alfredo Deza wrote:
> > On Tue, Sep 20, 2016 at 7:25 AM, John Spray <jspray@redhat.com> wrote:
> >> Hi all,
> >>
> >> Currently the Ceph upstream documentation is mostly written in
> >> restructuredtext, and built into HTML with Sphinx.
> >>
> >> We at Red Hat have some writer colleagues who are more comfortable
> >> with asciidoc, and it has been suggested that we could get more new
> >> content upstream (i.e. on github for everyone) if we were using
> >> asciidoc.
> > 
> > The barrier to contribute from asciidoc to rst is not huge, it is
> > mainly inconvenient. I think there is much more to gain
> > from current contributors to raise the bar to improve the current state of docs.
> > 
> >>
> >> So does anyone have any strong attachment to the restructuredtext
> >> format currently in use?
> > 
> > I really like RestructuredText, but an important question here is:
> > *if* we decided to move, are we aware of the burden that means
> > to generate: html, man pages, and the porting of the extensions
> > (doxygen, ditaa, and maybe something else I might be missing)
> 
> Another solution I can think of is to enhance pandoc (or some other
> converter) to be able to convert between RST and AsciiDoc reliably,
> without the need to manually edit the files afterwards.
> 
> I recently found out that one of my colleagues (Petr Kovar, cc'ed) is
> dealing with the same problem. He contributes to the OpenStack upstream
> docs. Maybe we can join forces.

Thanks for looping me in, Bara. The RHOSP team is trying to semi-automate
downstreaming some of the OpenStack upstream guides, which are apparently
using the same publishing toolchain (RST + Sphinx) as the Ceph upstream.
The problem is that support for RST markup in pandoc is currently
incomplete, which makes the whole process very fragile. 

I'd be very much interested in working together on finding a robust enough
solution for RST to adoc conversion if that's what you decide to go with for
your upstream to downstream content flow.

Thanks,
pk

-- 
Petr Kovar
Sr. Technical Writer | Customer Content Services
Red Hat Czech, Brno
