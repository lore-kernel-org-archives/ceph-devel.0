From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: is it possible to support backend pluggable for RGW bucket
 index
Date: Mon, 27 Feb 2017 12:58:07 -0500 (EST)
Message-ID: <1802697872.111896194.1488218287095.JavaMail.zimbra@redhat.com>
References: <CACKY0b9fEy9XBY4434X3Rhv_r1nyjhZit8v_eC6eqKEvkVcung@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:57143 "EHLO
        mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdB0Sc3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 13:32:29 -0500
In-Reply-To: <CACKY0b9fEy9XBY4434X3Rhv_r1nyjhZit8v_eC6eqKEvkVcung@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I know you've suggested this concept in an earlier email.

Others should chime in, but my own impression is that there isn't a trivial way to substitute an alternative indexing mechanism, as the mapping is constrained by the mapping of index segments to OSDs.  Once mapped to an OSD, the index ops are OMAP operations, and there may be a variety of ways to accelerate those at the OSD.

It would be great to have you join an RGW standup (several per week) to discuss your ideas, and current ideas/ongoing work to accelerate bucket index ops (and bypass them).

Regards,

Matt

----- Original Message -----
> From: "liuchang0812" <liuchang0812@gmail.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Monday, February 27, 2017 3:44:27 AM
> Subject: is it possible to support backend pluggable for RGW bucket index
> 
> Hi, Yehuda and Cephers
> 
> Is it possible to make RGW bucket index pluggable? If it's possible,
> We could save those index into Hbase cluster and improve the
> scalability and available.
> 
> 
> 
> thanks
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
