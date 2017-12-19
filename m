From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC v2 PATCH 2/4] ceph: quota: add initial infrastructure to support cephfs quotas
Date: Tue, 19 Dec 2017 10:59:24 +0000
Message-ID: <87mv2f9e5v.fsf@suse.com>
References: <20171218153902.7455-1-lhenriques@suse.com>
        <20171218153902.7455-3-lhenriques@suse.com>
        <CAAM7YA=kDH==QbPX0_OeQwX8e4=t4WzsgGw3wV_=zziYVg-Q1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757935AbdLSK71 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 19 Dec 2017 05:59:27 -0500
In-Reply-To: <CAAM7YA=kDH==QbPX0_OeQwX8e4=t4WzsgGw3wV_=zziYVg-Q1Q@mail.gmail.com>
        (Zheng Yan's message of "Tue, 19 Dec 2017 17:24:38 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>

"Yan, Zheng" <ukernel@gmail.com> writes:
<snip>
>> +       /* lookup inode */
>> +       vino.ino = le64_to_cpu(h->ino);
>> +       vino.snap = CEPH_NOSNAP;
>> +       inode = ceph_find_inode(sb, vino);
>
> check null

Ah, nice catch.  I'll add that check, thanks.

Cheers,
-- 
Luis
