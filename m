From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH] ceph: serialize the direct writes when couldn't
 submit in a single req
Date: Wed, 05 Feb 2020 11:38:54 -0500
Message-ID: <e9677dc33eecf80ee988e946cc84a4d9a9803d15.camel@kernel.org>
References: <20200204015445.4435-1-xiubli@redhat.com>
         <06b35b716c6f158360f2a21f00c3c1c0232562cc.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBEQi4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:38:56 -0500
In-Reply-To: <06b35b716c6f158360f2a21f00c3c1c0232562cc.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiubli@redhat.com, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Wed, 2020-02-05 at 11:24 -0500, Jeff Layton wrote:
> On Mon, 2020-02-03 at 20:54 -0500, xiubli@redhat.com wrote:
> > From: Xiubo Li <xiubli@redhat.com>
> > 
> > If the direct io couldn't be submit in a single request, for multiple
> > writers, they may overlap each other.
> > 
> > For example, with the file layout:
> > ceph.file.layout="stripe_unit=4194304 stripe_count=1 object_size=4194304
> > 
> > fd = open(, O_DIRECT | O_WRONLY, );
> > 
> > Writer1:
> > posix_memalign(&buffer, 4194304, SIZE);
> > memset(buffer, 'T', SIZE);
> > write(fd, buffer, SIZE);
> > 
> > Writer2:
> > posix_memalign(&buffer, 4194304, SIZE);
> > memset(buffer, 'X', SIZE);
> > write(fd, buffer, SIZE);
> > 
> > From the test result, the data in the file possiblly will be:
> > TTT...TTT <---> object1
> > XXX...XXX <---> object2
> > 
> > The expected result should be all "XX.." or "TT.." in both object1
> > and object2.
> > 
> 
> I really don't see this as broken. If you're using O_DIRECT, I don't
> believe there is any expectation that the write operations (or even read
> operations) will be atomic wrt to one another.
> 
> Basically, when you do this, you're saying "I know what I'm doing", and
> need to provide synchronization yourself between competing applications
> and clients (typically via file locking).
> 

In fact, here's a discussion about this from a couple of years ago. This
one mostly applies to local filesystems, but the same concepts apply to
CephFS as well:


https://www.spinics.net/lists/linux-fsdevel/msg118115.html

-- 
Jeff Layton <jlayton@kernel.org>
