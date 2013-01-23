From: Neil Levine <neil.levine@inktank.com>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 16:09:10 -0800
Message-ID: <CANygib-D3-V5TDV1ZZhFOkvfpD9Z-9a0+aFnW074QF8L2yEcvw@mail.gmail.com>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
	<50FEDE7A.5070307@cs.utah.edu>
	<CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com>
	<alpine.DEB.2.00.1301221514010.17154@cobra.newdream.net>
	<CACkq2mqNqa5ujAPh=OHcSb1UW=0DWzS-gjPt21mmaqGAXdMFKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39120 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3AWAJM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 19:09:12 -0500
Received: by mail-vc0-f174.google.com with SMTP id n11so5161438vch.5
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 16:09:11 -0800 (PST)
In-Reply-To: <CACkq2mqNqa5ujAPh=OHcSb1UW=0DWzS-gjPt21mmaqGAXdMFKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Xing Lin <xinglin@cs.utah.edu>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

We're having a chat about ceph-deploy tomorrow. We need to strike a
balance between its being a useful tool for standing up a quick
cluster and its ignoring the UNIX philosophy and trying to do to much.

My assumption is that for most production operations, or at the point
where people decide to invest in Ceph, users will already have
selected a parallel execution and/or configuration management tool.
Ensuring new or early PoC adopters, who perhaps don't want to wade
into the wider-operational frameworks issues, is probably where the
tool is best focused.

Neil

On Tue, Jan 22, 2013 at 3:57 PM, Travis Rhoden <trhoden@gmail.com> wrote:
> On Tue, Jan 22, 2013 at 6:14 PM, Sage Weil <sage@inktank.com> wrote:
>> On Tue, 22 Jan 2013, Neil Levine wrote:
>>> Out of interest, would people prefer that the Ceph deployment script
>>> didn't try to handle server-server file copy and just did the local
>>> setup only, or is it useful that it tries to be a mini-config
>>> management tool at the same time?
>>
>> BTW, you can also run mkcephfs that way; the man page will let you run
>> individual steps and do the remote execution parts yourself.
>>
>> But I'm also curious what people think of the 'normal' usage... anyone?
>>
>> sage
>>
>
> While I am interested to see where ceph-deploy goes, I do think
> mkcephfs in its current form is quite useful.  It does allow you to
> stand up decent size clusters with relative ease and is fairly fast.
> It has also come quite a ways since since the pre-argonaut form -- the
> recent --mkfs additions coupled with the auto-mounting in
> /etc/init.d/ceph is pretty slick.  It was a nice discovery for me last
> week, as I hadn't created a cluster from scratch since 0.50 or so.
>
>  - Travis
