From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [GIT PULL] Ceph fixes for -rc7
Date: Wed, 30 Mar 2016 10:04:15 +0200
Message-ID: <CAOi1vP-B7V5o0MdwmWe0FiwdFnyjv2B0SisL=BX3A3HXQ+JN-g@mail.gmail.com>
References: <alpine.DEB.2.11.1603052045320.25897@cpach.fuggernut.com>
	<87fuvfw6g9.fsf@notabene.neil.brown.name>
	<CAOi1vP9j8RCucc9DLoFUOXyBrGuTbN10hnQ0CwOE-PK=_j=k=w@mail.gmail.com>
	<874mbovmlv.fsf@notabene.neil.brown.name>
	<CAAM7YA=voB_7HnbzZqBBqyu9AU1DYYgw297hWfzdH6JBU61X1w@mail.gmail.com>
	<87poucu1rf.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87poucu1rf.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Sage Weil <sweil@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Mar 30, 2016 at 4:40 AM, NeilBrown <neilb@suse.com> wrote:
> On Wed, Mar 30 2016, Yan, Zheng wrote:
>
>> On Wed, Mar 30, 2016 at 8:24 AM, NeilBrown <neilb@suse.com> wrote:
>>> On Fri, Mar 25 2016, Ilya Dryomov wrote:
>>>
>>>> On Fri, Mar 25, 2016 at 5:02 AM, NeilBrown <neilb@suse.com> wrote:
>>>>> On Sun, Mar 06 2016, Sage Weil wrote:
>>>>>
>>>>>> Hi Linus,
>>>>>>
>>>>>> Please pull the following Ceph patch from
>>>>>>
>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
>>>>>>
>>>>>> This is a final commit we missed to align the protocol compatibility with
>>>>>> the feature bits.  It decodes a few extra fields in two different messages
>>>>>> and reports EIO when they are used (not yet supported).
>>>>>>
>>>>>> Thanks!
>>>>>> sage
>>>>>>
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> Yan, Zheng (1):
>>>>>>       ceph: initial CEPH_FEATURE_FS_FILE_LAYOUT_V2 support
>>>>>
>>>>> Just wondering, but was CEPH_FEATURE_FS_FILE_LAYOUT_V2 supposed to have
>>>>> exactly the same value as CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING (and
>>>>> CEPH_FEATURE_CRUSH_TUNABLES5)??
>>>>
>>>> Yes, that was the point of getting it merged into -rc7.
>>>
>>> I did wonder if that might be the case.
>>>
>>>>
>>>>> Because when I backported this patch (and many others) to some ancient
>>>>> enterprise kernel, it caused mounts to fail.  If it really is meant to
>>>>> be the same value, then I must have some other backported issue to find
>>>>> and fix.
>>>>
>>>> It has to be backported in concert with changes that add support for
>>>> the other two bits.
>>>
>>> I have everything from fs/ceph and net/ceph as of 4.5, with adjustments
>>> for different core code.
>>>
>>>>                      How did mount fail?
>>>
>>> "can't read superblock".
>>> dmesg contains
>>>
>>> [   50.822479] libceph: client144098 fsid 2b73bc29-3e78-490a-8fc6-21da1bf901ba
>>> [   50.823746] libceph: mon0 192.168.1.122:6789 session established
>>> [   51.635312] ceph: problem parsing mds trace -5
>>> [   51.635317] ceph: mds parse_reply err -5
>>> [   51.635318] ceph: mdsc_handle_reply got corrupt reply mds0(tid:1)
>>>
>>> then a hex dump of header:, front: footer:
>>>
>>> Maybe my MDS is causing the problem?  It is based on v10.0.5 which
>>> contains
>>>
>>> #define CEPH_FEATURE_CRUSH_TUNABLES5    (1ULL<<58) /* chooseleaf stable mode */
>>> // duplicated since it was introduced at the same time as CEPH_FEATURE_CRUSH_TUN
>>> #define CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING   (1ULL<<58) /* New, v7 encoding */
>>>
>>> in ceph_features.h  i.e. two features using bit 58, but not
>>> FS_FILE_LAYOUT_V2
>>>
>>> Should I expect Linux 4.5 to work with ceph 10.0.5 ??
>>
>> Sorry, cephfs in linux 4.5 does not work with 10.0.5. Please upgrade
>> to ceph 10.1.0
>>
>
> Ahhh..  I do wonder at the point of feature flags if they don't let you
> run any client with any server...
> Is there a compatability matrix published somewhere?
> If I have to stay with 10.0.5 (I don't know yet), it is safe to use
> Linux-4.4 code?

10.0.* are all development cuts, we didn't even built packages for
some of them.  10.1.0 is the first release candidate.  You can think of
10.0.5 as a random pre-rc1 kernel snapshot, aimed at brave testers, so
you do want to upgrade.

The reason it doesn't work is those three features are all defined to
the same value, but two of them got added earlier in the 10.0.* cycle.
CEPH_FEATURE_FS_FILE_LAYOUT_V2 came in last, after 10.0.5.

Thanks,

                Ilya
