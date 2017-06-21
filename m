From: Nathan Cutler <ncutler@suse.cz>
Subject: ceph-deploy hammer support
Date: Wed, 21 Jun 2017 13:47:26 +0200
Message-ID: <0e5609d3-c9b9-24f7-da56-f957bebd25b3@suse.cz>
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
Received: from mx2.suse.de ([195.135.220.15]:44280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750927AbdFULr2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Jun 2017 07:47:28 -0400
In-Reply-To: <CAC-Np1wAh5mewdgKOosHc=b8WrRZW+zUuosoaB-FmmX1g4fLLA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> ceph-deploy always supported up until the EOL'd versions. Not sure
> what specific issue you are referring to.

http://tracker.ceph.com/issues/17128

The bug was closed without any indication that the latest version of 
ceph-deploy actually does support hammer. Although hopefully folks are 
not actively out there installing new hammer clusters, hammer itself is 
not yet EOL.

I cite this only as an example of how a tool with a single codestream 
can bring headaches for older (not-yet-EOL) versions of Ceph when new 
features are merged into that codestream and released. In other words, 
please don't construe this as an escalation of that old ceph-deploy bug :-)

Nathan
