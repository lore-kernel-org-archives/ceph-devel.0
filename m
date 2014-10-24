From: Mark Nelson <mark.a.nelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: fio rbd hang for block sizes > 1M
Date: Fri, 24 Oct 2014 09:09:42 -0500
Message-ID: <544A5DA6.2010709@gmail.com>
References: <5449BBB3.7090109@catalyst.net.nz> <5449E50E.7000808@kernel.dk> <5449EEF1.1060407@catalyst.net.nz> <544A51C7.40803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <fio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <544A51C7.40803-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: fio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>, Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, fio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "d.gollub-+tb+GG71Y8CELgA04lAiVw@public.gmane.org >> Daniel Gollub" <d.gollub-+tb+GG71Y8CELgA04lAiVw@public.gmane.org>, "xan.peng" <xanpeng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

More info:

I went back and tested fio versions back to 2.1.10 and still encountered 
the issue.  I then went back and tested the v0.86 release versus giant 
and was able to get through a 4MB read test without error.  I suspect 
this is not an fio problem.  I'll try to narrow down the commit after 
0.86 that is causing this.

Mark

On 10/24/2014 08:19 AM, Mark Nelson wrote:
> FWIW we are seeing this at Redhat/Inktank with recent fio from master
> and ceph giant branch as well.
>
> Mark
>
> On 10/24/2014 01:17 AM, Mark Kirkwood wrote:
>> On 24/10/14 18:35, Jens Axboe wrote:
>>> CC'ing relevant parties, leaving email intact.
>>>
>>
>> Note that the 'Killed' is because I killed the run - it hangs and
>> appears to be non interruptable. I missed that when pasting, sorry!
>>
>>>> $ fio read-test.fio     # attached
>>>> rbd_thread: (g=0): rw=read, bs=2M-2M/2M-2M/2M-2M, ioengine=rbd,
>>>> iodepth=32
>>>> fio-2.1.13-88-gb2ee7
>>>> Starting 1 process
>>>> rbd engine: RBD version: 0.1.8
>>>> Killed1 (f=1): [R(1)] [inf% done] [0KB/0KB/0KB /s] [0/0/0 iops] [eta
>>>> 1158050441d:06h:59m:33s]
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fio" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
