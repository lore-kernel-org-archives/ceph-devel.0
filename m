From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Poor read performance in KVM
Date: Mon, 30 Jul 2012 01:01:08 +0930
Message-ID: <5015573C.6040305@bashkirtsev.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com> <50080D9D.8010306@bashkirtsev.com> <50085518.80507@inktank.com> <500984AC.9030104@bashkirtsev.com> <CADvuQRG1z0YQezCoJhCNFnC+03UDv6H3aJPUWBcbBw3-iUnA8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:60563 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab2G2PcK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Jul 2012 11:32:10 -0400
In-Reply-To: <CADvuQRG1z0YQezCoJhCNFnC+03UDv6H3aJPUWBcbBw3-iUnA8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 21/07/12 02:12, Tommi Virtanen wrote:
> But it leaves me with very final question: should we rely on btrfs at this
> point given it is having such major faults? What if I will use well tested
> by time ext4?
> You might want to try xfs. We hear/see problems with all three, but
> xfs currently seems to have the best long-term performance and
> reliability.
>
> I'm not sure if anyone's run detailed tests with ext4 after the
> xattrs-in-leveldb feature; before that, we ran into fs limitations.
Just reporting back what was going on for last week. I have rebuilt all 
OSDs with fresh btrfs and leaf size of 64K. Straight after rebuild 
everything was flying! But mysql processing I wrote about continued and 
whole cluster was brought again to a stand still in a week. I have done 
some investigation as to causes and it appears that fragmentation went 
ballistic. Reading somewhere on the net I have seen suggestion that if 
cow is not really needed then btrfs mounted with nocow option less 
likely to get overly fragmented. Haven't tried it actually but wondering 
will ceph cope well with nocow? ie does it rely on cow feature? 
Something tells me that as ceph can run on FS which does not have cow we 
actually can mount nocow. Just need some confirmation from devs.

In the mean time I opted to convert all OSDs to xfs. Even after 
rebuilding only two OSDs performance boost is apparent again. So it 
appears that btrfs as it currently is in 3.4.6 is not up to prime time 
and good number of random writes consistently bring it to a halt.

As xfs apparently have its own share of problems when ageing I think 
that periodic online defragmentation may bring xfs back to reasonable 
condition. Have anyone tried xfs defragmentation while ceph uses it?
