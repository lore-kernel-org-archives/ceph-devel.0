From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: radosgw-admin: symbol lookup error
Date: Tue, 22 Jul 2014 10:03:03 +1000
Message-ID: <53CDAA37.90209@redhat.com>
References: <53CD1B3A.7060008@gmail.com>
Reply-To: bhubbard@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbaGVADI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 Jul 2014 20:03:08 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6M0384M021311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Mon, 21 Jul 2014 20:03:08 -0400
Received: from dhcp-1-109.bne.redhat.com (vpn1-48-236.bne.redhat.com [10.64.48.236])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s6M0374P019028
	for <ceph-devel@vger.kernel.org>; Mon, 21 Jul 2014 20:03:08 -0400
In-Reply-To: <53CD1B3A.7060008@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 07/21/2014 11:52 PM, Zhongliang Zhao wrote:
> Dear all,
>
> I am trying to test the feature of geo-replication, which is suported
> via radosgw service.
> After following
> http://ceph.com/docs/master/radosgw/config/#adjust-path-ownership-permissions,
>
> $sudo /etc/init.d/radosgw start (start the gateway)
> returns
> $Starting client.radosgw.instance-1...
> $/usr/bin/radosgw is running
>
> However, when I want to use the radosgw-admin command, it gives error like:
>
> radosgw-admin: symbol lookup error: radosgw-admin: undefined symbol:
> _ZTVN4ceph6crypto8HMACSHA1E

Looks like it is missing a definition for a crypto function.

$ c++filt  _ZTVN4ceph6crypto8HMACSHA1E
vtable for ceph::crypto::HMACSHA1

>
> Can anyone indicate what's happen and how to process?
>
> Thanks in advance.
> Giovanni
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 

Kindest Regards,

Brad Hubbard
Senior Software Maintenance Engineer
Red Hat Global Support Services
Asia Pacific Region
