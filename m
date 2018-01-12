From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: can we stop packaging sysvinit scripts?
Date: Fri, 12 Jan 2018 08:41:47 +0100
Message-ID: <3e2796b5-0208-f350-1b40-8812185aa35d@m-privacy.de>
References: <alpine.DEB.2.11.1801101440550.24931@piezo.novalocal>
 <b6b69060-2424-5404-cdf0-4ca019ec9ead@m-privacy.de>
 <CALqRxCzvTa2o5Q9U9jWCQ4ebhSL36rRy59DcwKi9L7mFdgYD0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www1.m-privacy.de ([85.214.254.135]:48314 "EHLO
        www1.m-privacy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbeALHl6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jan 2018 02:41:58 -0500
In-Reply-To: <CALqRxCzvTa2o5Q9U9jWCQ4ebhSL36rRy59DcwKi9L7mFdgYD0w@mail.gmail.com>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com

Am 12.01.2018 um 00:40 schrieb Ken Dreyer:
> On Wed, Jan 10, 2018 at 9:18 AM, Amon Ott <a.ott@m-privacy.de> wrote:
>> We would really appreciate having the init scripts around for a long
>> while, as we are not willing to use systemd on our servers for security
>> reasons. Please do not drop them.
> 
> I'm curious, what init system are you using?

Still sysvinit. I just do not like the idea of one complex user space
daemon like systemd controlling most of the system, whose complexity
makes severe security problems likely. So we stick with separate small
programs and mandatorily assign individual and limited access control
rights to them with RSBAC.

Think of the regular nightmare with anti malware software deep in the
system, which repeatedly opened up the whole system remotely in the
past, and you get the idea. We do not trust malware scanners and
strictly limit their abilities to a simple "read a file and decide, we
do the rest as we please".

IMO, access control must be done in the kernel and security needs small
components in user space with limited functionality, following the good
old KISS principle. Then you have full control and can limit the
consequences of misbehaving programs.

Amon Ott
-- 
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Werner-Voß-Damm 62       Fax: +49 30 99296856
12101 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Geschäftsführer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

