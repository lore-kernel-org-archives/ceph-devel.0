From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: 0.94.8 QE validation - on-hold
Date: Tue, 16 Aug 2016 13:51:31 +0200
Message-ID: <82fc130c-c7ca-5ae2-3ccf-d41aeb207129@suse.cz>
References: <CAMMFjmG7sa8zL7mSJzaLyivYv-j2GLx9rW-=XLT=Z8L_eG2hbQ@mail.gmail.com>
 <CAF-wwdGhNd9LpVp+8TJ4A+hwPkjowyRnec-yxtwfsBPG-wDnMg@mail.gmail.com>
 <20160816080138.GE5947@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52504 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbcHPLvg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Aug 2016 07:51:36 -0400
In-Reply-To: <20160816080138.GE5947@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: "Weil, Sage" <sage@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>

> At this stage, after looking at this in great depth today we have decided this
> is a problem, most likely in libunwind, and should be able to be safely
> ignored. There are suppression files to be found for this issue, or very
> similar issues, such as
> https://github.com/hkimura/foedus_code/blob/master/foedus-core/tools/valgrind.supp
> and we already even have multiple valgrind suppressions for similar issues.
>
> https://github.com/ceph/teuthology/blob/master/teuthology/task/valgrind.supp#L38
>
> Thanks to Kefu for helping with this.

Thanks, guys. This showed up during integration testing and it was 
judged to not be a blocker. We saw it on CentOS only.

Nathan
