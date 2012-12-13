From: =?UTF-8?B?6JSh5qyK5pix?= <chuanyu@cs.nctu.edu.tw>
Subject: Re: RBD using problem
Date: Thu, 13 Dec 2012 08:29:27 +0800
Message-ID: <CAKG+gh8C9PXqhJbZwvPWfqFg==GRJ4AUR=9XzTu9kUERmDSfwQ@mail.gmail.com>
References: <20121211060012.GA16722@cs.nctu.edu.tw> <50C6F599.2050007@widodh.nl>
 <0CA32FC8-6118-4516-A56B-05351D85BE00@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46428 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab2LMA3t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 19:29:49 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so712696bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 16:29:48 -0800 (PST)
In-Reply-To: <0CA32FC8-6118-4516-A56B-05351D85BE00@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2012/12/13 Dan Mick <dan.mick@inktank.com>
>
> I've often wondered if "cluster" and "client" would have been better choices of name for those nets.
it looks good!
>
>
> On Dec 11, 2012, at 12:58 AM, Wido den Hollander <wido@widodh.nl> wrote:
>
> > Hi Chuanyu,
> >
> > On 12/11/2012 02:00 PM, Chuanyu Tsai wrote:
> >> Hi cephers,
> >>
> >> I know that we can setup cluster addr and public addr to let OSDs
> >> listen on different subnet for different purpose, however, I don't
> >> have so much public IPs to give all my OSDs an IP per OSD.
> >>
> >
> > Don't confuse "public" with actually route-able IP's on the internet. In
> > most cases you'll use 192.168.X.X or 10.X.X.X for your Ceph cluster and
> > let your clients communicate over that.
OK, I got it!
Another question,
Is MDS the client of OSDs?
>
> >
> > The "cluster network" is there to let the OSDs do their
> > inter-OSD-traffic over a different interface so you can gain more
> > bandwith in certain cases.
So, MON and MDS is no need to bind an IP belong "cluster network", right?
or, do I need some MON live in "public network", and some in "cluster network"?
>
> >
> > Note that you can also use IPv6 for your Ceph cluster, which I assume is
> > available in Taiwan.
OK, I almost forget this option.
>
> >
> > I've been using Ceph with IPv6 for about 3 years now and works like a charm.
I'll give it a try.

Thanks.

Chuanyu
>
> >
> > Wido
> >
> >> So my question is, if I follow the link:
> >> http://www.spinics.net/lists/ceph-devel/msg10941.html
> >> to set all my pools using the ssd-primary rule or
> >> something like that, than I bind public IP on every
> >> ceph-osd-ssd-server-*
> >> (it means all my primary osd have public IP, right?),
> >> can this method make me using RBD correctly?
> >>
> >> Or do we have some method to let public network clients use RBD
> >> and no need to let all OSDs have public IP?
> >>
> >> Regards,
> >> Chuanyu.
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
