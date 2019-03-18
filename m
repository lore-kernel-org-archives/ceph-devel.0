From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
Date: Mon, 18 Mar 2019 10:55:45 +0000
Message-ID: <87lg1czc26.fsf@suse.com>
References: <20190312142019.30936-1-lhenriques@suse.com>
        <20190312142019.30936-3-lhenriques@suse.com>
        <CAAM7YAmMBv1Z4Etp5yf9K=RqpTNF0kJ3tsiAysfs_wv9mdNG8w@mail.gmail.com>
        <CAJ4mKGZ3a9xq4HkR3JQ0yRyBCh1acm0YEz14OBUK+bQFzbVEDg@mail.gmail.com>
        <CAAM7YAmt+OS8=ycPrtLLe_FqeD2F_szdkShNAPA49FOPoJd+Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAmt+OS8=ycPrtLLe_FqeD2F_szdkShNAPA49FOPoJd+Gg@mail.gmail.com>
        (Zheng Yan's message of "Mon, 18 Mar 2019 17:12:39 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hendrik Peyerl <hpeyerl@plusline.net>
List-Id: ceph-devel.vger.kernel.org

"Yan, Zheng" <ukernel@gmail.com> writes:

> On Mon, Mar 18, 2019 at 5:06 PM Gregory Farnum <gfarnum@redhat.com> wrote:
>>
>> On Mon, Mar 18, 2019 at 2:32 PM Yan, Zheng <ukernel@gmail.com> wrote:
>> > After reading the code carefully. I feel a little uncomfortable with
>> > the "lookup_ino" in get_quota_realm.  how about populating directories
>> > above the 'mount subdir' during mounting (similar to cifs_get_root ).

Wouldn't it be a problem if the directory layout (or, in this case, the
snaprealm layout) change during the mount lifetime?  In that case we
would need to do this lookup anyway.

>>
>> Isn't that going to be a problem for any clients which have
>>restricted filesystem access permissions? They may not be able to see
>>all the directories above their mount point.  -Greg
>
> using lookup_ino to get inode above the "mount subdir" has the same problem
>

In this case I believe we get an -EPERM from the MDS.  And then the
client simply falls back to the 'default' behaviour, which is to allow
the user to create/write to files as if there were no quotas set.

Cheers,
-- 
Luis
