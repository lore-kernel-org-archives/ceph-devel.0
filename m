From: Simon Tian <aixt2006@gmail.com>
Subject: Re: async+direct IO in osd journal write
Date: Mon, 22 Aug 2011 11:08:56 +0800
Message-ID: <CAFGK4NJOr4XLBfJhpHrco6y4aMcXdvMZ+Ug-XRGqP1AbNP2X2w@mail.gmail.com>
References: <CABAwU-bcnVUn3d3HytywkEYdzZySxtBFT6=-nXOGA+ppNhCg0Q@mail.gmail.com>
	<Pine.LNX.4.64.1108192101160.17629@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52241 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1HVDI5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Aug 2011 23:08:57 -0400
Received: by wyg24 with SMTP id 24so3202267wyg.19
        for <ceph-devel@vger.kernel.org>; Sun, 21 Aug 2011 20:08:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108192101160.17629@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: huang jun <hjwsm1989@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

=46or rand small write, libaio or posix direct aio would be very nice
for the IOPS, I think this kind of journal should be the same.

=46or data read and write, libaio will perform very nice for rand small
read and write. So If user create a rbd image for a KVM image, IOPS
will be much better if OSD handle IO with libaio. Bandwidth will be a
little better too.

Thx
Simon

2011/8/20 Sage Weil <sage@newdream.net>:
> On Sat, 20 Aug 2011, huang jun wrote:
>> hi,all
>> Recently,we have a test to compare =C2=A0async i/o and sync i/o in O=
SD.
>> The osd jounral was written in sync + direct io mode now, that heavi=
ly
>> infuluenced the write performance.
>> we use linux aio API. test file size is 40MB,and disk isn't busy.
>> here is the test result:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ext3
>> sync write+direct io =C2=A0 =C2=A0 =C2=A04.441s
>>
>> async write +direct io =C2=A0 0.462s
>>
>> we are glad to see that, so we want to affirm that :
>> 1) can we use async+direct io to achieve better write performance if
>> we used osd journal?
>
> Do you mean changing the writes in os/FileJournal.cc to be async? =C2=
=A0As long
> as the journal does not acknowledge a write until it is stable on dis=
k,
> that is fine. =C2=A0Async IO would be a nice improvement here; I thin=
k
> currently it's a single sync O_DIRECT io in flight at a time.
>
> The test is to write a 40MB file via which interface? =C2=A0Via a ker=
nel client
> mount?
>
> Thanks-
> sage
>
>
>> 2) does this =C2=A0bring some problems?
>>
>> thank you in advance!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
