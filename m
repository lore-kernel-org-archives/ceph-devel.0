From: Gregory Farnum <greg@gregs42.com>
Subject: Re: load-gen from an osd node
Date: Wed, 1 Jul 2015 17:04:45 +0100
Message-ID: <CAC6JEv_pNYxaWs3SFxqYMrYyaWei79x_61g5Nt6D=uQxQh7qnQ@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669AEA37@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34872 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbbGAQEr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jul 2015 12:04:47 -0400
Received: by igblr2 with SMTP id lr2so101036243igb.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jul 2015 09:04:46 -0700 (PDT)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com. [209.85.213.174])
        by mx.google.com with ESMTPSA id z195sm1637842iod.33.2015.07.01.09.04.45
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2015 09:04:45 -0700 (PDT)
Received: by igrv9 with SMTP id v9so77391830igr.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jul 2015 09:04:45 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669AEA37@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hmm, the only changes I see between those two versions are some pretty
precise cleanups which shouldn't cause this. But it means that a
bisect or determined look should be easy. Can you create a ticket
which includes the exact output you're seeing and the exact versions
you're running?
-Greg

On Mon, Jun 29, 2015 at 11:27 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
> Oh, I just noticed that the client nodes I spoke of where load-gen actually worked were
> running 0.94, not 9.0.1.  And when I upgrade them to 9.0.1, load-gen no longer works.
>
> So more likely this is just a problem with newer rados load-gens
>
> -- Tom
>
>
>
>> -----Original Message-----
>> From: Deneau, Tom
>> Sent: Friday, June 26, 2015 7:48 PM
>> To: ceph-devel
>> Subject: load-gen from an osd node
>>
>> I am running 9.0.1 and I noticed when I run rados load-gen from one of the
>> osd nodes, it creates the objects but then always reports a throughput of 0
>> MB/sec.
>>
>> But if I run it from a separate client node, it works fine.
>> Why would this be?
>>
>> I'm not sure but I thought in earlier versions load-gen could be run from an
>> osd node.
>>
>> -- Tom Deneau
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
