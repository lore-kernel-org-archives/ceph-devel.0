From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: LDAP/KRB5 authentication mode
Date: Tue, 19 Jul 2016 15:47:07 -0400 (EDT)
Message-ID: <1582725052.22664551.1468957627218.JavaMail.zimbra@redhat.com>
References: <1468529466.6657.27.camel@suse.com> <1468949911.6841.7.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:37896 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcGSTrL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2016 15:47:11 -0400
In-Reply-To: <1468949911.6841.7.camel@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Oliveira <doliveira@suse.com>
Cc: ceph-devel@vger.kernel.org, sweil@redhat.com

Hi Daniel,

Sorry you haven't gotten a response.  There is work ongoing in the RGW standup related to using LDAP and krb5 (via STS) authentication systems in -RGW-.  Please consider coming to an RGW standup to sync up and discuss (though some details like design writeups of course come to this list).

If your interest is in general ceph and ceph messaging, I defer to others and other discussion--e.g., Msgr2.

Regards,

Matt

----- Original Message -----
> From: "Daniel Oliveira" <doliveira@suse.com>
> To: ceph-devel@vger.kernel.org
> Cc: sweil@redhat.com
> Sent: Tuesday, July 19, 2016 1:38:31 PM
> Subject: Re: LDAP/KRB5 authentication mode
> 
> Hi Team,
> 
> I haven't heard anything back on this, so just wondering if we know who
> is working on this part of the project so we could help out?!
> 
> Thanks,
> -Daniel
> 
> 
> On Thu, 2016-07-14 at 14:51 -0600, Daniel Oliveira wrote:
> > Hi,
> > 
> > I've talking to Kefu/Badone about the work in question and would like
> > to help with that.
> > 
> > Please, who should I talk to in order to understand where we are at
> > and then start working on it?
> > 
> > Thanks,
> > -Daniel
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
