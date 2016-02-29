From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Getting cython to define ENODATA on FreeBSD. (Was: Re: [ceph]
 pybind: move cephfs to Cython (#7745))
Date: Mon, 29 Feb 2016 14:26:58 +0100
Message-ID: <56D44722.6000801@digiware.nl>
References: <56D446DD.1020302@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:18323 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298AbcB2N1a (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Feb 2016 08:27:30 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 9234F1534ED
	for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 14:27:26 +0100 (CET)
Received: from [192.168.101.175] (vpn.ecoracks.nl [31.223.170.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 4FAF31534EF
	for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 14:26:58 +0100 (CET)
In-Reply-To: <56D446DD.1020302@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 29-2-2016 12:57, Mehdi Abaakouk wrote:
> Hi,
>=20
> Le 2016-02-29 11:27, Willem Jan Withagen a =C3=A9crit :
>> Hi,
>>
>> You write:
>>
>> If you have errno.pxd, and cimport won't work, perhaps that means yo=
u
>> have something wrong with your cython package. Cython/Includes/libc =
is
>> automatically included on Linux for cython compilation and it looks =
not
>> on FreeBSD.
>>
>> But probably is one of the  issues that lies ahead of this, is the f=
act
>> that in
>>     /usr/include/errno.h FreeBSD does not define ENODATA.
>> And thus during compilation that value is not known (anywhere)
>>
>> In most of the Ceph code it is replaced by ENOATTR.
>=20
>> I did not picked that but others that did work before me. And whatev=
er
>> choice you make it is going to break somewhere nayways.
>>
>> Now the question here is going to be how to educate cython to actual=
ly
>> pickup on this change....
>> Perhaps by adding an extra include that "overlays" the current one a=
nd
>> adds errno.ENODATA to the errno enum?
>>
>> I do not know enough of python/cython how to do that, or that it is =
even
>> possible?
>=20
> If a Cython headers (*.pyd) have ENODATA, you need to fix it.
>=20
> So, the only good solution for that is fixing cython for FreeBSD, I
> don't see why you would add crap in Ceph here.
>=20
> I'm sure the FreeBSD community is open and aware about not existing
> ENODATA on their system, and regulary patch application to remove it.
> You just have to fix the FreeBSD Cython Package (or even upstream Cyt=
hon
> if they officially support FreeBSD).

Hi,

I'm a member of the FreeBSD community since 1993. :)

The reason that it is not in FreeBSD is might be  because the standard
does not require it. :(

------
IEEE Std 1003.1 2004 says that ENODATA is an 'XSR' extension:

"The functionality described is optional. The functionality described i=
s
also an extension to the ISO C standard."

ENODATA appears to be mandatory.
-------

And as such it might be, might not be able to get it into the FreeBSD
include files. However that will take a long time, and during that time
I will not be able to complete the tests required to run all tests for
=46reeBSD.

And as such is the 'crap' you refer too, a consequence of using
extensions to the standard for software, thus hampering the portability=
=2E
Uptil now I've been able to tackle just about all the issues.
And if I remember correctly this one wasn't an issue in my previous
testruns until the python piece got ripped out, and replaced with cytho=
n.

So I you ( or anybody else on this list) know(s) any ways to keep me
going with porting I'd be very thankful.

--WjW

I will also try to raise the issue in the FreeBSD lists.



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
