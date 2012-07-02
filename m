From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Does radosgw really need to talk to an MDS?
Date: Mon, 02 Jul 2012 13:44:14 +0200
Message-ID: <4FF1898E.7000202@widodh.nl>
References: <CAPUexz9T+qzyDwSs6f-Bq7_1d_jMfBBEwBHUpY+QdhZYTekmsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51335 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab2GBLoR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 07:44:17 -0400
In-Reply-To: <CAPUexz9T+qzyDwSs6f-Bq7_1d_jMfBBEwBHUpY+QdhZYTekmsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 02-07-12 13:41, Florian Haas wrote:
> Hi everyone,
>
> radosgw(8) states that the following capabilities must be granted to
> the user that radosgw uses to connect to RADOS.
>
> ceph-authtool -n client.radosgw.gateway --cap mon 'allow r' --cap osd
> 'allow rwx' --cap mds 'allow' /etc/ceph/keyring.radosgw.gateway
>
> Could someone explain why we need an "mds 'allow'" in here? I thought
> only CephFS clients talked to MDSs, and at first glance configuring
> client.radosgw.gateway without any MDS capability seems not to break
> anything (at least with my limited S3 tests). Am I missing something?
>

You are not allowing the RADOS Gateway to do anything on the MDS.

There is no 'r',  'w' or 'x' permission which you are allowing. So there 
is nothing the rgw has access to on the MDS.

Wido

> Cheers,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

