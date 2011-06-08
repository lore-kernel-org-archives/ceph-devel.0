From: Sage Weil <sage@newdream.net>
Subject: Re: O_DIRECT change
Date: Tue, 7 Jun 2011 22:07:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106072133560.31726@cobra.newdream.net>
References: <Pine.LNX.4.64.1106030939020.27322@cobra.newdream.net>
 <BANLkTimgt0aW800==OCj72ocrAizJSfFjw@mail.gmail.com>
 <BANLkTi=-opE84qCKbzw0+3mjiJGP+Nzp6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56861 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1FHFFl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2011 01:05:41 -0400
In-Reply-To: <BANLkTi=-opE84qCKbzw0+3mjiJGP+Nzp6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 7 Jun 2011, Henry C Chang wrote:
> Hi Sage,
> 
> I checked the stripe_read function and think the following two patches
> are needed:
> 
> 1. Move hit_stripe/was_short checking after the adjustment of
> ceph_osdc_readpages return code
> 
>     Fix the following case:
>     (i) Create a sparse file
>         dd if=/dev/zero of=/mnt/fs_depot/dd3 bs=1 seek=1048576 count=0
> 
>     (ii) Read the file
>         dd if=/mnt/fs_depot/dd3 of=/root/ddout1 skip=8 bs=500 count=2
> iflag=direct
> 
> diff --git a/ceph/file.c b/ceph/file.c
> index 1f36e2c..6e6297a 100644
> --- a/ceph/file.c
> +++ b/ceph/file.c
> @@ -313,16 +313,18 @@ more:
>                 page_align = (pos - io_align + buf_align) & ~PAGE_MASK;
>         else
>                 page_align = pos & ~PAGE_MASK;
> +
>         this_len = left;
>         ret = ceph_osdc_readpages(&fsc->client->osdc, ceph_vino(inode),
>                                   &ci->i_layout, pos, &this_len,
>                                   ci->i_truncate_seq,
>                                   ci->i_truncate_size,
>                                   page_pos, pages_left, page_align);
> -       hit_stripe = this_len < left;
> -       was_short = ret >= 0 && ret < this_len;
>         if (ret == -ENOENT)
>                 ret = 0;
> +
> +       hit_stripe = this_len < left;
> +       was_short = ret >= 0 && ret < this_len;
>         dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
>              ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");

Good catch.  Applied.
 
> 2. Fix didpages and the starting position of ceph_zero_page_vector_range
> 
>     This fixes segfault caused by the following scenario:
>     (i) generate a sparse file by
>         dd if=/dev/urandom of=/mnt/fs_depot/dd10 bs=500 seek=8388 count=1
>     (ii) read the file from offset 4194300~500
>         dd if=/mnt/fs_depot/dd10 of=/root/dd10out bs=500 skip=8388 count=1
> 
> diff --git a/ceph/file.c b/ceph/file.c
> index 6e6297a..d7932bc 100644
> --- a/ceph/file.c
> +++ b/ceph/file.c
> @@ -291,7 +291,6 @@ static int striped_read(struct inode *inode,
>         struct ceph_inode_info *ci = ceph_inode(inode);
>         u64 pos, this_len;
>         int io_align, page_align;
> -       int page_off = off & ~PAGE_CACHE_MASK; /* first byte's offset in page */
>         int left, pages_left;
>         int read;
>         struct page **page_pos;
> @@ -329,12 +328,11 @@ more:
>              ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");
> 
>         if (ret > 0) {
> -               int didpages =
> -                       ((pos & ~PAGE_CACHE_MASK) + ret) >> PAGE_CACHE_SHIFT;
> +               int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> 
>                 if (read < pos - off) {
>                         dout(" zero gap %llu to %llu\n", off + read, pos);
> -                       ceph_zero_page_vector_range(page_off + read,
> +                       ceph_zero_page_vector_range(page_align + read,
>                                                     pos - off - read, pages);
>                 }
>                 pos += ret;
> @@ -359,7 +357,7 @@ more:
>                                 left = inode->i_size - pos;
> 
>                         dout("zero tail %d\n", left);
> -                       ceph_zero_page_vector_range(page_off + read, left,
> +                       ceph_zero_page_vector_range(page_align + read, left,
>                                                     pages);
>                         read += left;
>                 }

Sigh, the alignment adjustments still make my head hurt... Did you test 
this with O_DIRECT as well?  IIRC, the last time I worked on this code the 
problem was with O_DIRECT when the memory alignment didn't match the file 
offset.  Something like
  - allocate buffer with page + 512 alignment
  - read from offset 1024

I think what we really need is a series of tests that verify we get 
correct data with all combinations of file alignment, buffer alignment, 
O_DIRECT and sync (multiclient) io.  Probably that means writing with 
O_DIRECT, reading with buffered IO, and then writing with buffered IO and 
reading with O_DIRECT. We should also test the same thing across object 
boundaries.  I wonder if xfstests has something?

Unfortunately it's somewhat annoying to force the client into normal sync 
mode with a single client (you have to mount -o sync).  I wonder if it's 
worth adding an ioctl to set a flag on the fd to do this.

I can't find the test program I was using before, although I also remember 
not being happy with it... :/

Anyway, opening up an item in the tracker for this, #1147.

sage


