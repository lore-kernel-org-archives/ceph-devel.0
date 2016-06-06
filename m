From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: ceph / rocksdb
Date: Mon, 6 Jun 2016 12:43:05 +0200
Message-ID: <575553B9.8030707@suse.cz>
References: <20160224060546.GC6585@degu.b.linuxbox.com>
 <CALqRxCwrsTv=Lbrc98f7WLqwZxeySiAdq08E0h8a2eNyDU6SPQ@mail.gmail.com>
 <56CF6253.7020300@suse.cz> <9a087a20-84bf-dfdb-876d-0c0c4dec1123@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37832 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbcFFKnM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Jun 2016 06:43:12 -0400
In-Reply-To: <9a087a20-84bf-dfdb-876d-0c0c4dec1123@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> I know that this discussion has run for some time.
> And when I build a fresh clone, I ended up with a more recent rocksdb
> than that I'd liked....  (or actual Clang)
>
> But 3 trivial fixes further I could again compile, so I've committed
> those to the Rocksdb github, and they got accepted this morning.
> Now the trick question here is:
> 	How do they end up in the src/rocksdb tree?
>

Since rocksdb is built from a git submodule, the answer lies in

https://github.com/ceph/ceph/blob/master/.gitmodules#L15-L18

Which to me looks like it just takes the latest upstream rocksdb (branch 
defaults to "master").

Nathan
