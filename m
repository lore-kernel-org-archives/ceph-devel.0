From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: subuser of radosgw
Date: Fri, 20 Jan 2012 13:53:58 -0800
Message-ID: <CAORUGqCunP=cFm5J=yOfjvTk3-=RdTMA9j_eCXvxg916kdHVvw@mail.gmail.com>
References: <CABAwU-ZMc1ANrwnrv7c6=oUv=PiSb-Zj-xFgMDfQUDWM=Zb6nA@mail.gmail.com>
 <CAC-hyiGM9ZwdX7KmZTmewcHfP5YE4XUaw78FDgNj_L1kLOorpA@mail.gmail.com>
 <CABAwU-Z2YPm9niHz07ue+TvJOyPG30j43RGY2vJckv9uRfPU0w@mail.gmail.com>
 <CAC-hyiHW6dQzcezH+0VOMpg1jebr68Yq6JCrczQP8egARjZNDA@mail.gmail.com> <CABAwU-b--nBzwJHONH7PNJyyF_E4BvVz7_9DciecEyegZY3K-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57933 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab2ATVyU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jan 2012 16:54:20 -0500
Received: by werb13 with SMTP id b13so805747wer.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jan 2012 13:54:19 -0800 (PST)
In-Reply-To: <CABAwU-b--nBzwJHONH7PNJyyF_E4BvVz7_9DciecEyegZY3K-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 12, 2012 at 18:41, huang jun <hjwsm1989@gmail.com> wrote:
> does rgw support json? now, the default format is xml, but there is
> something wrong when i using it upload the *.docx file,
> just like "Failed to parse XML document with handler ".

radosgw stores bytes, it does not care about the content of those
bytes. Any file format will work just as well.

I can't find that error message anywhere on the Ceph source tree.
