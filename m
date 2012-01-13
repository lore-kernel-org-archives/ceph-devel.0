From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: subuser of radosgw
Date: Thu, 12 Jan 2012 17:01:47 -0800
Message-ID: <CAC-hyiHW6dQzcezH+0VOMpg1jebr68Yq6JCrczQP8egARjZNDA@mail.gmail.com>
References: <CABAwU-ZMc1ANrwnrv7c6=oUv=PiSb-Zj-xFgMDfQUDWM=Zb6nA@mail.gmail.com>
	<CAC-hyiGM9ZwdX7KmZTmewcHfP5YE4XUaw78FDgNj_L1kLOorpA@mail.gmail.com>
	<CABAwU-Z2YPm9niHz07ue+TvJOyPG30j43RGY2vJckv9uRfPU0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63451 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab2AMBBs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 20:01:48 -0500
Received: by yhnn56 with SMTP id n56so27287yhn.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 17:01:47 -0800 (PST)
In-Reply-To: <CABAwU-Z2YPm9niHz07ue+TvJOyPG30j43RGY2vJckv9uRfPU0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> thanks
> =A0 but there is one =A0thing always in my head,how can we banlance t=
he workload?
> rados stores an object comes from s3 no matter how big it is.
>

We do have a plan to keep larger objects striped in some way (using
some kind of an internal manifest object for them), so that might be
solved soonish.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
