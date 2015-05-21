From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: firewall questions
Date: Thu, 21 May 2015 14:33:36 -0600
Message-ID: <555E4120.2040603@redhat.com>
References: <555CE992.10703@redhat.com> <alpine.DEB.2.00.1505201551450.23818@cobra.newdream.net> <555DFB71.6050602@redhat.com> <alpine.DEB.2.00.1505210837480.23818@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45140 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505AbbEUUdh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 May 2015 16:33:37 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 0A02FA10A7
	for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 20:33:37 +0000 (UTC)
Received: from mbp.ktdreyer.com (vpn-62-245.rdu2.redhat.com [10.10.62.245])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4LKXa6X014226
	for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 16:33:36 -0400
In-Reply-To: <alpine.DEB.2.00.1505210837480.23818@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/21/2015 09:37 AM, Sage Weil wrote:
> On Thu, 21 May 2015, Ken Dreyer wrote:
>> I think that would mean we'd want to open 6800-7300 by default?
>>
>> And for this firewalld service name, I was thinking of naming this
>> 6800-7300 rule "ceph", since it encompasses both the OSD and MDS
>> services. Does that name sound ok? (And I'd name the 6789 rule "ceph-mon".)
> 
> Yep, sounds good to me!
> 

Cool. New Ceph configs submitted to firewalld at
https://github.com/t-woerner/firewalld/pull/22

I've also updated our own docs re: iptables, at
https://github.com/ceph/ceph/pull/4740

- Ken
