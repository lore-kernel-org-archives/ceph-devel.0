From: Sage Weil <sage@inktank.com>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 15:14:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301221514010.17154@cobra.newdream.net>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com> <50FEDE7A.5070307@cs.utah.edu> <CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40161 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3AVXOx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 18:14:53 -0500
In-Reply-To: <CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neil Levine <neil.levine@inktank.com>
Cc: Xing Lin <xinglin@cs.utah.edu>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

On Tue, 22 Jan 2013, Neil Levine wrote:
> Out of interest, would people prefer that the Ceph deployment script
> didn't try to handle server-server file copy and just did the local
> setup only, or is it useful that it tries to be a mini-config
> management tool at the same time?

BTW, you can also run mkcephfs that way; the man page will let you run 
individual steps and do the remote execution parts yourself.

But I'm also curious what people think of the 'normal' usage... anyone?

sage


> 
> Neil
> 
> On Tue, Jan 22, 2013 at 10:46 AM, Xing Lin <xinglin@cs.utah.edu> wrote:
> > If it is the command 'mkcephfs' that asked you for ssh password, then that
> > is probably because that script needs to push some files (ceph.conf, e.g) to
> > other hosts. If we open that script, we can see that it uses 'scp' to send
> > some files. If I remember correctly, for every osd at other hosts, it will
> > ask us ssh password seven times. So, we'd better set up public key first. :)
> >
> > Xing
> >
> >
> > On 01/22/2013 11:24 AM, Gandalf Corvotempesta wrote:
> >>
> >> Hi all,
> >> i'm trying my very first ceph installation following the 5-minutes
> >> quickstart:
> >> http://ceph.com/docs/master/start/quick-start/#install-debian-ubuntu
> >>
> >> just a question: why ceph is asking me  for SSH password? Is ceph
> >> trying to connect to itself via SSH?
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
