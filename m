From: Milosz Tanski <milosz@adfin.com>
Subject: Re: fscache recursive hang -- similar to loopback
	NFS issues
Date: Mon, 21 Jul 2014 07:42:38 -0400
Message-ID: <CANP1eJEVnH2w7t6r8g1ow07UNWRA8bPduwD-FezqCBKB_J_=XQ@mail.gmail.com>
References: <CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
	<20140721164044.2845f3fd@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <20140721164044.2845f3fd@notabene.brown>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: NeilBrown <neilb@suse.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
List-Id: ceph-devel.vger.kernel.org

Neil,

That's the same thing exact fix I started testing on Saturday. I found that
there already is a wait_event_timeout (even without your recent changes).
The thing I'm not quite sure is what timeout it should use? A quick search
through references on LXR shows that it's use anywhere in fs code except
for debug cases (btrfs) and network filesystem.

- Milosz


On Mon, Jul 21, 2014 at 2:40 AM, NeilBrown <neilb@suse.de> wrote:

> On Sat, 19 Jul 2014 16:20:01 -0400 Milosz Tanski <milosz@adfin.com> wrote:
>
> > Neil,
> >
> > I saw your recent patcheset for improving the wait_on_bit interface
> > (particular: SCHED: allow wait_on_bit_action functions to support a
> > timeout.) I'm looking on some guidance on leveraging that work to
> > solve other recursive lock hang in fscache.
> >
> > I've ran into similar issues you're trying to solve with loopback NFS
> > but in the fscache code. This happens under heavy vma preasure when
> > the kernel is aggressively trying to trim the page cache.
> >
> > The hang is caused by this serious of events
> > 1. cachefiles_write_page - cachefiles (the fscache backend, sitting on
> > ext4) tries to write page to disk
> > 2. ext4 tries to allocate a page in writeback (without GPF_NOFS and
> > with wait flag)
> > 3. due to vma preasure the kernel tries to free-up pages
> > 4. this causes release pages in ceph to be called
> > 5. the selected page is cached page in process of write out (from step
> #1)
> > 6. fscache_wait_on_page_write hangs forever
> >
> > Is there a solution that you have to NFS as another patch that
> > implements the timeout that I can use a template? I'm not familiar
> > with that piece of the code base.
>
> It looks like the comment in  __fscache_maybe_release_page
>
>         /* We will wait here if we're allowed to, but that could deadlock
> the
>          * allocator as the work threads writing to the cache may all end
> up
>          * sleeping on memory allocation, so we may need to impose a
> timeout
>          * too. */
>
> is correct when it says "we may need to impose a timeout".
> The following __fscache_wait_on_page_write() needs to timeout.
>
> However that doesn't use wait_on_bit(), it just has a simple wait_event.
> So something like this should fix it (or should at least move the problem
> along a bit).
>
> NeilBrown
>
>
>
> diff --git a/fs/fscache/page.c b/fs/fscache/page.c
> index ed70714503fa..58035024c5cf 100644
> --- a/fs/fscache/page.c
> +++ b/fs/fscache/page.c
> @@ -43,6 +43,13 @@ void __fscache_wait_on_page_write(struct fscache_cookie
> *cookie, struct page *pa
>  }
>  EXPORT_SYMBOL(__fscache_wait_on_page_write);
>
> +void __fscache_wait_on_page_write_timeout(struct fscache_cookie *cookie,
> struct page *page, unsigned long timeout)
> +{
> +       wait_queue_head_t *wq = bit_waitqueue(&cookie->flags, 0);
> +
> +       wait_event_timeout(*wq, !__fscache_check_page_write(cookie, page),
> timeout);
> +}
> +
>  /*
>   * decide whether a page can be released, possibly by cancelling a store
> to it
>   * - we're allowed to sleep if __GFP_WAIT is flagged
> @@ -115,7 +122,7 @@ page_busy:
>         }
>
>         fscache_stat(&fscache_n_store_vmscan_wait);
> -       __fscache_wait_on_page_write(cookie, page);
> +       __fscache_wait_on_page_write_timeout(cookie, page, HZ);
>         gfp &= ~__GFP_WAIT;
>         goto try_again;
>  }
>
>
>
>


-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
