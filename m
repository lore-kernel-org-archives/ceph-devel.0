From: NeilBrown <neilb@suse.com>
Subject: Re: [GIT PULL] Ceph fixes for -rc7
Date: Thu, 31 Mar 2016 13:18:59 +1100
Message-ID: <87wpojs830.fsf@notabene.neil.brown.name>
References: <alpine.DEB.2.11.1603052045320.25897@cpach.fuggernut.com> <87fuvfw6g9.fsf@notabene.neil.brown.name> <CAOi1vP9j8RCucc9DLoFUOXyBrGuTbN10hnQ0CwOE-PK=_j=k=w@mail.gmail.com> <874mbovmlv.fsf@notabene.neil.brown.name> <CAAM7YA=voB_7HnbzZqBBqyu9AU1DYYgw297hWfzdH6JBU61X1w@mail.gmail.com> <87poucu1rf.fsf@notabene.neil.brown.name> <CAOi1vP-B7V5o0MdwmWe0FiwdFnyjv2B0SisL=BX3A3HXQ+JN-g@mail.gmail.com> <CAJ4mKGZ0-yJdAnkHu-w2s8jenp30izyobQCov9wBvanbgDBpew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ4mKGZ0-yJdAnkHu-w2s8jenp30izyobQCov9wBvanbgDBpew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory Farnum <gfarnum@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Sage Weil <sweil@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Mar 31 2016, Gregory Farnum wrote:

