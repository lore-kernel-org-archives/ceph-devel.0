From: Wido den Hollander <wido@widodh.nl>
Subject: Re: What ports do each of the ceph daemons listen on?
Date: Tue, 29 Mar 2011 22:55:26 +0200
Message-ID: <1301432126.2364.17.camel@wido-laptop.pcextreme.nl>
References: <AANLkTik7Q6B2mDApjWTq_AvLNhbEUTA2Ojr-gq9s=FFq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:36379 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab1C2Uz3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2011 16:55:29 -0400
In-Reply-To: <AANLkTik7Q6B2mDApjWTq_AvLNhbEUTA2Ojr-gq9s=FFq@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jay Hacker <jayqhacker@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Tue, 2011-03-29 at 16:27 -0400, Jay Hacker wrote:
> I'd like to be able to open just the required ports in my firewall.

The monitor by default binds on 6789, the mds on 6800.

OSD's bind on 6800 (if available) and increment from there, but I think
the MDS'es do the same.

For example, if you have 3 OSD's on one host, the first OSD will bind on
6800, the second on 6801, etc, etc.

Wido

> 
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


