From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Question about RGW lifecycle support status
Date: Fri, 6 Jan 2017 21:25:44 +0000
Message-ID: <robbat2-20170106T212358-572317457Z@orbis-terrarum.net>
References: <CACKY0b85oVx8TD8LBMO=fGw+thqjPM0N4-Wmbuv_1-reQMSrCQ@mail.gmail.com>
 <783842436.86535799.1483712037196.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:43666 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750893AbdAFVZo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 6 Jan 2017 16:25:44 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id CCDAD341657
        for <ceph-devel@vger.kernel.org>; Fri,  6 Jan 2017 21:25:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <783842436.86535799.1483712037196.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: liuchang0812 <liuchang0812@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Relatedly, because it caused some confusion elsewhere, Lifecycle was
merged (b63c3fa26fbecad046dcecf50f8bf11ff46fe29d) and then later
reverted in Jewel (9162bd29594d34429a09562ed60a32a0703940ea). 

The Jewel release notes mention lifecycle being added, but NOT that it
was reverted.

On Fri, Jan 06, 2017 at 09:13:57AM -0500, Matt Benjamin wrote:
> Hi,
> 
> Yes, you're correct, S3 object expiration support was added along with tests to verify those lifecycle actions (abe4b1378cc0e23e0da9c76c034c6d592b81b105, Ji Chen).  There's some information in the commit message and test framework in the worst case, but documentation should be brought up-to-date.
> 
> Regards,
> 
> Matt
> 
> ----- Original Message -----
> > From: "liuchang0812" <liuchang0812@gmail.com>
> > To: "ceph-devel" <ceph-devel@vger.kernel.org>
> > Sent: Friday, January 6, 2017 8:17:28 AM
> > Subject: Question about RGW lifecycle support status
> > 
> > Hi, all
> > 
> > Our document says that "Bucket Lifecycle Not Supported" in
> > http://docs.ceph.com/docs/master/radosgw/s3/ . But it seems that there
> > are a lot of code about lc in RGW. I want to confirm whether RGW
> > supported LC.
> > 
> > Any comments appreciated. Thanks
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -- 
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
> 
> http://www.redhat.com/en/technologies/storage
> 
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
