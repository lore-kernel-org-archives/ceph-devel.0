From: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Subject: Re: fio rbd hang for block sizes > 1M
Date: Fri, 24 Oct 2014 08:30:27 -0600
Message-ID: <544A6283.5050400@kernel.dk>
References: <5449BBB3.7090109@catalyst.net.nz> <5449E50E.7000808@kernel.dk> <5449EEF1.1060407@catalyst.net.nz> <544A51C7.40803@gmail.com> <544A5DA6.2010709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <fio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <544A5DA6.2010709-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: fio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Nelson <mark.a.nelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>, fio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "d.gollub-+tb+GG71Y8CELgA04lAiVw@public.gmane.org >> Daniel Gollub" <d.gollub-+tb+GG71Y8CELgA04lAiVw@public.gmane.org>, "xan.peng" <xanpeng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 2014-10-24 08:09, Mark Nelson wrote:
> More info:
>
> I went back and tested fio versions back to 2.1.10 and still encountered
> the issue.  I then went back and tested the v0.86 release versus giant
> and was able to get through a 4MB read test without error.  I suspect
> this is not an fio problem.  I'll try to narrow down the commit after
> 0.86 that is causing this.

Thanks, it doesn't look like a fio problem if it's dependent on the 
block size used. Might warrant a check in the fio configure script, so 
we can fail (or limit) read sizes on the problematic versions.

-- 
Jens Axboe
