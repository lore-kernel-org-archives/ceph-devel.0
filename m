From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: End of life for Ceph Hammer 0.94.x ?
Date: Sat, 28 Jan 2017 21:58:20 +0100
Message-ID: <d607d861-666e-dddc-d915-e6cca4858a08@suse.cz>
References: <CAH7C+PqR_gGMp06QT3cZwND3Ju5RZPdqFreA-EnixLhn8rAHYQ@mail.gmail.com>
 <CAMMFjmEkWx7sr_2VD+V-jDycr_0LrKEMqN0UyieR3KOTsX3K7Q@mail.gmail.com>
 <5d96f9ed-fcbe-10df-08ea-3bebe373ac2f@suse.cz>
 <CA+aFP1AdmMPXwg9ukAo38SXKaBm+CFOY=rTf9pq36J--QeWqow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51263 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751947AbdA1U60 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 28 Jan 2017 15:58:26 -0500
In-Reply-To: <CA+aFP1AdmMPXwg9ukAo38SXKaBm+CFOY=rTf9pq36J--QeWqow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Yuri Weinstein <yweinste@redhat.com>, David Moreau Simard <dms@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.org


On 01/28/2017 04:08 PM, Jason Dillaman wrote:
> I think the same release page states that an LTS release will continue
> to receive updates until two subsequent LTS releases are available
> (i.e. Hammer would EOL when Luminous is released).  If we are EOLing
> Hammer due to the release of Kraken (or because Jewel is a necessary
> upgrade stepping point), should the release page verbiage be tweaked
> as well?

Thanks for pointing that out, Jason. I'm fine with waiting to officially 
retire hammer until luminous is released, on the understanding that, 
from now on, the focus will be on fixing bugs that hinder upgrading to 
jewel.

Nathan
