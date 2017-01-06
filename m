From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Question about RGW lifecycle support status
Date: Fri, 6 Jan 2017 09:13:57 -0500 (EST)
Message-ID: <783842436.86535799.1483712037196.JavaMail.zimbra@redhat.com>
References: <CACKY0b85oVx8TD8LBMO=fGw+thqjPM0N4-Wmbuv_1-reQMSrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:55745 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbdAFON5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 09:13:57 -0500
In-Reply-To: <CACKY0b85oVx8TD8LBMO=fGw+thqjPM0N4-Wmbuv_1-reQMSrCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Yes, you're correct, S3 object expiration support was added along with tests to verify those lifecycle actions (abe4b1378cc0e23e0da9c76c034c6d592b81b105, Ji Chen).  There's some information in the commit message and test framework in the worst case, but documentation should be brought up-to-date.

Regards,

Matt

----- Original Message -----
> From: "liuchang0812" <liuchang0812@gmail.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Friday, January 6, 2017 8:17:28 AM
> Subject: Question about RGW lifecycle support status
> 
> Hi, all
> 
> Our document says that "Bucket Lifecycle Not Supported" in
> http://docs.ceph.com/docs/master/radosgw/s3/ . But it seems that there
> are a lot of code about lc in RGW. I want to confirm whether RGW
> supported LC.
> 
> Any comments appreciated. Thanks
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

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
