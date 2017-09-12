From: Sage Weil <sage@newdream.net>
Subject: Re: On monitor development, bugs, and reviews
Date: Tue, 12 Sep 2017 19:55:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709121951490.24068@piezo.novalocal>
References: <dadfa535-5759-f918-cb69-c9e936229bf0@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52236 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdILTz1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Sep 2017 15:55:27 -0400
In-Reply-To: <dadfa535-5759-f918-cb69-c9e936229bf0@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Kefu Chai <kchai@redhat.com>

On Tue, 12 Sep 2017, Joao Eduardo Luis wrote:

> Hi everyone,
> 
> 
> As you all are certainly aware, the monitors are quite the critical part of
> Ceph: if we don't have a quorum, the cluster will cease responding to
> requests. For this reason, we tend to be extremely conservative when it comes
> to changing or adding things, and, personally, I've grown a bit paranoid when
> it comes to change them significantly.
> 
> However, I believe it is time we change quite a bit on the monitors, to avoid
> mistakes that have become easier to make as time passed, and to make the
> monitors a lot more resilient. While most of these issues have always been
> present in our minds, as our contributor base grows we are bound to have
> people changing parts of the code that may be trickier, and whose nuances may
> have annoying side-effects.
> 
> This became more obvious over the course of Luminous (although this has been a
> problem for longer); I've noticed that there were quite a few bugs introduced
> in the monitors due to how tricky it is to deal with all the paxos services'
> internal data structures consistency requirements.
> 
> To illustrate this a bit, the most common sources of silent bugs (since ever,
> really) tend to be:
> 
> - changing the pending map values based on uncommitted state;
> - changing the committed map value;
> - changing pending map values and not waiting for the value to be committed
> before returning to the user;
> - validating error conditions after changing the pending map, and returning
> error having changed pending map values.
> 
> On top of this, we sometimes get a few bugs resulting from returning either
> 'true' or 'false' in a 'preprocess_query()' when it should have been the
> opposite.
> 
> I've also realized we've had a few other bugs that resulted from
> misunderstanding how the new 'paxos plug' mechanism works. This was a
> mechanism we introduced to allow cross-service proposals in one go, but at the
> time we didn't add any sanity or validation mechanisms to ensure
> readability/writeability on individual services. While this decision
> guaranteed that we would not be destabilizing the monitors just before the
> release, it introduced a new vector for mistakes to happen.
> 
> Over the course of Mimic I intend to go over a significant rework of the paxos
> services (discussing on CDM, lists), with the intent to make them easier to
> contribute to. Whatever change we introduce will likely not be a silver
> bullet, and the changes will need to be conservative and incremental. I will
> make an effort to accompany any changes with proper developer documentation --
> although this should also be done for the current interface :)

I think one good place to start would be building a framework around the 
CLI commands.  If you look at FSCommand it provides a structured way to 
implement commands that doesn't add to the nasty if/else pile in the 
OSDMonitor and elsewhere.
 
> In the mean time -- although this should be viewed as a general rule --,
> please be mindful of any significant changes you introduce. We would prefer
> smaller, incremental changes, unless otherwise unavoidable.
> 
> And, please, always have someone familiar with the monitors reviewing it
> first, before merging. I would suggest me and/or Kefu, at the very least. And
> if, for some reason, we are not responsive, feel free to poke us on IRC or the
> list*.

+1

sage

> 
> 
> Cheers!
> 
>   -Joao
> 
> * Sorry Kefu, I just told everyone to poke you for PRs ;)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
