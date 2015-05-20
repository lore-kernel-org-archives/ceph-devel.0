From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: [IANA #821110] Application for a Port Number and/or Service Name
 "ceph" (fwd)
Date: Wed, 20 May 2015 23:56:26 +0100
Message-ID: <555D111A.5070106@suse.de>
References: <alpine.DEB.2.00.1504290959540.24030@cobra.newdream.net> <5541155B.7090609@redhat.com> <alpine.DEB.2.00.1504291032480.25514@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55865 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbbETW42 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 May 2015 18:56:28 -0400
In-Reply-To: <alpine.DEB.2.00.1504291032480.25514@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 04/29/2015 06:34 PM, Sage Weil wrote:
> On Wed, 29 Apr 2015, Mark Nelson wrote:
>> On 04/29/2015 12:02 PM, Sage Weil wrote:
>>> So, I picked 6789 way back in commit
>>> dc38de9b14c5386f9f446124ca6d6673eb8a1e20 because it was unused according
>>> to nmap-services.  It's there now, in use by smc-https (whatever that is),
>>> and says it was registered in 2002.  I guess the nmap-services file I
>>> looked at at the time was out of date?
>>>
>>> In any case, if we want an IANA assigned number, we'll need to change it.
>>>
>>> We should be able to make a transition reasonably painless by making
>>> clients try both ports when none is specified for some period.
>>>
>>> I'm assuming it's worth the effort... what do you think?
>>
>> Yes, I think it's worth it.  Better now than when we are 10x bigger than
>> <large storage vendor> right? ;)
> 
> Hmm, we could go for something < 1024 too, but that will make non-root 
> ceph-mon's more annoying, I suspect.
> 
> http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml?search=unassigned
> 

35168 seems available (range 35007-35353).

And before someone thinks I'm on something, 35168 is the result of:

>>> p = 0
>>> for x in reversed('ceph'):
...  j = len(str(p))
...  if p == 0:
...   j = 0
...  p += (ord(x)-ord('a')+1)*pow(10,j)


Although definitely not as easy to remember (or type) as 6789 :(

  -Joao

p.s.: 31337 is also available ;)
