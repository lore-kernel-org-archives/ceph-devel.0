From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Oct 14 (ceph)
Date: Mon, 14 Oct 2013 13:51:09 -0700
Message-ID: <525C593D.4080607@infradead.org>
References: <1381762088-18880-1-git-send-email-treding@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381762088-18880-1-git-send-email-treding@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>
List-Id: ceph-devel.vger.kernel.org

On 10/14/13 07:48, Thierry Reding wrote:
> Hi all,
> 
> I've uploaded today's linux-next tree to the master branch of the
> repository below:
> 
>         git://gitorious.org/thierryreding/linux-next.git
> 
> A next-20131014 tag is also provided for convenience.
> 
> Gained a few conflicts, but nothing too exciting. x86 and ARM default
> configurations build fine. There were some build failures unrelated to
> the merge, most of which I fixed and added as patches on top of the
> final merge.

on i386:

fs/ceph/file.c: In function 'ceph_sync_read':
fs/ceph/file.c:437:25: error: 'struct iov_iter' has no member named 'iov'
fs/ceph/file.c:438:18: error: 'struct iov_iter' has no member named 'iov'
fs/ceph/file.c:470:26: error: 'struct iov_iter' has no member named 'iov'
fs/ceph/file.c:472:9: error: 'struct iov_iter' has no member named 'iov'
fs/ceph/file.c:472:9: error: 'struct iov_iter' has no member named 'iov'
fs/ceph/file.c:472:9: warning: comparison of distinct pointer types lacks a cast [enabled by default]
fs/ceph/file.c: In function 'ceph_sync_direct_write':
fs/ceph/file.c:586:24: error: 'struct iov_iter' has no member named 'iov'
fs/ceph/file.c:587:14: error: 'struct iov_iter' has no member named 'iov'
fs/ceph/file.c: In function 'ceph_sync_write':
fs/ceph/file.c:737:18: warning: comparison of distinct pointer types lacks a cast [enabled by default]




-- 
~Randy
