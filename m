From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: long object names
Date: Fri, 22 Apr 2011 09:34:59 -0700
Message-ID: <20110422163459.GA16595@dreamer>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
 <20110421185606.GC9431@dreamer>
 <BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
 <20110421193240.GA26545@dreamer>
 <99672323C62444DFA181A0659E4D37FC@gmail.com>
 <20110421220044.GB26545@dreamer>
 <BANLkTikCG487GB=n+9eT+66hxBVk_gfwqw@mail.gmail.com>
 <20110421230744.GC26545@dreamer>
 <Pine.LNX.4.64.1104220818210.15351@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43054 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756154Ab1DVQev (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2011 12:34:51 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1104220818210.15351@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Fri, Apr 22, 2011 at 08:44:49AM -0700, Sage Weil wrote:
> - We can easily wrap the non-fast past with a mutex to avoid the races 
> (because, again, collisions are vanishingly rare except in our test 
> cases).

How do you guard against crashes, e.g. the create+set_xattr crashing
before set_xattr?

How do you guard against gaps in the sequence number thing? (Perhaps
make that part a random string, and change consumers to listdir
instead of probing 1,2,3...)

How do you convince yourself you've covered all the races?

> - For simplicity, I still think the simplest thing will be to push all the 
> escaping/mangling into one layer.  Once place to audit and unit test.

I think the big functional benefit with that is that you can have the
suffix not be obscured by the hash; FOO_a43fec_n_head not FOO_a43fec_n

-- 
:(){ :|:&};:
