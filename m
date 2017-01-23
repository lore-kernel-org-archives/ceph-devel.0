From: Loic Dachary <loic@dachary.org>
Subject: Re: Standalone libcrush: call for participation
Date: Mon, 23 Jan 2017 18:00:04 +0100
Message-ID: <cdb4c456-d15b-5630-2453-af94d1de0ba7@dachary.org>
References: <ea88fb94-f48f-0c2c-2ffb-4019bed66fc5@dachary.org>
 <20170123162905.GA8639@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55162 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdAWRAK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 12:00:10 -0500
Received: from mfilter42-d.gandi.net (mfilter42-d.gandi.net [217.70.178.172])
        by relay5-d.mail.gandi.net (Postfix) with ESMTP id 345C141C0A0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 18:00:08 +0100 (CET)
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
        by mfilter42-d.gandi.net (mfilter42-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id LHmv1LfKkqkd for <ceph-devel@vger.kernel.org>;
        Mon, 23 Jan 2017 18:00:06 +0100 (CET)
Received: from [192.168.3.6] (x55b4abde.dyn.telefonica.de [85.180.171.222])
        (Authenticated sender: loic@dachary.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3CE7041C0BD
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 18:00:05 +0100 (CET)
In-Reply-To: <20170123162905.GA8639@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi Adam,

On 01/23/2017 05:29 PM, Adam C. Emerson wrote:
> On 21/01/2017, Loic Dachary wrote:
> [snip]
>> The beginning of the next ceph release cycle seems like a good time
>> to initiate that effort. If someone is willing to help with the
>> bootstrap, now is a good time. The library will be hosted under the
>> libcrush.org domain name. But that's about the only thing that
>> happened so far :-)
> 
> Would the Ceph git repository continue to have its own version of
> CRUSH included, or would we pull in libcrush as a submodule?

If all goes well and libcrush becomes actively and reliably maintained outside of the Ceph tree, it could either be a submodule or even a packaged dependency. Before that happens things can stay the way they are. I volunteer to manually monitor and cherry-pick whatever changes in the Ceph tree onto the standalone repository ( http://libcrush.org/main/libcrush/ ) so that it does not drift away.

> Also, does this affect the relationship between userspace CRUSH and
> Linux kernel CRUSH?

I don't know :-) Unless I'm mistaken the code in the linux kernel is an unmodified copy of the code from src/crush/*.[ch]. I however have no clue how it is tested to work as it should in both contexts. Other than running integration tests with teuthology.

How do you suggest we go about it ?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
