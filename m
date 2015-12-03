From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 14:04:17 -0500 (EST)
Message-ID: <807869086.28388770.1449169457315.JavaMail.zimbra@redhat.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com> <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:46888 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbbLCTEV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 14:04:21 -0500
In-Reply-To: <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, ceph-devel@vger.kernel.org

++ #1

----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
> To: "Somnath Roy" <Somnath.Roy@sandisk.com>
> Cc: "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, ceph-devel@vger.kernel.org
> Sent: Thursday, December 3, 2015 6:50:26 AM
> Subject: RE: queue_transaction interface + unique_ptr + performance
> 
> 1- I agree we should avoid shared_ptr whenever possible.
> 
> 
> sage

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
