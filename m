From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: check negative offsets on ceph_llseek()
Date: Thu, 17 Aug 2017 19:57:01 +0200
Message-ID: <CAOi1vP9RYiFuscyJqetRO3p68Bj14To5whwM6EByvtjChCk0_g@mail.gmail.com>
References: <20170728105640.16268-1-lhenriques@suse.com> <87pobuz4s2.fsf@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pobuz4s2.fsf@hermes>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Aug 17, 2017 at 3:45 PM, Luis Henriques <lhenriques@suse.com> wrote:
> Luis Henriques <lhenriques@suse.com> writes:
>
>> When a user requests SEEK_HOLE or SEEK_DATA with a negative offset
>> ceph_llseek should return -ENXIO.  Currently -EINVAL is being returned for
>> SEEK_DATA and 0 for SEEK_HOLE.
>
> Ping
>
> This patch should make xfstest generic/448 happy.

It should or it does? ;)

I saw generic/448 failures on ext4 with Darrick's recent test change,
haven't tried ceph yet.

Thanks,

                Ilya
