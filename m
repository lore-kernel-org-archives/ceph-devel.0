From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2] ceph/iov_iter: fix bad iov_iter handling in ceph
 splice codepaths
Date: Thu, 12 Jan 2017 06:57:43 -0500
Message-ID: <1484222263.2970.23.camel@redhat.com>
References: <1483727016-343-1-git-send-email-jlayton@redhat.com>
         <1484053051-23685-1-git-send-email-jlayton@redhat.com>
         <20170112075946.GU1555@ZenIV.linux.org.uk>
         <CAOi1vP_EB5Eq6eGsDzVyYQpwDRYk=3JuTnro_EJRfqTNcYKknQ@mail.gmail.com>
         <20170112113743.GX1555@ZenIV.linux.org.uk>
         <CAOi1vP8Gu+Gc0+y8J5G9H14qGh=8o9SuHwYHKFQJgWy3vJQr8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP8Gu+Gc0+y8J5G9H14qGh=8o9SuHwYHKFQJgWy3vJQr8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhu, Caifeng" <zhucaifeng@unissoft-nj.com>
List-Id: ceph-devel.vger.kernel.org

On Thu, 2017-01-12 at 12:46 +0100, Ilya Dryomov wrote:
> On Thu, Jan 12, 2017 at 12:37 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > On Thu, Jan 12, 2017 at 12:13:31PM +0100, Ilya Dryomov wrote:
> > 
> > > 
> > > It would be a significant and wide-reaching change, but I've been
> > > meaning to look into switching to iov_iter for a couple of releases
> > > now.  There is a lot of ugly code in net/ceph/messenger.c to hangle
> > > iteration over "page vectors", "page lists" and "bio lists".  All of it
> > > predates iov_iter proliferation and is mostly incomplete anyway: IIRC
> > > you can send out of a pagelist but can't recv into a pagelist, etc.
> > 
> > Wait a sec...  Is it done from the same thread that has issued a syscall?
> > If so, we certainly could just pass iov_iter without bothering with any
> > form of ..._get_pages(); if not, we'll need at least to get from iovec
> > to bio_vec, since userland addresses make sense only in the caller's
> > context...
> 
> No, not necessarily - it's also used by rbd (all of net/ceph has two
> users: fs/ceph and drivers/block/rbd.c).
> 
> 

...and note that the actual send/receive is done from workqueue context
(AFAICT), so we might be operating over the array from a completely
different thread context from where it was submitted. I think we do need
to get page references at the point of submission like this.
-- 
Jeff Layton <jlayton@redhat.com>
