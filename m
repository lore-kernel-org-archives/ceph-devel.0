From: star fan <jfanix@gmail.com>
Subject: Re: Ask help for boost::statechart in PG
Date: Mon, 1 Sep 2014 16:30:37 +0800
Message-ID: <CAOdVJi0_UY6iCfsO3qp4FZ7bLAU0izgaunLoraAfbcpo+2ZURQ@mail.gmail.com>
References: <CAOdVJi2e2cBOwRk8TS4Te2eZ1NO2hw26zL6M3Mq94pv60Z9vWQ@mail.gmail.com>
	<alpine.DEB.2.00.1408300913230.966@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33323 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbaIAIaj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Sep 2014 04:30:39 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so12107803wib.16
        for <ceph-devel@vger.kernel.org>; Mon, 01 Sep 2014 01:30:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408300913230.966@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Thanks.

Follow your explanation,  I understand as below:
>1.  why there is not react function for custom_reaction< NullEvt >
 NullEvt event is handled by react(const boost::statechart::event_base&)
> 2. why there is not custom_reaction definition about boost::statechart::result react(const MNotifyRec&)
But I can't find any children of Initial which has definition about
MNotifyRec event. Is Primary a children of Initial?

Do I understand correct?


2014-08-31 0:14 GMT+08:00 Sage Weil <sweil@redhat.com>:
> On Sat, 30 Aug 2014, star fan wrote:
>> I ask the question because I am not good at  boost::statechart and I
>> can't get answer from other way.
>>
>> To help me to good understand the PG statechart, I hope someone answer
>> below questions:
>> In Initial state,
>> 1.  why there is not react function for custom_reaction< NullEvt >
>> 2. why there is not custom_reaction definition about
>> boost::statechart::result react(const MNotifyRec&);
>
> One thing to keep in mind is that the states form a hierarchy.  If a state
> doesn't explicitly handle/react to an event, the parent will.  You'll
> notice that Reset and Started both react to NullEvt, and the other states
> are substates/children of those.
>
> sage
