From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Always creating PGs
Date: Thu, 10 May 2012 15:10:50 -0700
Message-ID: <CADvuQRHRSUjA15cX_7ro5vP4jVdg9phugKvcwqZHa3BsM+6RxQ@mail.gmail.com>
References: <20120510175036.FC97.33BC0F0F@bit-isle.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46077 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761612Ab2EJWLM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 18:11:12 -0400
Received: by pbbrp8 with SMTP id rp8so2452098pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 15:11:11 -0700 (PDT)
In-Reply-To: <20120510175036.FC97.33BC0F0F@bit-isle.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomoki BENIYA <beniya@bit-isle.co.jp>
Cc: ceph-devel@vger.kernel.org

On Thu, May 10, 2012 at 2:17 AM, Tomoki BENIYA <beniya@bit-isle.co.jp> =
wrote:
> I found that PGs of 'creating' status are never finished.
>
> # ceph pg stat
> v17596: 1204 pgs: 8 creating, 1196 active+clean; 25521 MB data, 77209=
 MB used, 2223 GB / 2318 GB avail
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~=
~~~
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0always =
creating, why?
>
> # ceph pg dump|grep creating
> 1.1p6 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=
=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0=
 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 creating =C2=A0 =C2=A0 =C2=A0 =C2=A00.00=
0000 =C2=A0 =C2=A0 =C2=A0 =C2=A00'0 =C2=A0 =C2=A0 0'0 =C2=A0 =C2=A0 [] =
=C2=A0 =C2=A0 =C2=A0[] =C2=A0 =C2=A0 =C2=A00'0 =C2=A0 =C2=A0 0.000000

Sounds like another report we've had recently, under the subject "PGs
stuck in creating state"
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/6078

Please read that thread. That wart should go away at 0.47.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
