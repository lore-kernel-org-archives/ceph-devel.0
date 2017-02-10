From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v4 1/6] libceph: allow requests to return immediately on
 full conditions if caller wishes
Date: Fri, 10 Feb 2017 13:37:35 +0100
Message-ID: <CAOi1vP9G5x+A1xxYJ=G5V4gnWbGJ2g-qN0J9v9fo86VJqvrwzw@mail.gmail.com>
References: <20170209144836.12525-1-jlayton@redhat.com> <20170209144836.12525-2-jlayton@redhat.com>
 <D09ADECB-B744-4456-B174-2DFDA16D0A0E@redhat.com> <1486727549.4233.7.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35704 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbdBJNJf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2017 08:09:35 -0500
Received: by mail-ua0-f196.google.com with SMTP id 96so2822556uaq.2
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 05:08:22 -0800 (PST)
In-Reply-To: <1486727549.4233.7.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>

On Fri, Feb 10, 2017 at 12:52 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Fri, 2017-02-10 at 19:41 +0800, Yan, Zheng wrote:
>> > On 9 Feb 2017, at 22:48, Jeff Layton <jlayton@redhat.com> wrote:
>> >
>> > Usually, when the osd map is flagged as full or the pool is at quota,
>> > write requests just hang. This is not what we want for cephfs, where
>> > it would be better to simply report -ENOSPC back to userland instead
>> > of stalling.
>> >
>> > If the caller knows that it will want an immediate error return instead
>> > of blocking on a full or at-quota error condition then allow it to set a
>> > flag to request that behavior. Cephfs write requests will always set
>> > that flag.
>> >
>> > A later patch will deal with requests that were submitted before the new
>> > map showing the full condition came in.
>> >
>> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
>> > ---
>> > fs/ceph/addr.c                  | 4 ++++
>> > fs/ceph/file.c                  | 4 ++++
>> > include/linux/ceph/osd_client.h | 1 +
>> > net/ceph/osd_client.c           | 6 ++++++
>> > 4 files changed, 15 insertions(+)
>> >
>> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> > index 4547bbf80e4f..308787eeee2c 100644
>> > --- a/fs/ceph/addr.c
>> > +++ b/fs/ceph/addr.c
>> > @@ -1040,6 +1040,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>> >
>> >             req->r_callback = writepages_finish;
>> >             req->r_inode = inode;
>> > +           req->r_abort_on_full = true;
>> >
>> >             /* Format the osd request message and submit the write */
>> >             len = 0;
>> > @@ -1689,6 +1690,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
>> >     }
>> >
>> >     req->r_mtime = inode->i_mtime;
>> > +   req->r_abort_on_full = true;
>> >     err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
>> >     if (!err)
>> >             err = ceph_osdc_wait_request(&fsc->client->osdc, req);
>> > @@ -1732,6 +1734,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
>> >     }
>> >
>> >     req->r_mtime = inode->i_mtime;
>> > +   req->r_abort_on_full = true;
>> >     err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
>> >     if (!err)
>> >             err = ceph_osdc_wait_request(&fsc->client->osdc, req);
>> > @@ -1893,6 +1896,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
>> >     err = ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
>> >
>> >     wr_req->r_mtime = ci->vfs_inode.i_mtime;
>> > +   wr_req->r_abort_on_full = true;
>> >     err2 = ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
>> >
>> >     if (!err)
>>
>> do you ignore writepage_nounlock() case intentionally?
>>
>>
>>
> No. Hmmm...writepage_nounlock calls ceph_osdc_writepages, and it's the
> only caller so I guess we'll need to set this there. Maybe we should
> just lift ceph_osdc_writepages into ceph.ko since there are no callers
> in libceph?

Set it in ceph_osdc_new_request() -- it's only user is ceph.ko.  It
should cover all filesystem OSD requests, except for pool check and
ceph_aio_retry_work().

Thanks,

                Ilya
