From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: Ceph authentication/authorization paradignms
Date: Thu, 21 Aug 2014 12:43:02 -0400 (EDT)
Message-ID: <197304281.99.1408639382605.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1288213759.97.1408639348899.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1757 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbaHUQnK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Aug 2014 12:43:10 -0400
In-Reply-To: <1288213759.97.1408639348899.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Christopher R. Hertel" <crh@redhat.com>, ceph-devel@vger.kernel.org, Gregory Farnum <greg@inktank.com>

This approach/family of approaches is certainly the one taken by all classical Kerberized file sharing systems, including AFS, DCE, and NFSv4.

There's a lot of new work just coming to fruition now in both the AFS and NFSv4 communities (rxgk and RPCSEC_GSS, respectively) that are specifically designed to handle important next-generation multi-party authorization scenarios, and which I think we would be wise to at least have a look at.

Regards,

Matt

> > 
> > Right. But you'll either need to plug Kerberos into the
> client<->mon
> > authentication pathways, or (this would be my naive choice) have
> some
> > sort of agent that Kerberos authenticates and then gives the client
> > its CephX shared secret for authenticating with the monitors
> (without
> > the users having to get involved). Either way, there's at least a
> > little CephX integration going on, right?
> > Or am I completely off the mark with what you're trying to do here?
> 
> My thought is the former.  We'd add a new CEPH_AUTH_* type, the client
> 
> side would call into kerberos and get a kerberos ticket to pass to the
> 
> mon, and the mon would call into kerberos to authenticate it.  That
> would 
> authenticate the session.
> 
> I assume there will then be some futzing around to make things behave
> so 
> that the mon will provide the client cephx tickets for interactions
> with 
> the rest of the cluster so that *only* the mon is doing non-cephx 
> authentication.  The focus now is just to make the first step work, 
> though...
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
