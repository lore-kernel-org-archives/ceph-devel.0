From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: rgw backports
Date: Mon, 24 Oct 2016 22:22:06 -0400 (EDT)
Message-ID: <1276006469.22059372.1477362126674.JavaMail.zimbra@redhat.com>
References: <57FF63DD.1090806@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:57123 "EHLO
        mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754734AbcJYCWJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 22:22:09 -0400
In-Reply-To: <57FF63DD.1090806@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

Sorry about the late response.  Looks like you resolved the first two.  Drilling into 3, does the lack of conditional -lldap obstruct automake build?  Apparently not?

Regards,

Matt

----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Thursday, October 13, 2016 6:37:17 AM
> Subject: rgw backports
> 
> Hi Matt,
> 
> The following jewel backports
> 
> http://tracker.ceph.com/issues/17322
> http://tracker.ceph.com/issues/17319
> http://tracker.ceph.com/issues/17313
> 
> conflict when trying to cherry-pick them and I would appreciate your advice
> on how to handle them. Should they be resolved or do you think the best
> action is to try to backport the commits that could prevent the conflict ?
> If you don't have an opinion it's also fine, I'll figure it out ;-)
> 
> Cheers
> --
> Loïc Dachary, Artisan Logiciel Libre
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
