From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: 0.94.8 QE validation status
Date: Tue, 23 Aug 2016 09:21:03 +0200
Message-ID: <f6cb352e-6a46-7f70-450f-3ae02033b487@suse.cz>
References: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753076AbcHWHVP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 03:21:15 -0400
In-Reply-To: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, "Weil, Sage" <sage@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>

> Known issues (need approval):
>
> http://tracker.ceph.com/issues/17075 was caught be several runs, see
> email from Nathan with details "What to do with python-ceph-compat?"

This was caused by 
https://github.com/ceph/teuthology/commit/4543fb64cedffc97c816feff7d4a69cd0456ab15 
(my fault) which is reverted by 
https://github.com/ceph/teuthology/pull/939 - when that is merged the 
tests could be re-run.

Lesson learned (rather obvious in hindsight) is that we cannot drop the 
python-ceph/python-ceph-compat packages as long as there are tests in 
ceph-qa-suite that install pre-hammer releases.

Nathan
