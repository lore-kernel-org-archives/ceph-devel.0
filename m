From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: ceph v10.2.10 QE validation status
Date: Fri, 22 Sep 2017 14:15:18 +0200
Message-ID: <24a86367-d144-80e6-00f8-5b48f7d403b0@suse.cz>
References: <CAMMFjmHRF8AA3h0Sta==y5XMXNqZBMtwz-nno4hEpVP24EBMcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751928AbdIVMPV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 22 Sep 2017 08:15:21 -0400
In-Reply-To: <CAMMFjmHRF8AA3h0Sta==y5XMXNqZBMtwz-nno4hEpVP24EBMcg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

> upgrade/jewel-x/point-to-point-x Nathan is fixing one issue

Fixed in master and jewel by:

https://github.com/ceph/ceph/pull/17910
https://github.com/ceph/ceph/pull/17892

(could be merged in that order)

Thanks,
Nathan
