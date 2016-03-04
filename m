From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: [ceph-users] Problem: silently corrupted RadosGW objects caused
 by slow requests
Date: Fri, 4 Mar 2016 09:23:01 -0800
Message-ID: <CADRKj5QYiCWxqxQkhDsFET8CJEfJM9_X1XiEH1_Zcn0Z_jSkNQ@mail.gmail.com>
References: <156923D1D92AF640829D4E847271EDAE522A46F435@MXMBON06.grupa.onet>
	<CAMNMNTxs46Hcaq-ZJZfYfF5m8aL9ETNjtBKr8UrdAxZFM7E=nw@mail.gmail.com>
	<156923D1D92AF640829D4E847271EDAE522A46FD66@MXMBON06.grupa.onet>
	<robbat2-20160303T232148-550781944Z@orbis-terrarum.net>
	<156923D1D92AF640829D4E847271EDAE522A46FF66@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33611 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759575AbcCDRXE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 12:23:04 -0500
Received: by mail-vk0-f48.google.com with SMTP id k1so44023887vkb.0
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2016 09:23:02 -0800 (PST)
In-Reply-To: <156923D1D92AF640829D4E847271EDAE522A46FF66@MXMBON06.grupa.onet>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Ritter_S=C5=82awomir?= <Slawomir.Ritter@dreamlab.pl>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Fri, Mar 4, 2016 at 7:26 AM, Ritter S=C5=82awomir
<Slawomir.Ritter@dreamlab.pl> wrote:
>> From: Robin H. Johnson [mailto:robbat2@gentoo.org]
>> Sent: Friday, March 04, 2016 12:40 AM
>> To: Ritter S=C5=82awomir
>> Cc: ceph-users@ceph.com; ceph-devel
>> Subject: Re: [ceph-users] Problem: silently corrupted RadosGW object=
s caused
>> by slow requests
>>
>> On Thu, Mar 03, 2016 at 01:55:13PM +0100, Ritter S=C5=82awomir wrote=
:
>> > Hi,
>> >
>> > I think this is really serious problem - again:
>> >
>> > - we silently lost S3/RGW objects in clusters
>> >
>> > Moreover, it our situation looks very similiar to described in
>> > uncorrected bug #13764 (Hammer) and in corrected #8269 (Dumpling).
>> FYI fix in #8269 _is_ present in Hammer:
>> commit bd8e026f88b rgw: don't allow multiple writers to same multiob=
ject part
>>
>> --
>> Robin Hugh Johnson
>> Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
>> E-Mail     : robbat2@gentoo.org
>> GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> Yes,
>
> fix for #8269 also has been included in our version: Dumpling 0.67.11=
=2E
> Guys from #13764 are using patched Hammer version

I didn't notice that you were actually running Dumpling (which we
haven't supported and backported fixes for a while). Here's one issue
that you might have hit:

http://tracker.ceph.com/issues/11604

Yehuda

>
> Both situations with corrupted files are very similiar to that descri=
bed in #8269.
> There was a problem with 2 threads writing to the same RADOS objects.
>
> Maybe there is another one uknown and specific exception to fix?
>
> Cheers,
> SR
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
