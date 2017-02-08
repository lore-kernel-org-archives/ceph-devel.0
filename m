From: Daniel Swarbrick <daniel.swarbrick@profitbricks.com>
Subject: Re: switch "ms bind ipv6" default to "true"?
Date: Wed, 8 Feb 2017 19:34:01 +0100
Message-ID: <o7foak$rob$1@blaine.gmane.org>
References: <CALqRxCxqUP6V0enicL4EM=aeH1Qt5G0vvmcrqQrmAa9TirpLoQ@mail.gmail.com>
 <1330200336.9468.1486571050945@ox.pcextreme.nl>
 <alpine.DEB.2.11.1702081658100.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:34691 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbdBHSgD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 13:36:03 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
        id 1cbX46-0007hm-DU
        for ceph-devel@vger.kernel.org; Wed, 08 Feb 2017 19:34:02 +0100
In-Reply-To: <alpine.DEB.2.11.1702081658100.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 08/02/17 17:59, Sage Weil wrote:
> On Wed, 8 Feb 2017, Wido den Hollander wrote:
>>
>> Isn't it possible that this causes troubles when explicitly setting 
>> public and/or cluster network?
> 
> Yeah.  But I think even more importantly, it assumes that the host is 
> using ipv6, which it might not be.  Currently the messenger *either* uses 
> ipv4 or ipv6, but it can't do both.

Assuming that the cluster / public network has not been explicitly set,
can't we bind in such a way that it will accept either, i.e., bind an
IPv6 socket and setsockopt IPV6_V6ONLY = 0?

Most network daemons these days seem to be moving towards that trend. We
would just need to check for non-IPv6 capable IP stacks (seriously...?)
before the bind, in which case it's a moot point anyway.

