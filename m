From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Subject: Re: [GIT PULL] Ceph updates and fixes for 3.13
Date: Sun, 24 Nov 2013 08:59:30 +0000
Message-ID: <5291BFF2.7080401@bob-the-boat.me.uk>
References: <alpine.DEB.2.00.1311231052450.12812@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.ip.uk.com ([81.2.115.98]:54110 "EHLO i01.ip.uk.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751176Ab3KXI7i (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 Nov 2013 03:59:38 -0500
Received: from [10.0.1.108]
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>)
	id 1VkVRI-0006fX-TR
	for ceph-devel@vger.kernel.org; Sun, 24 Nov 2013 08:53:12 +0000
In-Reply-To: <alpine.DEB.2.00.1311231052450.12812@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have just tried ceph 0.72.1 and kernel 3.13.0-rc1.

There seems to be a problem with ceph file system access from this kernel.

I mount a ceph running on another machine, that seems to go OK.

I create a directory on that mount, that seems to go OK.

I cal 'ls -l' that mount and all looks good.

I cannot remove the directory, nor can I write anything to the
directory. I get a message to the effect 'is not a directory'.

I step back to kernel 3.12.1 and all is well.

Does the message below explain this? Known issue to be fixed in rc2?

Thank you,
David

On 23/11/2013 19:16, Sage Weil wrote:
> Hi Linus,
>
> I just returned from two weeks off the grid to discover I'd miscalculated 
> and just missed the merge window.  If you're feeling inclined, there are a 
> few non-fixes mixed into this this request (improved readv/writev, nicer 
> behavior for unlinked files) that can be pulled from here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
>
> If not, I have a fixes only branch here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus-bugs-only
>
> These include a couple fixes to the new fscache code that went in during 
> the last cycle (which will need to go stable@ shortly as well), a couple 
> client-side directory fragmentation fixes, a fix for a race in the cap 
> release queuing path, and a couple race fixes in the request abort 
> and resend code.
>
> Obviously some of this could have gone into 3.12 final, but I preferred to 
> overtest rather than send things in for a late -rc, and then my travel 
> schedule intervened--my apologies there.
>
> Thanks!
> sage
>
>
> everything (for-linus):
>
> ----------------------------------------------------------------
> Li Wang (1):
>       ceph: allocate non-zero page to fscache in readpage()
>
> Milosz Tanski (1):
>       ceph: hung on ceph fscache invalidate in some cases
>
> Yan, Zheng (8):
>       ceph: remove outdated frag information
>       ceph: handle frag mismatch between readdir request and reply
>       ceph: drop unconnected inodes
>       ceph: queue cap release in __ceph_remove_cap()
>       ceph: set caps count after composing cap reconnect message
>       ceph: handle race between cap reconnect and cap release
>       ceph: cleanup aborted requests when re-sending requests.
>       ceph: wake up 'safe' waiters when unregistering request
>
> majianpeng (2):
>       ceph: Implement writev/pwritev for sync operation.
>       ceph: implement readv/preadv for sync operation
>
>  fs/ceph/addr.c       |    2 +-
>  fs/ceph/cache.c      |    3 +
>  fs/ceph/caps.c       |   27 ++--
>  fs/ceph/dir.c        |   11 +-
>  fs/ceph/file.c       |  435 +++++++++++++++++++++++++++++++++++---------------
>  fs/ceph/inode.c      |   59 ++++++-
>  fs/ceph/mds_client.c |   61 +++++--
>  fs/ceph/mds_client.h |    1 +
>  fs/ceph/super.c      |    1 +
>  fs/ceph/super.h      |    9 +-
>  10 files changed, 442 insertions(+), 167 deletions(-)
>
>
> or the bug fixes only (for-linus-bugs):
>
> ----------------------------------------------------------------
> Li Wang (1):
>       ceph: allocate non-zero page to fscache in readpage()
>
> Milosz Tanski (1):
>       ceph: hung on ceph fscache invalidate in some cases
>
> Yan, Zheng (7):
>       ceph: remove outdated frag information
>       ceph: handle frag mismatch between readdir request and reply
>       ceph: queue cap release in __ceph_remove_cap()
>       ceph: set caps count after composing cap reconnect message
>       ceph: handle race between cap reconnect and cap release
>       ceph: cleanup aborted requests when re-sending requests.
>       ceph: wake up 'safe' waiters when unregistering request
>
>  fs/ceph/addr.c       |    2 +-
>  fs/ceph/cache.c      |    3 +++
>  fs/ceph/caps.c       |   27 +++++++++++++---------
>  fs/ceph/dir.c        |   11 ++++++++-
>  fs/ceph/inode.c      |   49 +++++++++++++++++++++++++++++++++++-----
>  fs/ceph/mds_client.c |   61 +++++++++++++++++++++++++++++++++++++-------------
>  fs/ceph/mds_client.h |    1 +
>  fs/ceph/super.h      |    8 +------
>  8 files changed, 121 insertions(+), 41 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

