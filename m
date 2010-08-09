From: Xiaoguang Liu <syslxg@gmail.com>
Subject: Re: rbd create command fails to create image
Date: Mon, 9 Aug 2010 14:27:02 +0800
Message-ID: <AANLkTinm1ggHCsLz-oRKCN+ToWNijizRnDGOnTNk2dj4@mail.gmail.com>
References: <AANLkTim1YdtvJ4mnV2P8m3xyyPTdRvPDsQ8R1G3Xk6=x@mail.gmail.com>
	<AANLkTiksxkHQ-bJuKuE=sxGUpeBUcB16sjqmVRB4GkCU@mail.gmail.com>
	<AANLkTikyKWEObcbRJ1pTjMuEHOAXrRxiKO5ts+9m9cx0@mail.gmail.com>
	<Pine.LNX.4.64.1008060940300.26680@cobra.newdream.net>
	<i3jgk1$iog$1@dough.gmane.org>
	<AANLkTim3fw9wiJiodmkWsL8yd3Yy6xVOQb3OvLT-dLZS@mail.gmail.com>
	<AANLkTi=F-mBp+5CiYevxczhn_LdLb0zqxrJq0e9RdLho@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50203 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab0HIG1E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Aug 2010 02:27:04 -0400
Received: by qyk7 with SMTP id 7so6048268qyk.19
        for <ceph-devel@vger.kernel.org>; Sun, 08 Aug 2010 23:27:02 -0700 (PDT)
In-Reply-To: <AANLkTi=F-mBp+5CiYevxczhn_LdLb0zqxrJq0e9RdLho@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Thomas Mueller <thomas@chaschperli.ch>, ceph-devel@vger.kernel.org

Thanks Yehuda,

your command works. I can finally get rbd work on unstable code.



On Mon, Aug 9, 2010 at 11:48 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Sun, Aug 8, 2010 at 8:04 PM, Xiaoguang Liu <syslxg@gmail.com> wrot=
e:
>> I tried both ways. none of them worked.
>>
>> BTW, Yehuda said the new class should be v1.2. why I saw 1.0.0 in th=
e
>> error message:
>>
>> Loading class: /usr/lib64/rados-classes/libcls_rbd.so.1.0.0: Error:
>> Could not detect class name.
>>
>
> The 1.0.0 is the shared object version number, not really related to
> the class version. This should work:
>
> =A0$ ceph class add -i /usr/lib64/rados-classes/libcls_rbd.so.1.0.0 r=
bd 1.2 x86-64
>
> We do need to find some better solution for cases where the binaries
> are stripped. Currently we avoid stripping all the symbols that have
> __cls inside and we encode the class name and version there, e.g.:
> 0000000000209734 B __cls_name__rbd
> 0000000000209730 B __cls_ver__1_2
>
> Then we run the cclsinfo script on the binary and it gets the class
> name and version out of the shared object, along with the architectur=
e
> it was compiled on. We'd like to be able to keep all the different
> classes for the different architecture in the same place.
> Probably another solution that doesn't require all this hackery will
> just hold the class name and version in the shared object filename
> and we'll put the shared objects under a subdir per architecture.
>
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
