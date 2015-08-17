From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Signed-off-by and aliases
Date: Mon, 17 Aug 2015 13:58:27 -0700
Message-ID: <mqthtj$jp4$1@ger.gmane.org>
References: <55BBD384.7030703@dachary.org> <CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com> <55BFCAAB.1040707@dachary.org> <CAC6JEv-teZ0jq-t7f+==e0f5BQHAD4qrm5EOFMWJ1+g8zqLHcQ@mail.gmail.com> <55CB4163.9040504@dachary.org> <55CDABB2.4080401@suse.de> <55CDC978.20304@dachary.org> <mqtfkc$ic7$1@ger.gmane.org> <55D24790.4010703@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34135 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbbHQU6k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Aug 2015 16:58:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZRRUK-0004hW-Vs
	for ceph-devel@vger.kernel.org; Mon, 17 Aug 2015 22:58:37 +0200
Received: from 66-87-139-27.pools.spcsdns.net ([66-87-139-27.pools.spcsdns.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2015 22:58:36 +0200
Received: from eternaleye by 66-87-139-27.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2015 22:58:36 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Loic Dachary wrote:

> Hi Alex,
> 
> On 17/08/2015 22:19, Alex Elsayed wrote:
<snip>
>> This is where I see a subtle, but meaningful distinction: Accepting from
>> aliases *which have submitted a DCO* means that the person behind the
>> alias, even if we don't know their name, has bound themselves to a
>> standard ov behavior.
>> 
>> Accepting from arbitrary aliases does _not_ carry that meaning.
> 
> Yes. Although we don't do formal background checks, we make sure that each
> commit is Signed-off-by: the author as required by
> https://github.com/ceph/ceph/blob/master/SubmittingPatches#L22 which is
> linked from the https://github.com/ceph/ceph/blob/master/CONTRIBUTING.rst
> document that shows whenever someone submits a pull request.
> 
> I also believe this is an important distinction and I would feel
> uncomfortable if Ceph accepted contributions (aliases or not) that are not
> Signed-off one way or the other.

The kernel does something slightly different, in a very careful manner: 
Signed-off-by says that you have _submitted_ the DCO - as in, you must have, 
from the same address as you signed off by, emailed the DCO itself to the 
list.

The S-o-B tag, then, simply says "If you look, you'll find my affirmation of 
intent to follow the DCO" - it is not, in itself, anything other than a 
pointer. This prevents people from copypasta'ing the S-o-B line as a magic 
incantation, without understanding the meaning. (Which the kernel has found 
_does_ happen _anyway_, but with the "actually submitted a DCO" requirement 
they can _detect_ that.)

