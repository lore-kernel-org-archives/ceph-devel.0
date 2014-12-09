From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] experimental features
Date: Tue, 9 Dec 2014 14:25:07 +0900
Message-ID: <20141209142507.7438eb99@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net>
	<CAC6JEv8LVviFoNXB72gKBQ+seNVYphvpwm0QZeOwccPHr7Qatg@mail.gmail.com>
	<5481EF6B.4010901@redhat.com>
	<CAOGLoJN2wSxMgtok6aATSW5o-Abqcv2bdVo+dVfaEbG4iyiQSw@mail.gmail.com>
	<CAPHS-z7cOLokgHe7Ky+SJQMGPbZmY26o+EeA1i=qo+i_XnYg5g@mail.gmail.com>
	<5485B6B5.8010802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.dentaku.gol.com ([203.216.5.71]:44072 "EHLO
	smtp01.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbaLIFeQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Dec 2014 00:34:16 -0500
In-Reply-To: <5485B6B5.8010802@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Fred Yang <frederic.yang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Mon, 08 Dec 2014 08:33:25 -0600 Mark Nelson wrote:

> I've been thinking for a while that we need another more general command 
> than Ceph health to more generally inform you about your cluster.  IE I 
> personally don't like having min/max PG warnings in Ceph health (they 
> can be independently controlled by ceph.conf options but that kind of 
> approach won't scale). I'd like another command that I can run that 
> tells me about this kind of thing.  Same thing with experimental 
> features.  I don't want ceph health warning me if they've been enabled, 
> but I do want to know if they've ever been enabled, when, and whether 
> they are still in effect.
> 

Very much agreed.

Expanding on this, setting a cluster to no-scrub will result in a warning
(very arguably) and while a slow request after 30 seconds is WRN worthy,
after something like a minute it ought to be ERR level as this is likely
to have massive impact on clients.

Christian

> Mark
> 
> On 12/08/2014 06:57 AM, Fred Yang wrote:
> > You will have to consider in the real world whoever built the cluster
> > might not document the dangerous option to let support stuff or
> > successor aware. Thus any experimental feature considered not safe for
> > production should be included in a warning message in 'ceph health',
> > and logs, either log it periodically or log the warning msg upon
> > restart. Feature-wise, 'ceph health detail' should give you a report
> > over all important features/options of the cluster as well.
> >
> > -Fred
> >
> > On Sun, Dec 7, 2014, 11:15 PM Justin Erenkrantz <justin@erenkrantz.com
> > <mailto:justin@erenkrantz.com>> wrote:
> >
> >     On Fri, Dec 5, 2014 at 12:46 PM, Mark Nelson
> >     <mark.nelson@inktank.com <mailto:mark.nelson@inktank.com>> wrote:
> >      > I'm in favor of the "allow experimental features" but instead
> >     call it:
> >      >
> >      > "ALLOW UNRECOVERABLE DATA CORRUPTING FEATURES" which makes
> >      > things
> >     a little
> >      > more explicit. With great power comes great responsibility.
> >
> >     +1.
> >
> >     For Subversion, we utilize SVN_I_LOVE_CORRUPTED_XXX for a few
> > options that can cause data corruption.  -- justin
> >     --
> >     To unsubscribe from this list: send the line "unsubscribe
> > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> >     <mailto:majordomo@vger.kernel.org>
> >     More majordomo info at http://vger.kernel.org/__majordomo-info.html
> >     <http://vger.kernel.org/majordomo-info.html>
> >
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 


-- 
Christian Balzer        Network/Systems Engineer                
chibi@gol.com   	Global OnLine Japan/Fusion Communications
http://www.gol.com/
