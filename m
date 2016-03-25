From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [GIT PULL] Ceph fixes for -rc7
Date: Fri, 25 Mar 2016 10:34:20 +0100
Message-ID: <CAOi1vP9j8RCucc9DLoFUOXyBrGuTbN10hnQ0CwOE-PK=_j=k=w@mail.gmail.com>
References: <alpine.DEB.2.11.1603052045320.25897@cpach.fuggernut.com>
	<87fuvfw6g9.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87fuvfw6g9.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Sage Weil <sweil@redhat.com>, torvalds@linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Mar 25, 2016 at 5:02 AM, NeilBrown <neilb@suse.com> wrote:
> On Sun, Mar 06 2016, Sage Weil wrote:
>
>> Hi Linus,
>>
>> Please pull the following Ceph patch from
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
>>
>> This is a final commit we missed to align the protocol compatibility with
>> the feature bits.  It decodes a few extra fields in two different messages
>> and reports EIO when they are used (not yet supported).
>>
>> Thanks!
>> sage
>>
>>
>> ----------------------------------------------------------------
>> Yan, Zheng (1):
>>       ceph: initial CEPH_FEATURE_FS_FILE_LAYOUT_V2 support
>
> Just wondering, but was CEPH_FEATURE_FS_FILE_LAYOUT_V2 supposed to have
> exactly the same value as CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING (and
> CEPH_FEATURE_CRUSH_TUNABLES5)??

Yes, that was the point of getting it merged into -rc7.

> Because when I backported this patch (and many others) to some ancient
> enterprise kernel, it caused mounts to fail.  If it really is meant to
> be the same value, then I must have some other backported issue to find
> and fix.

It has to be backported in concert with changes that add support for
the other two bits.  How did mount fail?

Thanks,

                Ilya
