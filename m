From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: librados integrity tests.
Date: Tue, 05 Nov 2013 20:42:55 +0800
Message-ID: <5278E7CF.40209@ubuntukylin.com>
References: <CAJMJAuMQH_kd_B=3DKxZUa9Lun2Q5UE9DiY9+yMYGU73ZF1YtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:59192 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab3KEMnD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Nov 2013 07:43:03 -0500
In-Reply-To: <CAJMJAuMQH_kd_B=3DKxZUa9Lun2Q5UE9DiY9+yMYGU73ZF1YtA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bill Hastings <bllhastings@gmail.com>
Cc: ceph-devel@vger.kernel.org

RADOS does not depend on MDS, however, MDS does depend on RADOS to 
permanently store metadata.
It is not very clear what do you define the integrity of librados.

On 11/04/2013 12:16 PM, Bill Hastings wrote:
> Hi All
>
> We are planning to test Ceph for certain use cases. But how do folks
> usually measure integrity of librados i.e what kind of tests are run
> to measure integrity of the block device. Does RADOS also depend on
> MDS?
>
> Thanks
> Bill
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
