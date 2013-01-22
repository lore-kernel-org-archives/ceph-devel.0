From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 18:57:58 -0500
Message-ID: <CACkq2mqNqa5ujAPh=OHcSb1UW=0DWzS-gjPt21mmaqGAXdMFKA@mail.gmail.com>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
 <50FEDE7A.5070307@cs.utah.edu> <CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com>
 <alpine.DEB.2.00.1301221514010.17154@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:46881 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756342Ab3AVX6U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 18:58:20 -0500
Received: by mail-ee0-f43.google.com with SMTP id c50so3823854eek.16
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 15:58:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301221514010.17154@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Neil Levine <neil.levine@inktank.com>, Xing Lin <xinglin@cs.utah.edu>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

On Tue, Jan 22, 2013 at 6:14 PM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 22 Jan 2013, Neil Levine wrote:
>> Out of interest, would people prefer that the Ceph deployment script
>> didn't try to handle server-server file copy and just did the local
>> setup only, or is it useful that it tries to be a mini-config
>> management tool at the same time?
>
> BTW, you can also run mkcephfs that way; the man page will let you run
> individual steps and do the remote execution parts yourself.
>
> But I'm also curious what people think of the 'normal' usage... anyone?
>
> sage
>

While I am interested to see where ceph-deploy goes, I do think
mkcephfs in its current form is quite useful.  It does allow you to
stand up decent size clusters with relative ease and is fairly fast.
It has also come quite a ways since since the pre-argonaut form -- the
recent --mkfs additions coupled with the auto-mounting in
/etc/init.d/ceph is pretty slick.  It was a nice discovery for me last
week, as I hadn't created a cluster from scratch since 0.50 or so.

 - Travis
