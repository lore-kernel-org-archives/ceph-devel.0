From: NeilBrown <neilb@suse.com>
Subject: Re: [GIT PULL] Ceph fixes for -rc7
Date: Wed, 30 Mar 2016 13:40:20 +1100
Message-ID: <87poucu1rf.fsf@notabene.neil.brown.name>
References: <alpine.DEB.2.11.1603052045320.25897@cpach.fuggernut.com> <87fuvfw6g9.fsf@notabene.neil.brown.name> <CAOi1vP9j8RCucc9DLoFUOXyBrGuTbN10hnQ0CwOE-PK=_j=k=w@mail.gmail.com> <874mbovmlv.fsf@notabene.neil.brown.name> <CAAM7YA=voB_7HnbzZqBBqyu9AU1DYYgw297hWfzdH6JBU61X1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50356 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbcC3Ck3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Mar 2016 22:40:29 -0400
In-Reply-To: <CAAM7YA=voB_7HnbzZqBBqyu9AU1DYYgw297hWfzdH6JBU61X1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sweil@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Wed, Mar 30 2016, Yan, Zheng wrote:

> On Wed, Mar 30, 2016 at 8:24 AM, NeilBrown <neilb@suse.com> wrote:
>> On Fri, Mar 25 2016, Ilya Dryomov wrote:
>>
>>> On Fri, Mar 25, 2016 at 5:02 AM, NeilBrown <neilb@suse.com> wrote:
>>>> On Sun, Mar 06 2016, Sage Weil wrote:
>>>>
>>>>> Hi Linus,
>>>>>
>>>>> Please pull the following Ceph patch from
>>>>>
>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
>>>>>
>>>>> This is a final commit we missed to align the protocol compatibility with
>>>>> the feature bits.  It decodes a few extra fields in two different messages
>>>>> and reports EIO when they are used (not yet supported).
>>>>>
>>>>> Thanks!
>>>>> sage
>>>>>
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Yan, Zheng (1):
>>>>>       ceph: initial CEPH_FEATURE_FS_FILE_LAYOUT_V2 support
>>>>
>>>> Just wondering, but was CEPH_FEATURE_FS_FILE_LAYOUT_V2 supposed to have
>>>> exactly the same value as CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING (and
>>>> CEPH_FEATURE_CRUSH_TUNABLES5)??
>>>
>>> Yes, that was the point of getting it merged into -rc7.
>>
>> I did wonder if that might be the case.
>>
>>>
>>>> Because when I backported this patch (and many others) to some ancient
>>>> enterprise kernel, it caused mounts to fail.  If it really is meant to
>>>> be the same value, then I must have some other backported issue to find
>>>> and fix.
>>>
>>> It has to be backported in concert with changes that add support for
>>> the other two bits.
>>
>> I have everything from fs/ceph and net/ceph as of 4.5, with adjustments
>> for different core code.
>>
>>>                      How did mount fail?
>>
>> "can't read superblock".
>> dmesg contains
>>
>> [   50.822479] libceph: client144098 fsid 2b73bc29-3e78-490a-8fc6-21da1bf901ba
>> [   50.823746] libceph: mon0 192.168.1.122:6789 session established
>> [   51.635312] ceph: problem parsing mds trace -5
>> [   51.635317] ceph: mds parse_reply err -5
>> [   51.635318] ceph: mdsc_handle_reply got corrupt reply mds0(tid:1)
>>
>> then a hex dump of header:, front: footer:
>>
>> Maybe my MDS is causing the problem?  It is based on v10.0.5 which
>> contains
>>
>> #define CEPH_FEATURE_CRUSH_TUNABLES5    (1ULL<<58) /* chooseleaf stable mode */
>> // duplicated since it was introduced at the same time as CEPH_FEATURE_CRUSH_TUN
>> #define CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING   (1ULL<<58) /* New, v7 encoding */
>>
>> in ceph_features.h  i.e. two features using bit 58, but not
>> FS_FILE_LAYOUT_V2
>>
>> Should I expect Linux 4.5 to work with ceph 10.0.5 ??
>
> Sorry, cephfs in linux 4.5 does not work with 10.0.5. Please upgrade
> to ceph 10.1.0
>

Ahhh..  I do wonder at the point of feature flags if they don't let you
run any client with any server...
Is there a compatability matrix published somewhere?
If I have to stay with 10.0.5 (I don't know yet), it is safe to use
Linux-4.4 code?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW+zyUAAoJEDnsnt1WYoG5YyQP/jLy6cV5Mxk7W3kSb7fDAQ4e
WLDpHH4CLRqRRKmdlqjh3jV6w3gLHA1lxe8OTWVqgQf6KZkc3K7v4E2tSAq8/yD/
iDq6Sfpyxp2bZFjzqoPRdrv/QYsD56KvGdhWwMedkmoTXWB+FSZX67G7qtOacX9O
d8kcGgXD331a36XbqRUEp5ZCSfYhk3pnmv6iC2bonmBPYB678Mq8+xL155GZbWFR
C9FbaCLW0uqK8F9Fh72/KMMuUZy1xlsDry63/sYbXvrBq9uh/0uuir80iGmWikGp
aNC/E7f0W/HoJ5DNsYwj5JKOh/Jj3xLiagcHEpildQIwejcvhaeWqCP8EZtvyj78
2ooX+kWZ9R+eQVntSYniHb9h5TgQFgw4K06T3P6ObGXb0Smos8sElgSAvwoV8YzJ
3cCOaXEMCoeuUwdVW1SX/4Cwf+FN3ox1rxtktGG4WBlNP1SAbKpM1j4G09+SW6Xb
7aKoaerXPBICSTUSBEsttnAjGVMIyuBaiv0ZZbdKbUHkVHpYlx06znvWIG6auar3
hxqp12sV1989enn/djhm4brvdX3qiuhC2edmWyZ50Lc3IOr01azlA5hTRI3NBuIA
bhzHjnuzYL6dCf7tlJIBPdXFLtvluL86bBDJs/EatX2DMJ0gVQcgPBpMDXgA6WrB
iW1sZsCZtnEBfth7NC9+
=OUNk
-----END PGP SIGNATURE-----
--=-=-=--
