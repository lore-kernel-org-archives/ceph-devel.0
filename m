From: Milosz Tanski <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv4 0/5] ceph: persistent caching with fscache
Date: Thu, 22 Aug 2013 08:58:02 -0400
Message-ID: <CANP1eJEwtoLVcF+v3dK+nv9W9zjF50opt06BHw=B2H2nO5kfvg@mail.gmail.com>
References: <cover.1375999914.git.milosz@adfin.com>
	<alpine.DEB.2.00.1308212203320.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1308212203320.1479-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Yan, Zheng" <zheng.z.yan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-cachefs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <linux-cachefs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Sage,

Thanks. If you run into any problems please let me know and I'll
resolve them quick and I'll make sure I'm watching the qa mailing
list.

- Milosz

On Thu, Aug 22, 2013 at 1:05 AM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi Milosz,
>
> I've pulled this into the ceph testing branch to make sure it holds up
> in qa.
>
> David, are the fscache patches here ready for the next merge window?  Do
> you have a preference for whose tree they go through?
>
> Thanks!
> sage
>
>
> On Wed, 21 Aug 2013, Milosz Tanski wrote:
>
>> This an updated version of the fscache support for the Ceph filesystem. What's
>> changed since the last patchset:
>>
>> 1. Sparater the readpages refactor into it's own patches. These were already
>>    accepted into the testing branch.
>>
>> 2. Tracked down the BUG in readahead cleanup code. We were returning with pages
>>    marked as private_2 from readpages(). I added a simple convenience function
>>    to the fscache netfs interface for cleaning up the page list at the end of
>>    asop readpages(). I know other filesystems (NFS) have ran into that since
>>    I've seen a few similar traces in Google search and the cachefs mailig list.
>>    The second patch new make Ceph use this interface.
>>
>> I've been running this code (minus the BUG fix) on clients for a couple weeks
>> with moderate 24/7 use without issues. At this point in time I feel like it's
>> solid enough to go into the ceph kclient.
>>
>> Please pull the code from my repository:
>> https://bitbucket.org/adfin/linux-fs.git branch: wip-ceph-fscache
>>
>> The first two patches I included were not written by me but were written by
>> Hongyi Jia. He implemented the cookie re-validation scheme into fscache core.
>>
>> Finally, I CCed a couple other mailing lists (fsdevel, nfs) because the new
>> fscache_readpages_cancel() should be used by other filesystems to avoid the
>> same problem.
>>
>>
>> Hongyi Jia (2):
>>   new cachefiles interface to check cache consistency
>>   new fscache interface to check cache consistency
>>
>> Milosz Tanski (3):
>>   ceph: use fscache as a local presisent cache
>>   fscache: netfs function for cleanup post readpages
>>   ceph: clean PgPrivate2 on returning from readpages
>>
>>  fs/cachefiles/interface.c     |  19 +++
>>  fs/cachefiles/internal.h      |   1 +
>>  fs/cachefiles/xattr.c         |  39 ++++++
>>  fs/ceph/Kconfig               |   9 ++
>>  fs/ceph/Makefile              |   2 +
>>  fs/ceph/addr.c                |  39 +++++-
>>  fs/ceph/cache.c               | 311 ++++++++++++++++++++++++++++++++++++++++++
>>  fs/ceph/cache.h               | 130 ++++++++++++++++++
>>  fs/ceph/caps.c                |  19 ++-
>>  fs/ceph/file.c                |  17 +++
>>  fs/ceph/inode.c               |  66 ++++++++-
>>  fs/ceph/super.c               |  47 ++++++-
>>  fs/ceph/super.h               |  17 +++
>>  fs/fscache/cookie.c           |  22 +++
>>  fs/fscache/page.c             |  16 +++
>>  include/linux/fscache-cache.h |   4 +
>>  include/linux/fscache.h       |  39 ++++++
>>  17 files changed, 785 insertions(+), 12 deletions(-)
>>  create mode 100644 fs/ceph/cache.c
>>  create mode 100644 fs/ceph/cache.h
>>
>> --
>> 1.8.1.2
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
