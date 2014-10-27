From: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>
Subject: Re: fio rbd completions (Was: fio rbd hang for block sizes > 1M)
Date: Tue, 28 Oct 2014 10:59:57 +1300
Message-ID: <544EC05D.7040807@catalyst.net.nz>
References: <5449BBB3.7090109@catalyst.net.nz> <5449E50E.7000808@kernel.dk> <5449EEF1.1060407@catalyst.net.nz> <544A51C7.40803@gmail.com> <544A5DA6.2010709@gmail.com> <544AD67D.4030603@catalyst.net.nz> <544AEAE7.6080603@redhat.com> <544AF0D2.1050405@catalyst.net.nz> <544B0C7F.4080109@catalyst.net.nz> <544B1D50.4010101@kernel.dk> <544B2C19.7070009@catalyst.net.nz> <544BF808.2090800@kernel.dk> <544C2371.1020403@catalyst.net.nz> <544E547C.30009@kernel.dk> <CAM9_UU9j2erdGT5kqKi_+5z5ERFMPO1hHwMk8kaFjLkGm-zp-g@mail.gmail.com> <544E6330.1000202@kernel.dk> <544E63EA.1010204@kernel.dk> <CAM9_UU-35i9uRu9EDQSM-b7CjmxrKYV2Gz8ocrykOYk+2q++hw@mail.gmail.com> <544E6691.106@kernel.dk> <CAM9_UU9_ZHtwv=31DyxkAmog7XJbthiRXi5n+Y0Cfxj4qm3bGQ@mail.gmail.com> <544E6A8D.1040608@kernel.dk> <CAM9_UU8x2uZZUWaPPoy+LH
 mUhC_3sqKZ9GPsEqDwKUkprg4kdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <fio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM9_UU8x2uZZUWaPPoy+LHmUhC_3sqKZ9GPsEqDwKUkprg4kdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: fio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ketor D <d.ketor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Cc: Mark Nelson <mark.nelson-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, Mark Nelson <mark.a.nelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, fio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "xan.peng" <xanpeng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 28/10/14 05:20, Ketor D wrote:
> V8 patch runs good.
>
> The iops is 33032. If I just comment the usleep(100) in the master, I
> can get iops 35245.
> The CPU usage about the two test is same 120%.
> So maybe this patch could be better!
>

Yeah, v8 is working for me.

I'm seeing it a bit slower for some blocksizes, but faster (or perhaps 
about the same within repeat measurement error) for others:

blocksize k |  patched iops | orig iops
------------+---------------+-----------
4           | 12265         | 11930
128         |  5800         |  7100
1024        |  1193         |  1196

Regards

Mark
