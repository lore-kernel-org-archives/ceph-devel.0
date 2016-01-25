From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: About ceph_clock_now()
Date: Mon, 25 Jan 2016 11:57:08 +0100
Message-ID: <56A5FF84.8080107@digiware.nl>
References: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <56A368C1.8000508@digiware.nl>
 <747915460.23855157.1453580447803.JavaMail.zimbra@redhat.com>
 <20160123215543.GA8011@ultraspiritum.redhat.com>
 <56A4BB20.1040305@digiware.nl> <56A4C8D2.6020303@digiware.nl>
 <20160125000337.GA19230@ultraspiritum.redhat.com>
 <56A5E61E.80705@digiware.nl>
 <2002283349.16405061.1453715910495.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:45368 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbcAYK5P (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jan 2016 05:57:15 -0500
In-Reply-To: <2002283349.16405061.1453715910495.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Erwan Velu <evelu@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 25-1-2016 10:58, Erwan Velu wrote:
>> I would comment the last section: the #else with a remark that you
>> select POSIX if nothing else, but that POSIX is more/unneeded accurate
>> and slow.
>
> I totally agree with your comment.
> I'm pretty boring on that topic but keeping a well documented commit (in the commit message) that explains the following is very useful when reading a patch later.
> - what was the issue
> - how we fixed it

I would even keep it in the code so that somebody looking at it understands
that the system default for a reason to slower POSIX.
Especially in porting circumstances this is important.
And even more so, now it is almost impossible to detect this compiletime.

I ran into it bacause only one option was there: *COARSE, so my build 
bombed out.
Now it it will select the slow POSIX if I don not have *COARSE or *FAST, 
and
merrily compile on.

So you'd only find this then running benchmarks and notice significant 
slowdown.

Come to think of it, it might even warrant a #warning line in the POSIX 
case,
to suggest to look into the 'man clock_gettime' page and see if the new 
OS has
something better.

--WjW
