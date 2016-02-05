From: David Zafman <dzafman@redhat.com>
Subject: Re: PG States Diagram on Ceph Website is unreadable due to very less
 resolution
Date: Fri, 5 Feb 2016 12:47:12 -0800
Message-ID: <56B50A50.7040805@redhat.com>
References: <CAPg135YZaPxaWHVw0hLGuTc-crdPubR76WjTg2Q7sKQU2oi0TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41987 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756840AbcBEUrO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 15:47:14 -0500
In-Reply-To: <CAPg135YZaPxaWHVw0hLGuTc-crdPubR76WjTg2Q7sKQU2oi0TA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gaurav Bafna <bafnag@gmail.com>, ceph-devel@vger.kernel.org


Gaurav,

 From git checkout of hammer

cat src/osd/PG.h src/osd/PG.cc | doc/scripts/gen_state_diagram.py > 
/tmp/hammer.dot

I installed "xdot" on my Linux box to view it.

David


On 2/5/16 5:00 AM, Gaurav Bafna wrote:
> Hi Cephers,
>
> The PG State Diagram on Ceph website is of very low resolution (33
> KB). It is not at all clear . Does anybody has a higher resolution
> picture of PG States ?
>
> Link : http://docs.ceph.com/docs/hammer/_images/graphviz-4358d0071ed1241baaed0a5450debde6eb61e0e3.png
>
>
>
> Thanks & Regards
> Gaurav Bafna
> 9540631400
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

