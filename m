From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: ceph-ci.git and pull requests
Date: Tue, 3 Jan 2017 22:08:20 +0100
Message-ID: <93a45df1-4c2d-1509-8533-e5d28396460a@suse.cz>
References: <7ca73dab-23d4-6725-79d4-c3bac274dc3b@redhat.com>
 <CAN=+7FX9jb712_ddmx4GgPKQW47R-QhB4fqfZ6gmCWuU-EiW2A@mail.gmail.com>
 <CALqRxCznKbjq8x38NGO3=HQCR17a59iXvcq8HPvprNAJ_XyxHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966340AbdACVIX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 3 Jan 2017 16:08:23 -0500
In-Reply-To: <CALqRxCznKbjq8x38NGO3=HQCR17a59iXvcq8HPvprNAJ_XyxHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, Samuel Just <sjust@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Casey:

Here's what I do, which I think is essentially the same as Sam and Ken 
are doing:

git clone https://github.com/smithfarm/ceph
git remote add ceph-ci https://github.com/ceph/ceph
<prepare wip-foo branch>
git push origin wip-foo
<open PR>
git push ceph-ci wip-foo
<wait for http://shaman.ceph.com to build>
<test in Sepia>

HTH,
Nathan
