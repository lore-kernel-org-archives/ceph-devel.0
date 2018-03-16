From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: only dirty ITER_IOVEC pages for direct read
Date: Fri, 16 Mar 2018 13:23:03 +0800
Message-ID: <CAAM7YAnEGKy=iG8t_e-g-Jk=UC1UBUkMwMCUHpFKkXXq9KGaxg@mail.gmail.com>
References: <20180316033212.30543-1-zyan@redhat.com> <20180316034018.GA1120@zzz.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
In-Reply-To: <20180316034018.GA1120@zzz.localdomain>
Resent-Message-ID: <_vknqdC86DK.A.CRC.9h1qaB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/CAAM7YAnEGKy=iG8t_e-g-Jk=UC1UBUkMwMCUHpFKkXXq9KGaxg@mail.gmail.com
To: Eric Biggers <ebiggers3@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, debian-kernel@lists.debian.org, Kaipeng Zeng <kaipeng94@gmail.com>, syzkaller@googlegroups.com
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 16, 2018 at 11:40 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> Hi Yan,
>
> On Fri, Mar 16, 2018 at 11:32:12AM +0800, Yan, Zheng wrote:
>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>> ---
>>  fs/ceph/file.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>
> Fixes for use-after-free bugs should be marked for stable.  The commit message
> should also explain what is being fixed, exactly.  Mentioning that this bug was
> found by syzkaller would also be useful, since people are looking out for those.
>

I added Reported-by and CC stale to  the patch in our testing branch

https://github.com/ceph/ceph-client/commit/cfcd7a9e2d7faf5601b4731ea5a9eff7751981aa

Regards
Yan, Zheng


> Thanks,
>
> Eric
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
