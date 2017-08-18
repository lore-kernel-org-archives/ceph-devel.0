From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: check negative offsets on ceph_llseek()
Date: Fri, 18 Aug 2017 10:32:06 +0200
Message-ID: <CAOi1vP91UHDMws-9WH=T8BCYJTUSyUXgyX7w6ScB-Lv0NE7pMw@mail.gmail.com>
References: <20170728105640.16268-1-lhenriques@suse.com> <87pobuz4s2.fsf@hermes>
 <CAOi1vP9RYiFuscyJqetRO3p68Bj14To5whwM6EByvtjChCk0_g@mail.gmail.com> <87lgmixck8.fsf@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87lgmixck8.fsf@hermes>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Aug 17, 2017 at 8:40 PM, Luis Henriques <lhenriques@suse.com> wrote:
> Ilya Dryomov <idryomov@gmail.com> writes:
>
>> On Thu, Aug 17, 2017 at 3:45 PM, Luis Henriques <lhenriques@suse.com> wrote:
>>> Luis Henriques <lhenriques@suse.com> writes:
>>>
>>>> When a user requests SEEK_HOLE or SEEK_DATA with a negative offset
>>>> ceph_llseek should return -ENXIO.  Currently -EINVAL is being returned for
>>>> SEEK_DATA and 0 for SEEK_HOLE.
>>>
>>> Ping
>>>
>>> This patch should make xfstest generic/448 happy.
>>
>> It should or it does? ;)
>>
>
> Heh, it *does* make generic/448 happy.
>
>>
>> I saw generic/448 failures on ext4 with Darrick's recent test
>>change,
>> haven't tried ceph yet.
>
> The generic/448 test currently fails with the error codes described in
> the commit log.  I didn't found it useful to include in the commit
> log, but here's the full test output:
>
> File system supports the default behavior.
> File system does not support unwritten extents.
> File system magic#: 0xc36400
> Allocation size: 4194304
> 18. Test file with negative SEEK_{HOLE,DATA} offsets
> 18.01 SEEK_HOLE expected -1 or -1, got 0.                         FAIL
> 18.02 SEEK_DATA expected -1 with errno -6, got -22.               FAIL
>
> seek sanity check failed!

Applied.

Thanks,

                Ilya
