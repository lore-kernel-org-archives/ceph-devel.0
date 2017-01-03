From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: ceph-ci.git and pull requests
Date: Tue, 3 Jan 2017 22:55:06 +0100
Message-ID: <c19fc095-5c33-6b43-4578-f0b76dda3d29@suse.cz>
References: <7ca73dab-23d4-6725-79d4-c3bac274dc3b@redhat.com>
 <CAN=+7FX9jb712_ddmx4GgPKQW47R-QhB4fqfZ6gmCWuU-EiW2A@mail.gmail.com>
 <CALqRxCznKbjq8x38NGO3=HQCR17a59iXvcq8HPvprNAJ_XyxHw@mail.gmail.com>
 <93a45df1-4c2d-1509-8533-e5d28396460a@suse.cz>
 <0444043b-d29d-36da-f63e-8f91015e17f2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57025 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933089AbdACVzO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 3 Jan 2017 16:55:14 -0500
In-Reply-To: <0444043b-d29d-36da-f63e-8f91015e17f2@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

> Fair enough. In this case, I was going to push a backport to ceph-ci.git
> so that packages would be available when the backport team was ready to
> validate it.

That's probably not necessary. Typically, multiple backport PRs are 
ganged up in an integration branch for testing purposes. For example, 
the current hammer integration branch looks like this: 
http://tracker.ceph.com/issues/17151#note-37

The scripting used to prepare the integration branches is described 
here: 
http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_populate_the_integration_branch

Nathan
