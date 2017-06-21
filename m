From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Fwd: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM
 volumes
Date: Wed, 21 Jun 2017 13:25:00 +0200
Message-ID: <b3eb845a-b70a-d2c8-b8b2-0ac75f1b6c4a@suse.cz>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com>
 <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
 <CALe9h7cV6U3A_OT9R8tv_yPoGG9zFaWF3qXV5cwYK0KM-NDu4g@mail.gmail.com>
 <CAC-Np1yiRgkmhZCOij9qSBmqUo-YYtErWXk2gevYuvWKrYFyeg@mail.gmail.com>
 <CALe9h7cT54esfoT=eOgZq=ZbYAp1pjH_CeLiz-kFO61jABasrA@mail.gmail.com>
 <CAC-Np1zwnzcwFBn4kqAzuhwmk9vZv1ZiUdd7owQZkA76k=QYuA@mail.gmail.com>
 <CALe9h7cxPioPHLw48Gj02bEkD-HC49yHT8kG62AyLm_V9KnOZQ@mail.gmail.com>
 <09d01c0c-b5f0-519e-0687-c8117e1fc2ce@suse.cz>
 <CAEPMp+41hTKanCsxJ7r-YA7k11QFQczGPXaiwmYptW9viFAEAQ@mail.gmail.com>
 <0d432012-9491-0ebd-edd0-06d68fb1801b@suse.cz>
 <CAC-Np1wAh5mewdgKOosHc=b8WrRZW+zUuosoaB-FmmX1g4fLLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751028AbdFULZC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Jun 2017 07:25:02 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7214DAB09
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jun 2017 11:25:01 +0000 (UTC)
In-Reply-To: <CAC-Np1wAh5mewdgKOosHc=b8WrRZW+zUuosoaB-FmmX1g4fLLA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

> My position is that a small, python-only, with no direct bindings to
> Ceph other than the CLI, should probably have the
> freedom of staying out of tree, and that it can keep up with older
> versions, and release often when bugs come up (as you've mentioned
> happened
> with ceph-deploy)

Release often in a single codestream? In other words, you are not 
planning to maintain separate codestreams for each stable branch of Ceph?

By the way, is there any other use for ceph-volume, other than as a tool 
for deploying OSDs? If not, I don't see the "no direct bindings to 
Ceph". It is bound to Ceph directly in that Ceph is the only reason for 
its existence.

Nathan
