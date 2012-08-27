From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Openstack
Date: Mon, 27 Aug 2012 13:33:25 -0700
Message-ID: <503BD995.3060609@inktank.com>
References: <35DD34C9-6FDC-4735-A363-CB69C1F6E18B@onqtel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48867 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab2H0Ud2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 16:33:28 -0400
Received: by pbbrr13 with SMTP id rr13so8053601pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 13:33:27 -0700 (PDT)
In-Reply-To: <35DD34C9-6FDC-4735-A363-CB69C1F6E18B@onqtel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Quenten Grasso <QGrasso@onq.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/24/2012 07:31 PM, Quenten Grasso wrote:
> Hi All
>
> Just wondering if anyone has any tips on getting openstack Essex working with boot from RBD with the dashboard.
>
> Glance and RBD is fairly well documented and Nova with attaching ceph RBD vols,   However I haven't found much on getting boot from RBD to work.

These are still the best references for Essex:

http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/7386

