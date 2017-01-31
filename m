From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: hammer 0.94.10 QE: valgrind issues in RGW suite
Date: Tue, 31 Jan 2017 14:36:46 +0100
Message-ID: <e858f054-b2d4-80f1-3369-f309cdbfaca4@suse.cz>
References: <0fff1b23-9e4b-507f-7192-f593620e9542@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43341 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbdAaQEB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 31 Jan 2017 11:04:01 -0500
In-Reply-To: <0fff1b23-9e4b-507f-7192-f593620e9542@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yuri Weinstein <yweinste@redhat.com>

I found that teuthology is correctly querying Shaman for the notcmalloc 
build flavor, but the binaries built by this flavor are linked against 
libtcmalloc. See http://tracker.ceph.com/issues/18744 for details.

On 01/30/2017 01:00 PM, Nathan Cutler wrote:
> Hi Yehuda,
>
> In the course of QE testing of the hammer 0.94.10 release, Yuri found
> that the valgrind tests in rgw/verify are red when run in CentOS (7.3
> and 7.2).
>
> I verified this is the case and attempted to bisect, but the tests are
> red in 0.94.9 as well. We suspect it might be an environmental issue in
> CentOS, because the same tests run green in Ubuntu 14.04.
>
> Could you take a look and tell us if this should be considered a blocker
> for release? You can find all the details at
> http://tracker.ceph.com/issues/17151#note-62
>
> Thanks,
> Nathan

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
