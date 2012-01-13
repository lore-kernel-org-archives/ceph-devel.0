From: huang jun <hjwsm1989@gmail.com>
Subject: Re: subuser of radosgw
Date: Fri, 13 Jan 2012 10:41:25 +0800
Message-ID: <CABAwU-b--nBzwJHONH7PNJyyF_E4BvVz7_9DciecEyegZY3K-g@mail.gmail.com>
References: <CABAwU-ZMc1ANrwnrv7c6=oUv=PiSb-Zj-xFgMDfQUDWM=Zb6nA@mail.gmail.com>
	<CAC-hyiGM9ZwdX7KmZTmewcHfP5YE4XUaw78FDgNj_L1kLOorpA@mail.gmail.com>
	<CABAwU-Z2YPm9niHz07ue+TvJOyPG30j43RGY2vJckv9uRfPU0w@mail.gmail.com>
	<CAC-hyiHW6dQzcezH+0VOMpg1jebr68Yq6JCrczQP8egARjZNDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48766 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab2AMCl0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 21:41:26 -0500
Received: by iabz25 with SMTP id z25so3625858iab.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 18:41:26 -0800 (PST)
In-Reply-To: <CAC-hyiHW6dQzcezH+0VOMpg1jebr68Yq6JCrczQP8egARjZNDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2012/1/13 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
>> thanks
>> =A0 but there is one =A0thing always in my head,how can we banlance =
the workload?
>> rados stores an object comes from s3 no matter how big it is.
>>
>
> We do have a plan to keep larger objects striped in some way (using
> some kind of an internal manifest object for them), so that might be
> solved soonish.
>
> Yehuda

does rgw support json? now, the default format is xml, but there is
something wrong when i using it upload the *.docx file,
just like "Failed to parse XML document with handler ".
--=20
huangjun
ChuYunHanZhi WuHan Network Storage System Ltd
WuHan GuangGu Road
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
