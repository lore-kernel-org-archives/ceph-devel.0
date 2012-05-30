From: Sam Just <sam.just@inktank.com>
Subject: Re: OSD per disk.
Date: Wed, 30 May 2012 10:07:25 -0700
Message-ID: <CA+4uBUY+qq0x81wg=Qom70ttAX4f-bwkDH=H5o6rPHdvpFgFuQ@mail.gmail.com>
References: <loom.20120528T080903-621@post.gmane.org>
	<1c048abb-0cbb-4d69-9922-419c16019887@mailpro>
	<loom.20120528T111434-469@post.gmane.org>
	<CADvuQREMRQtBv2NhM_QH0A_-mFE5wRGPVMHk0Wu7jhUvgXjcYQ@mail.gmail.com>
	<CA+7V1=Ey224p64Wo0172OrTTiA0sbg9x_13aJwRvBr7VRySHbQ@mail.gmail.com>
	<CADvuQRHzTy+Kvhah7sop6fdSvhYvA63ZNXBkntukmYLD_ejbVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45804 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab2E3RH0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 13:07:26 -0400
Received: by pbbrp8 with SMTP id rp8so215263pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 10:07:26 -0700 (PDT)
In-Reply-To: <CADvuQRHzTy+Kvhah7sop6fdSvhYvA63ZNXBkntukmYLD_ejbVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

That bug was fixed in f859f25d7eaec01fb6a82b88409d005c8177fea2.

It actually appears to mean that the osd failed to authenticate.
-Sam

On Wed, May 30, 2012 at 9:53 AM, Tommi Virtanen <tv@inktank.com> wrote:
> For the benefit of the mailing list; there's an assert(nlock > 0)
> crash in there.
>
> ---------- Forwarded message ----------
> From: chandrashekhar mekala <chandubigc@gmail.com>
> Date: Tue, May 29, 2012 at 9:51 PM
> Subject: Re: OSD per disk.
> To: Tommi Virtanen <tv@inktank.com>
>
>
> Yes , I am using mkcephfs to create=A0 cluster.
>
> osd.1.log
> -------------------------
> 2012-05-30 10:17:58.948426 7f98b4856780 journal close /data/osd.1/osd=
=2E1.journal
> ./common/Mutex.h: In function 'void Mutex::Unlock()' thread
> 7f98b4856780 time 2012-05-30 10:17:58.948800
> ./common/Mutex.h: 117: FAILED assert(nlock > 0)
> =A0ceph version 0.41 (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d=
)
> =A01: (Mutex::Unlock()+0x93) [0x4f5c73]
> =A02: (OSD::init()+0x459) [0x546b79]
> =A03: (main()+0x2496) [0x4a8bc6]
> =A04: (__libc_start_main()+0xed) [0x7f98b2d2676d]
> =A05: /usr/bin/ceph-osd() [0x4aa68d]
> =A0ceph version 0.41 (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d=
)
> =A01: (Mutex::Unlock()+0x93) [0x4f5c73]
> =A02: (OSD::init()+0x459) [0x546b79]
> =A03: (main()+0x2496) [0x4a8bc6]
> =A04: (__libc_start_main()+0xed) [0x7f98b2d2676d]
> =A05: /usr/bin/ceph-osd() [0x4aa68d]
> *** Caught signal (Aborted) **
> =A0in thread 7f98b4856780
> =A0ceph version 0.41 (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d=
)
> =A01: /usr/bin/ceph-osd() [0x5fb1d6]
> =A02: (()+0xfcb0) [0x7f98b3ef2cb0]
> =A03: (gsignal()+0x35) [0x7f98b2d3b445]
> =A04: (abort()+0x17b) [0x7f98b2d3ebab]
> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f98b368969=
d]
> =A06: (()+0xb5846) [0x7f98b3687846]
> =A07: (()+0xb5873) [0x7f98b3687873]
> =A08: (()+0xb596e) [0x7f98b368796e]
> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x200) [0x5ce010]
> =A010: (Mutex::Unlock()+0x93) [0x4f5c73]
> =A011: (OSD::init()+0x459) [0x546b79]
> =A012: (main()+0x2496) [0x4a8bc6]
> =A013: (__libc_start_main()+0xed) [0x7f98b2d2676d]
> =A014: /usr/bin/ceph-osd() [0x4aa68d]
>
>
>
>
> On Tue, May 29, 2012 at 9:56 PM, Tommi Virtanen <tv@inktank.com> wrot=
e:
>>
>> On Mon, May 28, 2012 at 2:25 AM, chandrashekhar <chandubigc@gmail.co=
m> wrote:
>> > Thanks Alexandre, =A0I created four directories in /data =A0(osd0,=
osd1,osd2,osd3)
>> > and mounted as below:
>> >
>> > /dev/sdb1 -> /data/osd1
>> > /dev/sdc1 -> /data/osd2
>> > /dev/sdd1 -> /data/osd3
>> >
>> >
>> > But when I start ceph its starting mons and md daemons but not osd=
s. Please help
>> > me to get this working.
>>
>> How did you create the cluster? mkcephfs?
>>
>> Do you see log entries in /var/log/ceph/*osd*.log ? What do they say=
?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
