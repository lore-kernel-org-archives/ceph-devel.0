From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: LDAP usuage
Date: Wed, 16 Mar 2016 14:00:06 -0400 (EDT)
Message-ID: <1664724770.67684947.1458151206386.JavaMail.zimbra@redhat.com>
References: <56E953C5.5020900@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:56344 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934415AbcCPSAM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 14:00:12 -0400
In-Reply-To: <56E953C5.5020900@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Willem,

We're adding a with-conditional to the build, so yes, you'll be able to avoid it shortly (see PR #8168).

Thanks,

Matt

----- Original Message -----
> From: "Willem Jan Withagen" <wjw@digiware.nl>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, March 16, 2016 8:38:29 AM
> Subject: LDAP usuage
> 
> Hi,
> 
> After rebasing I find that radosrgw, amonst others, is now dependant on
> LDAP.
> 
> Now LDAP has been something I've tried to avoid for as long as it
> exists. And uptill now I've done oke....
> 
> So is there any chance of excluding this from the building process?
> Otherwise I'll add openldap to the dependancies and get on with trying
> to port. But I'd prefer to do so without LDAP.
> 
> Would that be possible....
> 
> --WjW
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
