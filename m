From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: ceph:rgw issue #10698
Date: Tue, 17 Feb 2015 12:08:32 -0500 (EST)
Message-ID: <784895333.6829144.1424192912653.JavaMail.zimbra@redhat.com>
References: <54E32EFE.4080209@switch.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:44683 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbBQRIi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Feb 2015 12:08:38 -0500
In-Reply-To: <54E32EFE.4080209@switch.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Valery Tschopp <valery.tschopp@switch.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Valery Tschopp" <valery.tschopp@switch.ch>
> To: yehuda@redhat.com, "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, February 17, 2015 4:07:26 AM
> Subject: ceph:rgw issue #10698
> 
> Hello Yehuda,
> 
> The issue http://tracker.ceph.com/issues/10698 "rgw: not failing POST
> requests if keystone not configured" is marked as resolved, but I don't
> think it is backported in firefly.
> 
> Issue http://tracker.ceph.com/issues/10062 should already be backported,
> if I'm not wrong...
> 

Neither made it in. The bug wasn't set to be backported to firefly. We can set it to get backported if there's a demand, however, I'm not sure that it's going to be a trivial backport.

Yehuda
