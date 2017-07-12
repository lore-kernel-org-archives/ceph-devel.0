From: Nathan Cutler <ncutler@suse.cz>
Subject: 10.2.9 release needed to fix fs regression in 10.2.8
Date: Wed, 12 Jul 2017 21:55:40 +0200
Message-ID: <a7d7b003-f348-6648-064a-1c91524c7b64@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751151AbdGLTzn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Jul 2017 15:55:43 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi leads,

Zheng and John confirmed today that there is an fs regression in 10.2.8 
which requires a single PR to fix. Since the v10.2.8 tag has already 
been applied, RPM and DEB packages uploaded, and release notes prepared, 
the best option at this stage seems to be cutting a 10.2.9 release 
consisting of the current tip of the jewel branch plus 
https://github.com/ceph/ceph/pull/16282

Yuri is running an fs suite on that PR already.

In this respect, I have two questions for you:

1. do you agree with the above, and
2. what further QE testing should we do on 10.2.9, other than the fs suite?

Thanks,
Nathan
