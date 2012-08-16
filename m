From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Ceph setup on single node : prob with "
Date: Fri, 17 Aug 2012 10:01:02 +1200
Message-ID: <502D6D9E.2020802@catalyst.net.nz>
References: <CAGfy=6mCWNY4mn2_H3b=8FENmY=2SGXUB78RObprSdvzye_h1g@mail.gmail.com> <CADvuQRFzjzKO4OC20jvKZMKUx29o5sKmjxVFAm2vqAc2eufiMw@mail.gmail.com> <CAGfy=6nJR+jRmM8sVaWOOjwm+DXfjTQ762K9JhLpxyRYt0eghQ@mail.gmail.com> <CADvuQREJp_v=ywHPPe-WVZfgmhua-pYwUz+duedo54XXt9usAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050709060006070001090504"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:38117 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab2HPWBF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 18:01:05 -0400
In-Reply-To: <CADvuQREJp_v=ywHPPe-WVZfgmhua-pYwUz+duedo54XXt9usAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: hemant surale <hemant.surale@gmail.com>, ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050709060006070001090504
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/12 04:13, Tommi Virtanen wrote:
> On Wed, Aug 15, 2012 at 9:44 PM, hemant surale <hemant.surale@gmail.com> wrote:
>> Hello Tommi, Ceph community
>>
>> I did mkdir the directory. Infact I have created a new partition by
>> the same name and formatted using ext3. I also executed the following
>> command for the partition/directory:
>>
>> "mount -o remount,user_xattr /"
> Remounting root with extended attributes isn't really relevant; what
> you care about is /ceph_data/osd.0.
>
> Please share output of
>
> mount
> ls /ceph_data/osd.0
> --
>

Also I think there are a few things wrong with his ceph.conf (see 
attached....was sent to me in private email).

I think he needs to:
- correct bogus host entries (myserver01, alpha)
- specify keyring for mds

Making these changes (with hostnames appropriate for my setup) I can 
mkcephfs with his ceph.conf

Cheers

Mark

--------------050709060006070001090504
Content-Type: text/plain; charset=UTF-8;
 name="ceph.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ceph.conf"

W2dsb2JhbF0KICAgICAgIGF1dGggc3VwcG9ydGVkID0gY2VwaHgKICAgICAgIGtleXJpbmcg
PSAvZXRjL2NlcGgvY2VwaC5rZXlyaW5nCgpbbW9uXQogICAgICAgIG1vbiBkYXRhID0gL2Nl
cGhfZGF0YS9tb24uJGlkCgpbbWRzXQoKW29zZF0KICAgICAgICBvc2QgZGF0YSA9IC9jZXBo
X2RhdGEvb3NkLiRpZAogICAgICAgIG9zZCBqb3VybmFsID0gL2NlcGhfZGF0YS9vc2QuJGlk
LmpvdXJuYWwKICAgICAgICBvc2Qgam91cm5hbCBzaXplID0gMTAwMAoKW21vbi5hbHBoYV0K
ICAgICAgICBob3N0ID0gbXlzZXJ2ZXIwMQogICAgICAgIG1vbiBhZGRyID0gMTAuNzIuMTQ3
LjI0OTo2Nzg5Cgpbb3NkLjBdCiAgICAgICAgaG9zdCA9IGhlbWFudC12aXJ0dWFsLW1hY2hp
bmUKClttZHMuMF0KICAgICAgICBob3N0ID0gaGVtYW50LXZpcnR1YWwtbWFjaGluZQoKCgo=
--------------050709060006070001090504--
