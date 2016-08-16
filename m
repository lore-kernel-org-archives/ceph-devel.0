From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: 0.94.8 QE validation - on-hold
Date: Tue, 16 Aug 2016 18:06:31 +0200
Message-ID: <cefec434-d73e-ae6a-d3a0-b2ce3b7b3290@suse.cz>
References: <CAMMFjmG7sa8zL7mSJzaLyivYv-j2GLx9rW-=XLT=Z8L_eG2hbQ@mail.gmail.com>
 <CAF-wwdGhNd9LpVp+8TJ4A+hwPkjowyRnec-yxtwfsBPG-wDnMg@mail.gmail.com>
 <20160816080138.GE5947@rskikr.localdomain>
 <82fc130c-c7ca-5ae2-3ccf-d41aeb207129@suse.cz>
 <CAMMFjmE-Oqg-a6MpK-9sA+V4yFPXeB+uT5LKK2L_uQr0hzQS_w@mail.gmail.com>
 <CAMMFjmGc0sgP7Rv3569ds8M3tcVFGYOcqbimQMM4eELAF7+c3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44892 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbcHPQHW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Aug 2016 12:07:22 -0400
In-Reply-To: <CAMMFjmGc0sgP7Rv3569ds8M3tcVFGYOcqbimQMM4eELAF7+c3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>

> Should we backport https://github.com/ceph/teuthology/pull/933 to
> hammer 0.94.8 ?

Hi Yuri:

While teuthology may have hammer, jewel, etc. branches, these can be 
ignored - only the master branch is used AFAIK.

In my account on teuthology.front, I have a clone of 
https://github.com/ceph/teuthology and inside that I have a virtualenv 
from which I run teuthology-suite. To get the latest teuthology fixes, I 
usually just nuke the entire clone and start from a fresh clone:

git clone https://github.com/ceph/teuthology
cd teuthology
./bootstrap
virtualenv/bin/teuthology-suite . . .

Nathan
