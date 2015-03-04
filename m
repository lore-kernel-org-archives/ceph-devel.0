From: Csaba Henk <chenk@redhat.com>
Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
Date: Wed, 4 Mar 2015 09:12:00 -0500 (EST)
Message-ID: <1011159141.22473140.1425478320272.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net> <54F31D28.9050103@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:41694 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758468AbbCDOMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 09:12:06 -0500
In-Reply-To: <54F31D28.9050103@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev@lists.openstack.org>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <danny.al-gaaf@bisect.de>

Hi Danny,

----- Original Message -----
> From: "Danny Al-Gaaf" <danny.al-gaaf@bisect.de>
> To: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev@lists.openstack.org>,
> ceph-devel@vger.kernel.org
> Sent: Sunday, March 1, 2015 3:07:36 PM
> Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
...
> For us security is very critical, as the performance is too. The first
> solution via ganesha is not what we prefer (to use CephFS via p9 and
> NFS would not perform that well I guess). The second solution, to use

Can you please explain that why does the Ganesha based stack involve 9p?
(Maybe I miss something basic, but I don't know.)

Cheers
Csaba
