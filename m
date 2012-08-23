From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: How to increase the number of pgs at pool creation time?
Date: Thu, 23 Aug 2012 15:17:15 -0600
Message-ID: <50369DDB.8020905@sandia.gov>
References: <CANLRBoxdu7iPvBU45T5Nk0zDYT1QSX9-oyo4g1nEav-+ybGA4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:36368 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756822Ab2HWVSk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Aug 2012 17:18:40 -0400
In-Reply-To: <CANLRBoxdu7iPvBU45T5Nk0zDYT1QSX9-oyo4g1nEav-+ybGA4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: ceph-devel@vger.kernel.org

On 08/23/2012 02:39 PM, Tren Blackburn wrote:
> 2) Increase the number of pgs via ceph.conf (osd pg bits = 7) and
> create the cluster. This does not work either as the cluster comes up
> with 6 pgs bits per osd still.
>      re:http://ceph.com/docs/master/config-cluster/osd-config-ref/

I use this regularly.  Do you have that in your global section, i.e.

[global]
	osd pg bits = 7
	osd pgp bits = 7


-- Jim

