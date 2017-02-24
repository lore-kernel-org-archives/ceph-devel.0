From: Jaze Lee <jazeltq@gmail.com>
Subject: Re: [RFC v6] RBD: Add support readv,writev for rbd
Date: Fri, 24 Feb 2017 20:51:51 +0800
Message-ID: <CAKZcxgdkSA9JU55Wat1mvMn3XPVK9NyRuCCM8jFTSWdpkzVWSg@mail.gmail.com>
References: <20170221065003.26103-1-jazeltq@gmail.com> <20170224035236.GB2613@localhost.localdomain>
 <CAKZcxgcWpz5g-WdeFNu8Ad_4PQZMPHoJDmn_1HENntVLLZG_Jg@mail.gmail.com> <20170224114222.GA16659@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:34653 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdBXMvw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2017 07:51:52 -0500
Received: by mail-it0-f44.google.com with SMTP id k200so11312120itb.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2017 04:51:52 -0800 (PST)
In-Reply-To: <20170224114222.GA16659@localhost.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Cody <jcody@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, ceph-devel <ceph-devel@vger.kernel.org>, tianqing <tianqing@unitedstack.com>

Sorry, I do not know. I thought we should always add RFC all though
the patch's life...
What is the prefix i should add? PATH 0 ?

2017-02-24 19:42 GMT+08:00 Jeff Cody <jcody@redhat.com>:
> On Fri, Feb 24, 2017 at 02:09:31PM +0800, Jaze Lee wrote:
>> 2017-02-24 11:52 GMT+08:00 Jeff Cody <jcody@redhat.com>:
>> > On Tue, Feb 21, 2017 at 02:50:03PM +0800, jazeltq@gmail.com wrote:
>> >> From: tianqing <tianqing@unitedstack.com>
>> >>
>> >> Rbd can do readv and writev directly, so wo do not need to transform
>> >> iov to buf or vice versa any more.
>> >>
>> >> Signed-off-by: tianqing <tianqing@unitedstack.com>
>> >> ---
>> >
>> >
>> > This is marked as an RFC still - is this a series you would like to se=
e in
>> > 2.9?
>>
>> Yes.   What should i do if i like it in 2.9
>>
>
> Ideally you would submit the series as a non-RFC patch (that is, it would
> have progressed to a normal patch away from RFC).
>
> But in this case, it seems to me that this patch has progressed beyond RF=
C;
> is there any reason it is still marked as RFC instead of just a patch?  I=
t
> looks OK to me.
>



--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
