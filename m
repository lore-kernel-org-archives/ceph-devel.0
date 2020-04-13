From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] ceph: have ceph_mdsc_free_path ignore ERR_PTR values
Date: Mon, 13 Apr 2020 22:41:53 +0300
Message-ID: <20200413194153.GD14511@kadam>
References: <20200408142125.52908-1-jlayton@kernel.org>
 <20200408142125.52908-2-jlayton@kernel.org>
 <CAOi1vP99BbHFrrg+0HAbZrZV7DQ7EG7euTY6cbtdWajsdyN3jQ@mail.gmail.com>
 <ded1b71dcda70e3a249df21c294607dac6545694.camel@kernel.org>
 <CAOi1vP9mZTShECrVVohuj4p=Yr+rWvWnXNY03c85CuO4fGNSyQ@mail.gmail.com>
 <55c47d66b579fcf5749376c73d681d0273095f6d.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:33976 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387935AbgDMTmL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2020 15:42:11 -0400
Content-Disposition: inline
In-Reply-To: <55c47d66b579fcf5749376c73d681d0273095f6d.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>

On Mon, Apr 13, 2020 at 09:23:22AM -0400, Jeff Layton wrote:
> > > I don't see a problem with having a "free" routine ignore IS_ERR values
> > > just like it does NULL values. How about I just trim off the other
> > > deltas in this patch? Something like this?
> > 
> > I think it encourages fragile code.  Less so than functions that
> > return pointer, NULL or IS_ERR pointer, but still.  You yourself
> > almost fell into one of these traps while editing debugfs.c ;)
> > 
> 
> We'll have to agree to disagree here. Having a free routine ignore
> ERR_PTR values seems perfectly reasonable to me.

Freeing things which haven't been allocated is a constant source bugs.

err:
	kfree(foo->bar);
	kfree(foo);

Oops...  "foo" wasn't allocated so the first line will crash.  Every
other day someone commits code like that.

regards,
dan carpenter
