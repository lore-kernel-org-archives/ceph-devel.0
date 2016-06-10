From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: A Transformation of our Global Context
Date: Sat, 11 Jun 2016 00:57:23 +0100
Message-ID: <575B53E3.90102@suse.de>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
 <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
 <20160610201543.GC29233@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606101638520.6221@cpach.fuggernut.com>
 <20160610204549.GB7952@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606101651280.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56455 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbcFJX50 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 19:57:26 -0400
In-Reply-To: <alpine.DEB.2.11.1606101651280.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Adam C. Emerson" <aemerson@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 06/10/2016 09:53 PM, Sage Weil wrote:
> On Fri, 10 Jun 2016, Adam C. Emerson wrote:
>> On 10/06/2016, Sage Weil wrote:
>>> FWIW the time thing is a bit of a red herring.  The only reason time takes
>>> cct is for the configuration clock skew.  That was added for debugging
>>> purposes but has never (to my knowledge) been used.  I'd be happy to rip
>>> it out.
>>
>> I wasn't aware of that. I'd asked once if the clock skew debug option
>> was really important (back with the original time patch) and was told
>> it was. The person I was talking to might have thought I was talking
>> about monitor clock skew or something.
>
> Ah, there is *one* teuthology test that sets this:
>
> $ git grep clock\ offset | cat
> suites/rados/multimon/tasks/mon_clock_with_skews.yaml:        clock offset: 10
>
> I'd be quite happy to drop this test, or kludge around it some other way
> (e.g., put a mon on a different host and change the system time), if it
> saves us as much code churn as I suspect it will...

i've been hacking a mon debug interface via the ceph tool to test 
features and do all sorts of nasty things (provided a given experimental 
feature is enabled and the user is really, really sure about it), and I 
think we could then use it to test clock skews just as well. It'd be a 
matter of telling a given monitor to just skew the response to the 
leader during the timecheck round.

   -Joao

