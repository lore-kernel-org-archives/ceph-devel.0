From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: 0.94.8 QE validation status
Date: Tue, 23 Aug 2016 18:50:37 +0200
Message-ID: <49704804-aca2-8258-79d9-9b21bdbba0dc@suse.cz>
References: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com>
 <f6cb352e-6a46-7f70-450f-3ae02033b487@suse.cz>
 <CAKPXa=agnk8Rp27Eenp7xNfnpFHpqy2-=ni9yg24cXfUY_7w8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36081 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752325AbcHWQuk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 12:50:40 -0400
In-Reply-To: <CAKPXa=agnk8Rp27Eenp7xNfnpFHpqy2-=ni9yg24cXfUY_7w8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>
Cc: Yuri Weinstein <yweinste@redhat.com>, "Weil, Sage" <sage@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>

>>> http://tracker.ceph.com/issues/17075 was caught be several runs, see
>>> email from Nathan with details "What to do with python-ceph-compat?"
>>
>>
>> This was caused by
>> https://github.com/ceph/teuthology/commit/4543fb64cedffc97c816feff7d4a69cd0456ab15
>> (my fault) which is reverted by https://github.com/ceph/teuthology/pull/939
> Revert will break jewel/rpm or in newer code where split has already happened.

The split happened in the hammer release, yet nobody noticed any breakage.

Part of the split was to include a "python-ceph" (or 
"python-ceph-compat") metapackage that provides the new post-split packages.

So specifying "python-ceph" in the packages.yaml should be fine, as long 
as we don't drop that metapackage :-)

Nathan
