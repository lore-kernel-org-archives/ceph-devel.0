From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: reStructuredText vs. AsciiDoc
Date: Tue, 20 Sep 2016 12:44:59 +0100
Message-ID: <a2a6879e-3f48-2a37-2cb8-a6bc5eafe4a7@suse.de>
References: <CALe9h7ewfBg0Q5fUV7zknDEy4pMpwNP9DQ-EYLm53tLmuRnbvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbcITLpF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Sep 2016 07:45:05 -0400
In-Reply-To: <CALe9h7ewfBg0Q5fUV7zknDEy4pMpwNP9DQ-EYLm53tLmuRnbvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 09/20/2016 12:25 PM, John Spray wrote:
> Hi all,
>
> Currently the Ceph upstream documentation is mostly written in
> restructuredtext, and built into HTML with Sphinx.
>
> We at Red Hat have some writer colleagues who are more comfortable
> with asciidoc, and it has been suggested that we could get more new
> content upstream (i.e. on github for everyone) if we were using
> asciidoc.
>
> So does anyone have any strong attachment to the restructuredtext
> format currently in use?
>
> (Opinions especially valued from people/groups who are active
> contributors to the docs)

Took a quick look at how an asciidoc file looks like and, with 
hard-wrapping the lines, it looks just as readable as rst - give or take 
a few formatting specificities that could be argued as a trade-off 
between readability and flexibility.

Personally, I'm not attached to any given format; as long as it's 
readable on a terminal without having to compile the sources - and it's 
not latex (being great notwithstanding, seems overkill.)

   -Joao
