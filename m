From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: master vs. next
Date: Fri, 15 May 2015 13:15:09 +0200
Message-ID: <5555D53D.7070400@suse.cz>
References: <5555B1E9.3010003@suse.cz>	<CAOi1vP8tCszV-QJO+o-ab8i76qzw1b4sj6FWHgPk6KfVPuvZhQ@mail.gmail.com>	<5555C495.8030804@dachary.org> <CAOi1vP_PPrMDE9o2Ai78sepPJf6ZH+99UVkiMAkiVMqemwEp3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52074 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791AbbEOLPM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 May 2015 07:15:12 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 171C7ADB5
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2015 11:15:11 +0000 (UTC)
In-Reply-To: <CAOi1vP_PPrMDE9o2Ai78sepPJf6ZH+99UVkiMAkiVMqemwEp3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2015-05-15 12:45, Ilya Dryomov wrote:
> If you need to fix something that is broken in next, then you target
> next.  I'm sure sometimes on an ad-hoc basis commits are cherry-picked
> from master into next or even go directly into next to expedite things,
> but that's rare and not something a newcomer should be concerned about.

SubmittingPatches says to target next for bugfixes. So far I have only
been pushing bugfixes, so I have been targeting that branch. And when
the patch is merged, it goes directly into next. So I don't understand
why you say that's rare and not something I should be concerned about?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
