From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: RGW's apache and mod_fastcgi
Date: Wed, 14 Jan 2015 18:40:21 -0700
Message-ID: <54B71A85.8080807@redhat.com>
References: <54AC3429.2030104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51133 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbbAOBkX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Jan 2015 20:40:23 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0F1eNaQ025647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 14 Jan 2015 20:40:23 -0500
Received: from mbp.ktdreyer.com (vpn-55-158.rdu2.redhat.com [10.10.55.158])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t0F1eMos011130
	for <ceph-devel@vger.kernel.org>; Wed, 14 Jan 2015 20:40:22 -0500
In-Reply-To: <54AC3429.2030104@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 01/06/2015 12:14 PM, Ken Dreyer wrote:
> There's the question of Unix Domain Sockets support. In Yehuda's testing
> with mod_proxy_fcgi, Unix Domain Sockets (UDS) provide a lot better
> performance in comparison to TCP sockets. Apache's UDS support shipped
> in Apache upstream version 2.4.9, but both RHEL and Ubuntu have versions
> older than this. RHEL 7 has httpd 2.4.6, and Trusty has 2.4.7. My
> intention is to request that the Ubuntu apache2 maintainers to backport
> UDS to their Trusty package, similarly to what Red Hat intends to ship
> in RHEL 7.1.

To follow up on this: Apache's mod_proxy UDS support is now present in
the httpd-2.4.6-19 package in RHEL and CentOS. I've opened
https://bugs.launchpad.net/ubuntu/+source/apache2/+bug/1411030 to
request the Ubuntu package maintainers backport UDS support for Trusty's
Apache 2.4.7 package.

- Ken
