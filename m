From: Tommi Virtanen <tv@inktank.com>
Subject: Re: v0.52 released
Date: Thu, 27 Sep 2012 15:54:35 -0700
Message-ID: <CADvuQRF_OxfaCJRh3BgUSVMBwMPXJvywa9u86ZLfa4EyjYcJnw@mail.gmail.com>
References: <alpine.DEB.2.00.1209271306120.13352@cobra.newdream.net>
 <5064BCB7.4010801@smart-weblications.de> <alpine.DEB.2.00.1209271355550.13352@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:37776 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090Ab2I0Wy4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 18:54:56 -0400
Received: by qaas11 with SMTP id s11so1304132qaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 15:54:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209271355550.13352@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Smart Weblications GmbH - Florian Wiessner <f.wiessner@smart-weblications.de>, "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

On Thu, Sep 27, 2012 at 1:57 PM, Sage Weil <sage@inktank.com> wrote:
>> Is this a stable release to replace 0.48.2 ?
> No, this is a normal development release.  It goes through several weeks
> of testing before release, so it should be pretty stable, but it's not a
> long-term type release.  The next stable release will be bobtail, and will
> most likely be based on 0.54.  0.53 was just frozen.

Perhaps it's worth saying this explicitly: stable releases will have a
version number like

<major>.<minor>[.<patch>]<codename>

It'll be a stable release when you see the next cute codename show up.
I expect we'll make more noise at that time, too ;)

Codenames will increment alphabetically: argonaut, bobtail ...
