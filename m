From: Dan Mick <dmick@redhat.com>
Subject: Re: sepia gitbuilder jessie down ?
Date: Fri, 14 Aug 2015 17:40:50 -0700
Message-ID: <55CE8A92.5090604@redhat.com>
References: <2017068765.35913862.1439473414867.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38033 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbbHOAkv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Aug 2015 20:40:51 -0400
In-Reply-To: <2017068765.35913862.1439473414867.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 08/13/2015 06:43 AM, Alexandre DERUMIER wrote:
> Hi,
> 
> since some day, sepia gitbuilder for debian jessie seem to be down.
> 
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-jessie-amd64-basic/
> 
> 
> I don't see new update since 6 august in repository
> 
> http://gitbuilder.ceph.com/ceph-deb-jessie-x86_64-basic/ref/
> 
> 
> (BTW, is they any roadmap to release official package for jessie ? I'm waiting this to include them in next proxmox version)
> 
> 
> Regards,
> 
> Alexandre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I've restarted it yesterday, and it's down again; I see that it's
defined on a 64GB host that has six 8GB VMs and one 16GB one, which is
.. probably doomed to failure.

I'll stop some of the 8GB machines, which aren't currently needed.


-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
