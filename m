From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: boost::container::static_vector
Date: Wed, 25 May 2016 13:05:34 -0400 (EDT)
Message-ID: <1185059723.39490876.1464195934703.JavaMail.zimbra@redhat.com>
References: <1185676289.39418531.1464189847415.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1605251128080.14180@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:57437 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbcEYRF5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2016 13:05:57 -0400
In-Reply-To: <alpine.DEB.2.11.1605251128080.14180@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Sage,

Thanks, ok.

Matt

----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "Radoslaw Zarzynski" <rzarzynski@mirantis.com>, "The Sacred Order of the Squid Cybernetic"
> <ceph-devel@vger.kernel.org>
> Sent: Wednesday, May 25, 2016 12:14:35 PM
> Subject: Re: boost::container::static_vector
> 
> On Wed, 25 May 2016, Matt Benjamin wrote:
> > Hi Radek (CC's),
> > 
> > It seems that static_vector isn't on the boost on RHEL/Centos 7;  I'm
> > not sure if small_vector is;  I think we were approaching consensus on
> > solving this... I'll revisit this in #ceph-devel and on standup.
> 
> We most recently tabled the boost question until the cmake transition was
> done so that we can ignore any automake-related complexity.  I still think
> that will save us some time/effort...
> 
> sage
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
