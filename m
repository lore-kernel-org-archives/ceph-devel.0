From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Downstream IO circuit-breaker in RGW ?
Date: Wed, 28 Jun 2017 09:02:10 -0400 (EDT)
Message-ID: <364120509.27924734.1498654930814.JavaMail.zimbra@redhat.com>
References: <CACiNYre28nZjMhLevyBPWLMcvu0_iayKsq8kH267y+Y3_Tccwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdF1NCL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Jun 2017 09:02:11 -0400
In-Reply-To: <CACiNYre28nZjMhLevyBPWLMcvu0_iayKsq8kH267y+Y3_Tccwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rolland Santimano <rolland.s@flipkart.com>
Cc: ceph-devel@vger.kernel.org, "Saood Khan (Engineering Manager)" <saood.khan@flipkart.com>

Hi,

----- Original Message -----
> From: "Rolland Santimano" <rolland.s@flipkart.com>
> To: ceph-devel@vger.kernel.org
> Cc: "Saood Khan (Engineering Manager)" <saood.khan@flipkart.com>
> Sent: Tuesday, June 27, 2017 9:37:23 PM
> Subject: Downstream IO circuit-breaker in RGW ?
> 
> (Please retain the CC list in your replies)
> 
> Our Ceph deployment is a S3 service with an SSD index pool, and HDD
> data pool. We often see service outages due to blocked requests
> against latent OSDs, mostly at the index pool.
> 
> I have been looking at code-changes in the RGW IO path that fence-off
> latent OSDs or fast-fail IOs targeted to such OSDs; ie. something like
> a circuit breaker pattern. A "retry-after" header is inserted in user
> responses for such failed user requests.

Though not everyone might be interested in running  this particular pattern, strategizing the i/o  path seems worth exploring.  It would be interesting to read this work.  In addition, you folks might be interested in attending some RGW standups?

> 
> The above circuit-breaker uses local knowledge at each RGW, ie. there
> is no central state about latent OSDs at the MON or elsewhere -- maybe
> this is something that can be piggy-backed on the OSD map maintained
> by the MON, or pushed to the ceph-mgr.

Broadly, ceph-mgr, I think.

Matt

> 
> Any thoughts or suggestions on the above ?
> 
> (I was not sure about the folks to target this mail to, please
> re-direct as appropriate.)
> 
> --
> Rolland
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
