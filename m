From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: What should be in the next hammer/firefly release ?
Date: Fri, 18 Sep 2015 10:10:15 -0600
Message-ID: <CAANLjFo8PVGox9+2ndKXUOqTVjAZvkDLUEeBD+XF3oycw4wVmw@mail.gmail.com>
References: <870DE8DBB716524BAE51B2D499EC81E40AB98467@g01jpexmbyt24>
	<CAANLjFo8Knp1OHy69fnxxtDE0WKzZkmk3U3yCPpW16pxtaKDtQ@mail.gmail.com>
	<55FBB5CF.30206@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35979 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbbIRQKR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Sep 2015 12:10:17 -0400
Received: by vkfp126 with SMTP id p126so32745111vkf.3
        for <ceph-devel@vger.kernel.org>; Fri, 18 Sep 2015 09:10:16 -0700 (PDT)
In-Reply-To: <55FBB5CF.30206@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Thanks, didn't find the original ticket number in the list.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Fri, Sep 18, 2015 at 12:57 AM, Loic Dachary  wrote:
> Hi Robert,
>
> http://tracker.ceph.com/issues/10399 was backported to hammer and wil=
l be in v0.94.4 (see http://tracker.ceph.com/issues/12751 for details).
>
> Cheers
>
> On 18/09/2015 02:44, Robert LeBlanc wrote:
>> Can we get http://tracker.ceph.com/issues/10399 into hammer. We hit =
this today.
>> ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>
>>
>> On Thu, Sep 10, 2015 at 4:57 AM, Miyamae, Takeshi  wrote:
>>> Hi Loic,
>>
>>> As the last pull request #5257 was committed into the main trunk,
>>> we believe all the SHEC codes in main trunk are ready to be backpor=
ted into Hammer branch.
>>> What can we do at this moment?
>>
>>> Best regards,
>>> Takeshi Miyamae
>>
>>> -----Original Message-----
>>> From: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>> Sent: Thursday, September 3, 2015 4:09 PM
>>> To: 'ceph-devel-owner@vger.kernel.org'
>>> Cc: Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com); Toshine, Naoyo=
shi/=E5=88=A9=E6=A0=B9 =E7=9B=B4=E4=BD=B3; Shiozawa, Kensuke/=E5=A1=A9=E6=
=B2=A2 =E8=B3=A2=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=
=E8=A9=94 (nakao.takanori@jp.fujitsu.com)
>>> Subject: Re: What should be in the next hammer/firefly release ?
>>
>>> Dear Loic,
>>
>>> We would like to let following two patches be backported to hammer =
v0.94.4.
>>> (And our wish is finally backporting these patches to RHCS v1.3.) C=
an it be possible? If possible, please let us know what should be start=
ed at first.
>>> (Caution: #5257 has not been committed to master branch yet.)
>>
>>> erasure-code: shec plugin feature #5493
>>> https://github.com/ceph/ceph/pull/5493
>>
>>> erasure code: shec performance optimization by decoding cache #5257
>>> https://github.com/ceph/ceph/pull/5257
>>
>>> Best regards,
>>> Takeshi Miyamae
>>
>>> -----Original Message-----
>>> From: Loic Dachary  dachary.org>
>>> Subject: What should be in the next hammer/firefly release ?
>>> Newsgroups: gmane.comp.file-systems.ceph.devel
>>> Date: 2015-09-02 11:00:53 GMT (15 hours and 32 minutes ago) Hi,
>>
>>> I added a link to
>>
>>> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO#Overview-=
of-the-backports-in-progress
>>
>>> to show all issues that should be in the next point release for
>>
>>> hammer v0.94.4 : http://tracker.ceph.com/versions/495
>>> firefly v0.80.11 : http://tracker.ceph.com/versions/480
>>
>>> Cheers
>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.1.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJV/DdkCRDmVDuy+mK58QAAB9wP/ilDxlotJ3ar6l46AjhB
hM9aytpLermhzOvznNkwrRXcRET7IZcBUeNv9lr2E1Elq56mM7d4nlvpJMME
KdfmvkfQYR1oiyKt0lJgG3Hl6ZCtzNRzWSEGp72yCpKmtK0/47PWQvQHdW8C
B88umZ1i1u16VuKEv8TdgySohJCXr/7gTMYrui7yQCBWoUWUaSSH+MV7UStx
vWM0806Xvvp3hfbrh5ffBk1ycLDaYDvW0+/vQJc0VJpGLn47u8TVjZrj1xZk
92B2TXwHdIMAQpF7xGFwVDbY+PkExRPWd8Yd75kxL7O+s+HYQIPU2nDo9qp8
PgXsXKr8Qu/WksbjVi8GEUj8rLrOPgoboqB+D6e4RpaZz4/gHt12aedQwbPj
hm6N4KOVr3oc5+QEAu81loC3d/uG4+BDwVTRRn4bt8+5ksOLDWeKdYOteBim
BvlyUt42ZlbDKQlr65a/h/v2C8asSvMM1NNhFl/NOM9k01wCY7/dNsWMeO0T
88gn4rAMNA9fpP1kZvFc5h7palKhPh2CVr9VuKyc45YBi8w8pCD2eYwgBjPN
R7LDbOgUhBjRtU/bqLY/KQYzG7o5VMuJp0MtY9HHDLXQyqR6GyMMUuKYFCX9
xREqJQStrTi1eQ7oeZ0gLcx9sd7WmWldb8OW6JTgJ7zu5rB8N3qu+V2JN2nn
OAW5
=3DM8sA
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
