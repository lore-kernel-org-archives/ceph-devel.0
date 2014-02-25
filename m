From: Filippos Giannakos <philipgian@grnet.gr>
Subject: Re: Assertion error in librados
Date: Tue, 25 Feb 2014 17:58:38 +0200
Message-ID: <20140225155838.GB30739@philipgian-mac>
References: <20140225144900.GA30739@philipgian-mac>
 <CAPYLRzhnPTEgycnmZ0HXeEW=ADe01QKS8nUmL8451rYYtoMvgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:51337 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752444AbaBYP6m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 Feb 2014 10:58:42 -0500
Content-Disposition: inline
In-Reply-To: <CAPYLRzhnPTEgycnmZ0HXeEW=ADe01QKS8nUmL8451rYYtoMvgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

Hi Greg,

Unfortunately we don't keep any Ceph related logs on the client side. On the
server side, we kept the default log settings to avoid overlogging.
Do you think that there might be something usefull on the OSD side ?

On Tue, Feb 25, 2014 at 07:28:30AM -0800, Gregory Farnum wrote:
> Do you have logs? The assert indicates that the messenger got back
> something other than "okay" when trying to grab a local Mutex, which
> shouldn't be able to happen. It may be that some error-handling path
> didn't drop it (within the same thread that later tried to grab it
> again), but we'll need more details to track it down.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> 

Kind Regards,
-- 
Filippos
<philipgian@grnet.gr>
