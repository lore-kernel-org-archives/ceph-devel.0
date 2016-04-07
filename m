From: Mark Nelson <mnelson@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 15:40:28 -0500
Message-ID: <5706C5BC.4090006@redhat.com>
References: <5703A7FF.2090002@suse.com>
 <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
 <5704C76C.2050408@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34043 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757331AbcDGUkc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Apr 2016 16:40:32 -0400
In-Reply-To: <5704C76C.2050408@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 04/06/2016 03:23 AM, Owen Synge wrote:
> Dear Greg and others,
>
> Thankyou for your very helpful email, as it completely misses my point,
> and that illustrate why this point is so important to be addressed.
>
> I am sure Greg has a deep understanding of this area. But I am pleased
> Greg missed my points from 0-9, Greg's assumption that it is lack of
> understanding on my part (which I am sure is common), clearly
> illustrates where this "magic" of the side effect of starting a mon
> demon becomes becomes "dark magic".
>
> If you object to "magic" and "dark magic" in this email please
> substitute them with "side effect" and "negative consequences of side
> effects" respectively, and you get a more serious reply :)
>

FWIW, I wanted to chime in and say that anything we can do to generally 
reduce instances of "dark magic" like this would be fantastic.

Back when mkcephfs was retired a couple of years ago I had to decide 
what I should replace it with in CBT.  Ultimately it was concern over 
issues like this that lead me to utilize the underlying key/mon/osd 
creation tools directly.  Your point about confusion is totally valid. 
I use ceph-authtool and had only a vague idea that ceph-create-keys even 
existed (and certainly didn't realize the behavior your describing).  I 
create ceph clusters (using CBT) to test performance pretty much daily!

Looking at the documentation, it's pretty easy to miss what's going on:

http://docs.ceph.com/docs/master/man/8/ceph-create-keys/

ceph-authtool is a little better documented:

http://docs.ceph.com/docs/hammer/man/8/ceph-authtool/

It *is* scary when software behaves in mysterious ways.  It doesn't 
invoke trust and it's not the kind of first impression to make with 
already paranoid sysadmins (Being a paranoid ex-sysadmin myself).  I 
think our heart was in the right place to try to reduce the number of 
steps required in ceph-deploy, but it can't come at the expense of 
introducing ambiguity and complexity like this.

Anyway, that's my 2C.

Mark
