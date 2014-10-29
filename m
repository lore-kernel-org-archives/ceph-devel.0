From: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Subject: Re: fio rbd completions (Was: fio rbd hang for block sizes > 1M)
Date: Wed, 29 Oct 2014 08:31:35 -0600
Message-ID: <5450FA47.2030203@kernel.dk>
References: <5449BBB3.7090109@catalyst.net.nz> <CAM9_UU9j2erdGT5kqKi_+5z5ERFMPO1hHwMk8kaFjLkGm-zp-g@mail.gmail.com> <544E6330.1000202@kernel.dk> <544E63EA.1010204@kernel.dk> <CAM9_UU-35i9uRu9EDQSM-b7CjmxrKYV2Gz8ocrykOYk+2q++hw@mail.gmail.com> <544E6691.106@kernel.dk> <CAM9_UU9_ZHtwv=31DyxkAmog7XJbthiRXi5n+Y0Cfxj4qm3bGQ@mail.gmail.com> <544E6A8D.1040608@kernel.dk> <CAM9_UU8x2uZZUWaPPoy+LHmUhC_3sqKZ9GPsEqDwKUkprg4kdQ@mail.gmail.com> <544EC05D.7040807@catalyst.net.nz> <544EC7F1.6010900@kernel.dk> <544ED37D.6060800@catalyst.net.nz> <CAM9_UU8MHdj+mjAWBziETxPDnwTt0JBuHrQp2Fu9YtF=msae3w@mail.gmail.com> <79432849-2F58-4738-82E1-E4D8AB10A6AE@kernel.dk> <CAM9_UU9G5vQ68UxMakte-Wb5B9_KBo24ov7=hNHpYqEtko2nQg@mail.gmail.com> <544FB2F2.2060703@kernel.dk> <CAM9_UU_o8kS1wJnDKTvd8+qkm9=93yfW3THr_8ni8C+5=TH6
 tg@mail.gmail.com> <544FCDBD.7070106@kernel.dk> <CAM9_UU-gyExbAEo608vGnjqBk56A_VRZc44HkywUuLmXoEZ4Cg@mail.gmail.com> <CAM9_UU8=MtUnQiembBfr8YQiDOD7TNey=mp8_H6gySenRVHy6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <fio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM9_UU8=MtUnQiembBfr8YQiDOD7TNey=mp8_H6gySenRVHy6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: fio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ketor D <d.ketor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>, Mark Nelson <mark.nelson-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, Mark Nelson <mark.a.nelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "fio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <fio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xan.peng" <xanpeng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 2014-10-29 01:15, Ketor D wrote:
> Hi, Jens,
>
> There is cmdline parse bug in the fio rbd test.
>
> I have fixed this and create a pull request on the github.
>
> Please review.
>
> After fix the bugs, the fio test can run.

I merged your two pull requests (thanks!) and committed a polished 
variant of the sort patch. Ketor and Mark, would you mind both running a 
quick benchmark on the current -git head?

-- 
Jens Axboe
