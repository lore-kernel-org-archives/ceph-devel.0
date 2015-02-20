From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Fri, 20 Feb 2015 10:12:46 -0600
Message-ID: <54E75CFE.70601@redhat.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com> <3649A15A2562B54294DE14BCE5AC79120AB30EEA@FMSMSX106.amr.corp.intel.com> <54B6F103.9000708@redhat.com> <3649A15A2562B54294DE14BCE5AC79120AB31012@FMSMSX106.amr.corp.intel.com> <54C7FD1C.40406@redhat.com> <54E6F96B.9080202@ubuntu.com> <CA+z5DszfGOE3bE0M6ti-4GyRj2CXypsNRv1J=6Wx4b65NqE=Vg@mail.gmail.com> <54E754DA.6060703@redhat.com> <252858605.1545602.1424448205171.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50627 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932066AbbBTQNB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Feb 2015 11:13:01 -0500
In-Reply-To: <252858605.1545602.1424448205171.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Blair Bethwaite <blair.bethwaite@gmail.com>, James Page <james.page@ubuntu.com>, ceph-devel <ceph-devel@vger.kernel.org>, Stephen L Blinick <stephen.l.blinick@intel.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Colin Ian King <colin.king@canonical.com>, Patricia Gaughen <patricia.gaughen@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>



On 02/20/2015 10:03 AM, Alexandre DERUMIER wrote:
>>> http://rhelblog.redhat.com/2015/01/12/mysteries-of-numa-memory-management-revealed/
>>> It's possible that this could be having an effect on the results.
>
> Isn't auto numa balancing enabled by default since kernel 3.8 ?

No idea, I'm behind the times on what's been going on with numa tuning.

>
> it can be checked with
>
> cat /proc/sys/kernel/numa_balancing

At least at first glance it doesn't look like it's enabled on either our 
RHEL7 or Ubuntu nodes.  No numad running either.
