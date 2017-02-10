From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v4 1/6] libceph: allow requests to return immediately on
 full conditions if caller wishes
Date: Fri, 10 Feb 2017 07:44:50 -0500
Message-ID: <1486730690.4233.12.camel@redhat.com>
References: <20170209144836.12525-1-jlayton@redhat.com>
         <20170209144836.12525-2-jlayton@redhat.com>
         <D09ADECB-B744-4456-B174-2DFDA16D0A0E@redhat.com>
         <1486727549.4233.7.camel@redhat.com>
         <CAOi1vP9G5x+A1xxYJ=G5V4gnWbGJ2g-qN0J9v9fo86VJqvrwzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36707 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbdBJObU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2017 09:31:20 -0500
Received: by mail-qt0-f175.google.com with SMTP id k15so35947124qtg.3
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 06:31:20 -0800 (PST)
In-Reply-To: <CAOi1vP9G5x+A1xxYJ=G5V4gnWbGJ2g-qN0J9v9fo86VJqvrwzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>

On Fri, 2017-02-10 at 13:37 +0100, Ilya Dryomov wrote:
> On Fri, Feb 10, 2017 at 12:52 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > On Fri, 2017-02-10 at 19:41 +0800, Yan, Zheng wrote:
> > > > On 9 Feb 2017, at 22:48, Jeff Layton <jlayton@redhat.com> wrote:
> > > > 
> > > > Usually, when the osd map is flagged as full or the pool is at quota,
> > > > write requests just hang. This is not what we want for cephfs, where
> > > > it would be better to simply report -ENOSPC back to userland instead
> > > > of stalling.
> > > > 
> > > > If the caller knows that it will want an immediate error return instead
> > > > of blocking on a full or at-quota error condition then allow it to set a
> > > > flag to request that behavior. Cephfs write requests will always set
> > > > that flag.
> > > > 
> > > > A later patch will deal with requests that were submitted before the new
> > > > map showing the full condition came in.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > > ---
> > > > fs/ceph/addr.c                  | 4 ++++
> > > > fs/ceph/file.c                  | 4 ++++
> > > > include/linux/ceph/osd_client.h | 1 +
> > > > net/ceph/osd_client.c           | 6 ++++++
> > > > 4 files changed, 15 insertions(+)
> > > > 
> > > > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > > > index 4547bbf80e4f..308787eeee2c 100644
> > > > --- a/fs/ceph/addr.c
> > > > +++ b/fs/ceph/addr.c
> > > > @@ -1040,6 +1040,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> > > > 
> > > >             req->r_callback = writepages_finish;
> > > >             req->r_inode = inode;
> > > > +           req->r_abort_on_full = true;
> > > > 
> > > >             /* Format the osd request message and submit the write */
> > > >             len = 0;
> > > > @@ -1689,6 +1690,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
> > > >     }
> > > > 
> > > >     req->r_mtime = inode->i_mtime;
> > > > +   req->r_abort_on_full = true;
> > > >     err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > > >     if (!err)
> > > >             err = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > > > @@ -1732,6 +1734,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
> > > >     }
> > > > 
> > > >     req->r_mtime = inode->i_mtime;
> > > > +   req->r_abort_on_full = true;
> > > >     err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > > >     if (!err)
> > > >             err = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > > > @@ -1893,6 +1896,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
> > > >     err = ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
> > > > 
> > > >     wr_req->r_mtime = ci->vfs_inode.i_mtime;
> > > > +   wr_req->r_abort_on_full = true;
> > > >     err2 = ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
> > > > 
> > > >     if (!err)
> > > 
> > > do you ignore writepage_nounlock() case intentionally?
> > > 
> > > 
> > > 
> > 
> > No. Hmmm...writepage_nounlock calls ceph_osdc_writepages, and it's the
> > only caller so I guess we'll need to set this there. Maybe we should
> > just lift ceph_osdc_writepages into ceph.ko since there are no callers
> > in libceph?
> 
> Set it in ceph_osdc_new_request() -- it's only user is ceph.ko.  It
> should cover all filesystem OSD requests, except for pool check and
> ceph_aio_retry_work().
> 

Ok. The flag will end up being set on reads as well, but we don't
actually do anything with the flag on a read request so that should be
fine. I'll do that.

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
