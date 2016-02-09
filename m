From: Sage Weil <sweil@redhat.com>
Subject: Re: apache/fcgi deprecation?
Date: Mon, 8 Feb 2016 19:30:33 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602081929450.28396@cpach.fuggernut.com>
References: <56B42126.7090106@suse.cz> <CALqRxCxtJ5a0xB68kSNP7xr3qcJ-rEr=xP+ByqyusyuOWU2HgQ@mail.gmail.com> <56B91FA8.8080709@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589AbcBIAaO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Feb 2016 19:30:14 -0500
In-Reply-To: <56B91FA8.8080709@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Matt, Yehuda-

What do you think?  There are some valid use-cases for wanting apache (or 
whatever) in front as it gives you access to a bunch of modules.  On the 
other hand, you can do the same with a proxy.

sage


On Tue, 9 Feb 2016, Nathan Cutler wrote:

> On 02/08/2016 11:57 PM, Ken Dreyer wrote:
> > Sure, please do it!
> > 
> > I think it's just a matter of no one having time to remove it.
> 
> So we could remove the FastCGI dependency from the packaging, too?
> 
> > On Thu, Feb 4, 2016 at 9:12 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> > > I was just browsing the RGW documentation and noticed that parts of it are
> > > still apache/fcgi-oriented (with no mention of civetweb) even in master.
> > > 
> > > My impression was that civetweb is now recommended for RGW deployments as
> > > it
> > > is faster. Is that true? And is there a plan to deprecate/drop apache/fcgi
> > > support, or will it remain indefinitely?
> > > 
> > > Would it be a good idea to expunge apache/fcgi from the docs and point
> > > folks
> > > to civetweb instead?
> > > 
> > > --
> > > Nathan Cutler
> > > Software Engineer Distributed Storage
> > > SUSE LINUX, s.r.o.
> > > Tel.: +420 284 084 037
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> -- 
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
