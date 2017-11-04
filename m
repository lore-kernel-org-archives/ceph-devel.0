From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: 12.2.2 status
Date: Sat, 4 Nov 2017 08:51:18 +0100
Message-ID: <7fc4336c-40fc-848c-00f7-e7ebc8aa744c@suse.cz>
References: <87fua6c4xy.fsf@suse.com>
 <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
 <874lqbcl5p.fsf@suse.com>
 <alpine.DEB.2.11.1711031753520.23234@piezo.novalocal>
 <871slfckae.fsf@suse.com>
 <CAJE9aOMv3pNFbL3RA3=wiXJKGL9+Mx6N9BazApPZ9E9DMXVp2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41755 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbdKDHvV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 4 Nov 2017 03:51:21 -0400
In-Reply-To: <CAJE9aOMv3pNFbL3RA3=wiXJKGL9+Mx6N9BazApPZ9E9DMXVp2A@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Abhishek Lekshmanan <abhishek@suse.com>, vumrao@redhat.com
Cc: Sage Weil <sweil@redhat.com>, Nathan Cutler <NCutler@suse.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Karol Mroz <KMroz@suse.com>

> all or nothing. if we want to backport the fix of
> http://tracker.ceph.com/issues/21762, we will have to backport the
> "debian: fix package relationships after" fixes. so i think pull/18589
> is self-contained. and no additional step is needed.
> 
> and per http://tracker.ceph.com/issues/21762, we need to have it in
> luminous. but i have no strong opinion on including it in 12.2.2 or
> post 12.2.2. Vikhyat and Nathan, what do you think?

Yes, I tried to make 18589 self-contained by pulling in Kefu's and 
Abhishek's follow-on fixes. I think it would be nice to have it in 12.2.2.

Nathan
