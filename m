From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: ceph v10.2.4 QE validation status
Date: Tue, 15 Nov 2016 09:18:59 +0100
Message-ID: <91ea2d8b-31d4-6430-fa3a-6fb5385e06c1@suse.cz>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
 <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49455 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752343AbcKOITD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 15 Nov 2016 03:19:03 -0500
In-Reply-To: <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> upgrade/infernalis-x (jewel) - deprecated (Nathan is still working
> to make it pass, see issues in the tacker summary above)

Actually, I'm no longer working on it. Two fixes were merged that 
brought the run from 100% fail to 8/11 passing. This is the latest run:

http://pulpito.ceph.com/yuriw-2016-11-14_16:21:41-upgrade:infernalis-x-jewel-distro-basic-vps/

I didn't look, but based on previous runs the two fails are MON crashes 
and the dead job is an unknown (there tends to be one dead job in every 
run, but not always in the same test).

Perhaps a developer could look at those three?

Nathan
