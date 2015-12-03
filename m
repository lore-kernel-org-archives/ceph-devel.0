From: Samuel Just <sjust@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 09:52:47 -0800
Message-ID: <CAN=+7FU_vkNdD-AQfD-wnbDpxRJB2z0d-_22pSuEjciyOr096Q@mail.gmail.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
	<CO1PR02MB2087E3AF3553B6269FBC10DF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<20151203172508.GB13420@ultraspiritum.redhat.com>
	<CO1PR02MB208C446A80363743FC5D341F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<CAN=+7FU1z9w=dDZ8+qbvKu-_ucYEU8K0eKS99Pd6Ku=A=t2gWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35445 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbLCRws convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 12:52:48 -0500
Received: by igl9 with SMTP id 9so16239568igl.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 09:52:47 -0800 (PST)
In-Reply-To: <CAN=+7FU1z9w=dDZ8+qbvKu-_ucYEU8K0eKS99Pd6Ku=A=t2gWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

To be clear, I'm ok with having a queue_transaction which takes a
Transaction by value and moves it into a dynamic unique_ptr controlled
instance, but I don't want the filestore passing a naked pointer
around internally with a flag indicating whether it needs to be
deleted by the filestore.  If there is an actual user which requires
the transaction to stick around afterwards *and* cannot afford to copy
it, then we can talk about a design which accomplishes that.
-Sam

On Thu, Dec 3, 2015 at 9:50 AM, Samuel Just <sjust@redhat.com> wrote:
> As far as I know, there are no current users which want to use the
> Transaction later.  You could also change apply_transaction to copy
> the Transaction into a unique_ptr since I don't think it's used in any
> performance sensitive code paths.
> -Sam
>
> On Thu, Dec 3, 2015 at 9:48 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Yes, that we can do..But, in that case aren't we restricting user if they want to do something with this Transaction object later. I didn't go through each and every part of the code yet (which is huge) that are using these interfaces to understand if it is using Transaction object afterwards.
>>
>> Thanks & Regards
>> Somnath
>> -----Original Message-----
>> From: Adam C. Emerson [mailto:aemerson@redhat.com]
>> Sent: Thursday, December 03, 2015 9:25 AM
>> To: Somnath Roy
>> Cc: Sage Weil; Samuel Just (sam.just@inktank.com); ceph-devel@vger.kernel.org
>> Subject: Re: queue_transaction interface + unique_ptr + performance
>>
>> On 03/12/2015, Somnath Roy wrote:
>>> Yes, I posted the new result after adding -O2 in the compiler flag and it shows almost no overhead with unique_ptr.
>>> I will add the test of adding to list overhead and start implementing the new interface.
>>> But, regarding my other point of changing all the objecstore interfaces (my first mail on this mail chain in case you have missed) taking Transaction, any thought of that ?
>>> Should we reconsider having two queue_transaction interface ?
>>
>> As I understand it, the concern with switching to unique_ptr was that the callee would move from the reference without this being known to the caller.
>>
>> Would it make sense to pass as an RValue reference (i.e. TransactionRef&&)? That way the compiler should demand that the callers explicitly use std::move on the reference they're holding, documenting at the site of the call that they're willing to give up ownership.
>>
>>
>> --
>> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
>> IRC: Aemerson@{RedHat, OFTC, Freenode}
>> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
