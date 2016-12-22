From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: how to use teuthology-suite in the new world
Date: Thu, 22 Dec 2016 23:12:38 +0100
Message-ID: <9ea71ad4-b933-a55c-f92c-c2716e6c4645@suse.cz>
References: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757200AbcLVWMl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Dec 2016 17:12:41 -0500
In-Reply-To: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, "sepia@ceph.com" <sepia@ceph.com>

> Teuthology now defaults to https://github.com/ceph/ceph-ci.git instead of
> ceph.git.
>
> To schedule a test against something in ceph-ci.git,
>
>   teuthology-suite -s rados -c wip-foo
>
> To schedule against something in ceph.git (e.g., master),
>
>   teuthology-suite -s rados -c master --ceph-repo https://github.com/ceph/ceph.git

Understood, but this does not seem to work. In latest teuthology, when I 
specify "--ceph-repo https://github.com/ceph/ceph.git", the option is 
ignored.

Maybe I'm just doing something ignorant and/or stupid.

For details, see http://tracker.ceph.com/issues/18342

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
