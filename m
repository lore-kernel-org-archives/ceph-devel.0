From: Xiaoguang Liu <syslxg@gmail.com>
Subject: Re: rbd create command fails to create image
Date: Mon, 9 Aug 2010 11:04:08 +0800
Message-ID: <AANLkTim3fw9wiJiodmkWsL8yd3Yy6xVOQb3OvLT-dLZS@mail.gmail.com>
References: <AANLkTim1YdtvJ4mnV2P8m3xyyPTdRvPDsQ8R1G3Xk6=x@mail.gmail.com>
	<AANLkTiksxkHQ-bJuKuE=sxGUpeBUcB16sjqmVRB4GkCU@mail.gmail.com>
	<AANLkTikyKWEObcbRJ1pTjMuEHOAXrRxiKO5ts+9m9cx0@mail.gmail.com>
	<Pine.LNX.4.64.1008060940300.26680@cobra.newdream.net>
	<i3jgk1$iog$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33683 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab0HIDEM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Aug 2010 23:04:12 -0400
Received: by qwh6 with SMTP id 6so6813079qwh.19
        for <ceph-devel@vger.kernel.org>; Sun, 08 Aug 2010 20:04:08 -0700 (PDT)
In-Reply-To: <i3jgk1$iog$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

I tried both ways. none of them worked.

BTW, Yehuda said the new class should be v1.2. why I saw 1.0.0 in the
error message:

Loading class: /usr/lib64/rados-classes/libcls_rbd.so.1.0.0: Error:
Could not detect class name.




On Sat, Aug 7, 2010 at 7:38 PM, Thomas Mueller <thomas@chaschperli.ch> =
wrote:
> Am Fri, 06 Aug 2010 09:44:16 -0700 schrieb Sage Weil:
>
>> Hi Xiaoguang,
>>
>> The problem is that /usr/lib/rados-classes/* shouldn't have symbols
>> stripped. =A0I'm no rpmbuild expert, but a search for 'rpmbuild stri=
p'
>> turned up a few things. =A0Can you see if the below patch fixes the
>> problem for you?
>>
>> Thanks!
>> sage
>>
>>
>> diff --git a/ceph.spec.in b/ceph.spec.in index 20e0251..f068edd 1006=
44
>> --- a/ceph.spec.in
>> +++ b/ceph.spec.in
>> @@ -64,6 +64,7 @@ conjunction with any FastCGI capable web server.
>> =A0make -j$(getconf _NPROCESSORS_ONLN) CFLAGS=3D"$RPM_OPT_FLAGS"
>> =A0CXXFLAGS=3D"$RPM_OPT_FLAGS"
>>
>> =A0%install
>> +export DONT_STRIP=3D1
>> =A0rm -rf $RPM_BUILD_ROOT
>> =A0make install DESTDIR=3D$RPM_BUILD_ROOT
>> =A0find $RPM_BUILD_ROOT -type f -name "*.la" -exec rm -f {} ';'
>
> I'm not a rpm expert either. :) but grepping /usr/lib/rpm did not rev=
eal
> any DONT_STRIP information.
>
> the strip'ing is done by "%__os_install_post" macro:
>
> %__os_install_post =A0 =A0 =A0 =A0\
> =A0 =A0 =A0/usr/lib/rpm/brp-compress \
> =A0 =A0 =A0/usr/lib/rpm/brp-strip \
> =A0 =A0 =A0/usr/lib/rpm/brp-strip-comment-note \
>
> maybe redefining it in spec like this:
>
> %define __os_install_post /usr/lib/rpm/brp-compress
>
> may help?
>
> either way, it disables strip'ing for all the files. Is this good? :)
>
> - Thomas
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
