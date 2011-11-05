From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] FileJournal: stop using sync_file_range
Date: Fri, 4 Nov 2011 17:29:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1111041723440.29096@cobra.newdream.net>
References: <20111103214508.GA19234@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60396 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab1KEA3H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 20:29:07 -0400
In-Reply-To: <20111103214508.GA19234@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org

On Thu, 3 Nov 2011, Christoph Hellwig wrote:
> Using sync_file_range means that neither any required metadata gets commited,
> nor the disk cache gets flushed.  Stop using it for the journal, and add
> a comment on why a fsync_range system call would be helpful here.

Sigh... doesn't that mean that sync_file_range is almost completely 
useless?  

(Okay, not completely useless; we use it in FileStore.cc to push data to 
disk quickly so that the eventual sync(2) is faster.)

> Btw, why does the code use O_SYNC (and not even O_DSYNC!) if using 
> direct I/O, but fdatasync/fsync for buffered I/O?  Avoiding cache 
> flushes and metadata updates for every writes is just as important for 
> direct I/O as it is for buffered I/O.

Good call.. looks like I added it in 2010-02 but I couldn't tell you why.  
:/

Thanks!
sage


> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: ceph/src/os/FileJournal.cc
> ===================================================================
> --- ceph.orig/src/os/FileJournal.cc	2011-11-03 22:27:35.304690331 +0100
> +++ ceph/src/os/FileJournal.cc	2011-11-03 22:40:02.244191569 +0100
> @@ -842,23 +842,26 @@ void FileJournal::do_write(bufferlist& b
>  
>    if (!directio) {
>      dout(20) << "do_write fsync" << dendl;
> +
> +    /*
> +     * We'd really love to have a fsync_range or fdatasync_range and do a:
> +     *
> +     *  if (split) {
> +     *    ::fsync_range(fd, header.max_size - split, split)l
> +     *    ::fsync_range(fd, get_top(), bl.length() - split);
> +     *  else
> +     *    ::fsync_range(fd, write_pos, bl.length())
> +     *
> +     * NetBSD and AIX apparently have it, and adding it to Linux wouldn't be
> +     * too hard given all the underlying infrastructure already exist.
> +     *
> +     * NOTE: using sync_file_range here would not be safe as it does not
> +     * flush disk caches or commits any sort of metadata.
> +     */
>  #if defined(DARWIN) || defined(__FreeBSD__)
>      ::fsync(fd);
>  #else
> -# ifdef HAVE_SYNC_FILE_RANGE
> -    if (is_bdev) {
> -      if (split) {
> -	::sync_file_range(fd, header.max_size - split, split, SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE);
> -	::sync_file_range(fd, get_top(), bl.length() - split, SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE);
> -	::sync_file_range(fd, header.max_size - split, split, SYNC_FILE_RANGE_WAIT_AFTER);
> -	::sync_file_range(fd, get_top(), bl.length() - split, SYNC_FILE_RANGE_WAIT_AFTER);
> -      } else {
> -	::sync_file_range(fd, write_pos, bl.length(),
> -			  SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER);
> -      }
> -    } else
> -# endif
> -      ::fdatasync(fd);
> +    ::fdatasync(fd);
>  #endif
>    }
>  
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