> On Wed, Mar 30, 2016 at 1:04 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> On Wed, Mar 30, 2016 at 4:40 AM, NeilBrown <neilb@suse.com> wrote:
>>> On Wed, Mar 30 2016, Yan, Zheng wrote:
>>>
>>>> On Wed, Mar 30, 2016 at 8:24 AM, NeilBrown <neilb@suse.com> wrote:
>>>>> On Fri, Mar 25 2016, Ilya Dryomov wrote:
>>>>>
>>>>>> On Fri, Mar 25, 2016 at 5:02 AM, NeilBrown <neilb@suse.com> wrote:
>>>>>>> On Sun, Mar 06 2016, Sage Weil wrote:
>>>>>>>
>>>>>>>> Hi Linus,
>>>>>>>>
>>>>>>>> Please pull the following Ceph patch from
>>>>>>>>
>>>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
>>>>>>>>
>>>>>>>> This is a final commit we missed to align the protocol compatibility with
>>>>>>>> the feature bits.  It decodes a few extra fields in two different messages
>>>>>>>> and reports EIO when they are used (not yet supported).
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>> sage
>>>>>>>>
>>>>>>>>
>>>>>>>> ----------------------------------------------------------------
>>>>>>>> Yan, Zheng (1):
>>>>>>>>       ceph: initial CEPH_FEATURE_FS_FILE_LAYOUT_V2 support
>>>>>>>
>>>>>>> Just wondering, but was CEPH_FEATURE_FS_FILE_LAYOUT_V2 supposed to have
>>>>>>> exactly the same value as CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING (and
>>>>>>> CEPH_FEATURE_CRUSH_TUNABLES5)??
>>>>>>
>>>>>> Yes, that was the point of getting it merged into -rc7.
>>>>>
>>>>> I did wonder if that might be the case.
>>>>>
>>>>>>
>>>>>>> Because when I backported this patch (and many others) to some ancient
>>>>>>> enterprise kernel, it caused mounts to fail.  If it really is meant to
>>>>>>> be the same value, then I must have some other backported issue to find
>>>>>>> and fix.
>>>>>>
>>>>>> It has to be backported in concert with changes that add support for
>>>>>> the other two bits.
>>>>>
>>>>> I have everything from fs/ceph and net/ceph as of 4.5, with adjustments
>>>>> for different core code.
>>>>>
>>>>>>                      How did mount fail?
>>>>>
>>>>> "can't read superblock".
>>>>> dmesg contains
>>>>>
>>>>> [   50.822479] libceph: client144098 fsid 2b73bc29-3e78-490a-8fc6-21da1bf901ba
>>>>> [   50.823746] libceph: mon0 192.168.1.122:6789 session established
>>>>> [   51.635312] ceph: problem parsing mds trace -5
>>>>> [   51.635317] ceph: mds parse_reply err -5
>>>>> [   51.635318] ceph: mdsc_handle_reply got corrupt reply mds0(tid:1)
>>>>>
>>>>> then a hex dump of header:, front: footer:
>>>>>
>>>>> Maybe my MDS is causing the problem?  It is based on v10.0.5 which
>>>>> contains
>>>>>
>>>>> #define CEPH_FEATURE_CRUSH_TUNABLES5    (1ULL<<58) /* chooseleaf stable mode */
>>>>> // duplicated since it was introduced at the same time as CEPH_FEATURE_CRUSH_TUN
>>>>> #define CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING   (1ULL<<58) /* New, v7 encoding */
>>>>>
>>>>> in ceph_features.h  i.e. two features using bit 58, but not
>>>>> FS_FILE_LAYOUT_V2
>>>>>
>>>>> Should I expect Linux 4.5 to work with ceph 10.0.5 ??
>>>>
>>>> Sorry, cephfs in linux 4.5 does not work with 10.0.5. Please upgrade
>>>> to ceph 10.1.0
>>>>
>>>
>>> Ahhh..  I do wonder at the point of feature flags if they don't let you
>>> run any client with any server...
>>> Is there a compatability matrix published somewhere?
>>> If I have to stay with 10.0.5 (I don't know yet), it is safe to use
>>> Linux-4.4 code?
>>
>> 10.0.* are all development cuts, we didn't even built packages for
>> some of them.  10.1.0 is the first release candidate.  You can think of
>> 10.0.5 as a random pre-rc1 kernel snapshot, aimed at brave testers, so
>> you do want to upgrade.
>>
>> The reason it doesn't work is those three features are all defined to
>> the same value, but two of them got added earlier in the 10.0.* cycle.
>> CEPH_FEATURE_FS_FILE_LAYOUT_V2 came in last, after 10.0.5.
>
> A little more specifically: these feature bits do let you run any
> client with any "real release" of Ceph that we expect not-testers to
> be using. They *usually* work on our dev releases as well, but we've
> gotten stingier about it as we come close to running out of feature
> bits and are trying to pack more of them into the same actual bits
> (we're working on freeing them up as well, but got started a little
> later than is comfortable), while coordinating code merges between a
> few different places. You got unlucky here.
> -Greg

Thanks - you've been most helpful.

I'll see if we can use 10.1.0 for the MDS etc.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/IkTAAoJEDnsnt1WYoG5w/QP/3XDIdskKQf5MrZ8KmFUXJgE
p/eiU47EZQbghU8KOVG0tGTGSjWhNWEt5B0fguGV08eCad/+BN51fGjAHluqIfeI
6XcdV/uKexOWgdUtEEok7LUczFuaHtSL0YwZdf6ixUANpRnFSWP8dhGdg9PBdRKY
8mWY20Zg2mZLTv18qgkVjYK1W6zsm+v/B2u/cI/7fZBzs2upWkFO7Xyb9obnDPI/
De3pf3Mf6YctMq4wYjcHaUC8YUwjL8pTdU8y3hALZZLVyAtS6GRDmf71G4weAFko
9mELZDCueLt6SFqmtVWuKg1PzYia8A2JZuwjwn/JvyouztkZs/vbMAut7g122Qsc
+6PAMUIPk4TspWwijcW4k0zph3S8oX/coR/xEq2yUuOSBNdlRJLYpbDVAxaRRusU
BIvhCjUSL8tptUQaBLAy2SHx4koUDLivL7Os9KTa0grRcu86iBGoLPmpdle+hmQ3
faY3vV7y9GvDY6rrCKYkFABM/46XLV8rDv/iMaNEqrgMGojP/glNUBZjGFOxNBca
48hjVFvEIgg826TLgXrYLTbTBlbXSEuL0yJhQTp544RLsC1jhFvuspA2iH+c+c4N
nEImwgJ2wS/CMQLT9/M4UL0aixtffiOvPHDQQBf+W49jGwEUCopBX7W4A/i9YUAX
eKplilAQcvs1dg7siik6
=84Gh
-----END PGP SIGNATURE-----
--=-=-=--
