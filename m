From: Ketor D <d.ketor@gmail.com>
Subject: Re: fio rbd completions (Was: fio rbd hang for block sizes > 1M)
Date: Tue, 28 Oct 2014 23:49:44 +0800
Message-ID: <CAM9_UU_o8kS1wJnDKTvd8+qkm9=93yfW3THr_8ni8C+5=TH6tg@mail.gmail.com>
References: <5449BBB3.7090109@catalyst.net.nz> <544AEAE7.6080603@redhat.com>
 <544AF0D2.1050405@catalyst.net.nz> <544B0C7F.4080109@catalyst.net.nz>
 <544B1D50.4010101@kernel.dk> <544B2C19.7070009@catalyst.net.nz>
 <544BF808.2090800@kernel.dk> <544C2371.1020403@catalyst.net.nz>
 <544E547C.30009@kernel.dk> <CAM9_UU9j2erdGT5kqKi_+5z5ERFMPO1hHwMk8kaFjLkGm-zp-g@mail.gmail.com>
 <544E6330.1000202@kernel.dk> <544E63EA.1010204@kernel.dk> <CAM9_UU-35i9uRu9EDQSM-b7CjmxrKYV2Gz8ocrykOYk+2q++hw@mail.gmail.com>
 <544E6691.106@kernel.dk> <CAM9_UU9_ZHtwv=31DyxkAmog7XJbthiRXi5n+Y0Cfxj4qm3bGQ@mail.gmail.com>
 <544E6A8D.1040608@kernel.dk> <CAM9_UU8x2uZZUWaPPoy+LHmUhC_3sqKZ9GPsEqDwKUkprg4kdQ@mail.gmail.com>
 <544EC05D.7040807@catalyst.net.nz> <544EC7F1.6010900@kernel.dk>
 <544ED37D.6060800@catalyst.net.nz> <CAM9_UU8MHdj+mjAWBziETxPDnwTt0JBuHrQp2Fu9YtF=msae3w@mail.gmail.com>
 <79432849-2F58-4738-82E1-E4D8AB10A6AE@kernel.dk> <CAM9_UU9G5vQ68UxMakte-Wb5B9_KBo24ov7=hNHpYqEtko2nQg@mail.gmail.com>
 <544FB2F2.2060703@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:60954 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaJ1PuP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 11:50:15 -0400
In-Reply-To: <544FB2F2.2060703@kernel.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, Mark Nelson <mark.nelson@inktank.com>, Mark Nelson <mark.a.nelson@gmail.com>, "fio@vger.kernel.org" <fio@vger.kernel.org>, "xan.peng" <xanpeng@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Cannot get the new commited code from github now.
When I get the newest code, I will test.

2014-10-28 23:14 GMT+08:00 Jens Axboe <axboe@kernel.dk>:
> On 2014-10-27 22:49, Ketor D wrote:
>>
>> Agree. Busy loop is only for test.
>> I will try the current git.
>
>
> Committed two more rbd changes:
>
> - Add support for rbd_invalidate_cache() (if it exists)
> - Use rbd_aio_is_complete() instead of using fri->io_complete. The latter
> should have some locking to ensure it's always seen, so it's better to use
> the API provided function to determine whether this IO is done or not.
>
> Unless we often hit the complete race, I would not expect this to make much
> of a difference. But it's worth testing in any case, especially since my two
> attempts at setting up ceph + rbd have failed miserably. So I still can't
> test myself.
>
> --
> Jens Axboe
>
