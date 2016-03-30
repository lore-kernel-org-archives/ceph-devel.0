From: NeilBrown <neilb@suse.com>
Subject: Re: [GIT PULL] Ceph fixes for -rc7
Date: Wed, 30 Mar 2016 11:24:44 +1100
Message-ID: <874mbovmlv.fsf@notabene.neil.brown.name>
References: <alpine.DEB.2.11.1603052045320.25897@cpach.fuggernut.com> <87fuvfw6g9.fsf@notabene.neil.brown.name> <CAOi1vP9j8RCucc9DLoFUOXyBrGuTbN10hnQ0CwOE-PK=_j=k=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP9j8RCucc9DLoFUOXyBrGuTbN10hnQ0CwOE-PK=_j=k=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Mar 25 2016, Ilya Dryomov wrote:

> On Fri, Mar 25, 2016 at 5:02 AM, NeilBrown <neilb@suse.com> wrote:
>> On Sun, Mar 06 2016, Sage Weil wrote:
>>
>>> Hi Linus,
>>>
>>> Please pull the following Ceph patch from
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
>>>
>>> This is a final commit we missed to align the protocol compatibility with
>>> the feature bits.  It decodes a few extra fields in two different messages
>>> and reports EIO when they are used (not yet supported).
>>>
>>> Thanks!
>>> sage
>>>
>>>
>>> ----------------------------------------------------------------
>>> Yan, Zheng (1):
>>>       ceph: initial CEPH_FEATURE_FS_FILE_LAYOUT_V2 support
>>
>> Just wondering, but was CEPH_FEATURE_FS_FILE_LAYOUT_V2 supposed to have
>> exactly the same value as CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING (and
>> CEPH_FEATURE_CRUSH_TUNABLES5)??
>
> Yes, that was the point of getting it merged into -rc7.

I did wonder if that might be the case.

>
>> Because when I backported this patch (and many others) to some ancient
>> enterprise kernel, it caused mounts to fail.  If it really is meant to
>> be the same value, then I must have some other backported issue to find
>> and fix.
>
> It has to be backported in concert with changes that add support for
> the other two bits.

I have everything from fs/ceph and net/ceph as of 4.5, with adjustments
for different core code.

>                      How did mount fail?

"can't read superblock".
dmesg contains

[   50.822479] libceph: client144098 fsid 2b73bc29-3e78-490a-8fc6-21da1bf901ba
[   50.823746] libceph: mon0 192.168.1.122:6789 session established
[   51.635312] ceph: problem parsing mds trace -5
[   51.635317] ceph: mds parse_reply err -5
[   51.635318] ceph: mdsc_handle_reply got corrupt reply mds0(tid:1)

then a hex dump of header:, front: footer:

Maybe my MDS is causing the problem?  It is based on v10.0.5 which
contains

#define CEPH_FEATURE_CRUSH_TUNABLES5    (1ULL<<58) /* chooseleaf stable mode */
// duplicated since it was introduced at the same time as CEPH_FEATURE_CRUSH_TUN
#define CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING   (1ULL<<58) /* New, v7 encoding */

in ceph_features.h  i.e. two features using bit 58, but not
FS_FILE_LAYOUT_V2

Should I expect Linux 4.5 to work with ceph 10.0.5 ??

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW+xzNAAoJEDnsnt1WYoG5leEP/09A0T9BA0G93qnOl2ga6uX/
jJvgxHg3qKKAKNoGTRFIFHCq1t8XhUUvXpRyz3fMkLBghvr4h7UCFR8qLsrYp/Az
V/hG0IY4E66zi5JC95wk3kiTjQvoZJk1Bmt7cHxXrrw4L90bd1FNCWzuLNrdHX1R
VAB33u6zep4KftFHq9KIFN41bM8KJIrEmMPapjZ0L77WHFYB3XHANRF9pfnMezsv
0BKLCUDyaxXxECN9tXL2RVoqZ71Gze6On0hYeoALbezrfpJNhQHpF21RCTSjg9BM
gwMsPqzCQNwRpY9woCV+9QrSfsHCyDr4sYl75mBBXlTPW9FG+EWPh1juF7oh994Q
2dMGjoW6/YmcOd4UV7Oui/9S8G/o8u3crdqQZmirzFtuISFByJl3sVpI6JENSsKR
e/uzVz6R0LQ7oUtxls/lMf1MM1NxAyIBU58BhhJam8BkpmWq9SdpC6rEeQvM5ynv
iKhlKFoV59nExZSQu+UNIHTIzgX9GjTC2J1fzJ0sQxCf2zWxSziOy3yAcR5KyxeT
eUUEUPiCUiaoz4vLSFW3fPBqiaqYTbkmyv70B4fCHag2VV47w4CQWeSFU6n2mBkQ
PoiqIJYeFAle/fOK+glYRR7eqS5NPX/YKS8A8Nf0F4zfZlKz/J4n3yrRNYyp4OBS
98tnGHUidc6XjrxCnw5J
=aZx0
-----END PGP SIGNATURE-----
--=-=-=--
