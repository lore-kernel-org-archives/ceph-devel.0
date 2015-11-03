From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: civetweb upstream/downstream divergence
Date: Tue, 3 Nov 2015 10:22:37 +0100
Message-ID: <56387CDD.9070605@suse.cz>
References: <5631E4A5.9020003@suse.cz>
 <CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com>
 <20151029225738.51b8b2e5@lembas.zaitcev.lan>
 <CALqRxCwPNA0WFYu0oJ-70L3vgR0G8WLs4paU=K1xZCyf=a3Fjw@mail.gmail.com>
 <1446486438.12033.24.camel@millnert.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40885 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbbKCJWj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 Nov 2015 04:22:39 -0500
In-Reply-To: <1446486438.12033.24.camel@millnert.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>, Ken Dreyer <kdreyer@redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

IMHO the first step should be to get rid of the evil submodule. Arguably
the most direct path leading to this goal is to simply package up the
downstream civetweb (i.e. 1.6 plus all the downstream patches) for all
the supported distros. The resulting package would be Ceph-specific,
obviously, so it could be called "civetweb-ceph".

Like Ken says, the upstreaming effort can continue in parallel.

After we get Ceph/RGW working fine with civetweb-ceph 1.6, we can rebase
the package to upstream civetweb 1.7.

I am not volunteering to do all the work, but we at SUSE are certainly
prepared to shoulder our share of it.

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
