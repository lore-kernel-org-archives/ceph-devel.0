From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: presentation: making rgw's process_request() asynchronous
Date: Wed, 22 Nov 2017 01:38:19 +0800
Message-ID: <CACKY0b8pO47T1Y76upnBsdDfrADA6OXzdBKA7HZmiut9ChaF2g@mail.gmail.com>
References: <ced1785c-834d-d32d-bca6-42e366801e00@redhat.com> <4a9f92bd-d595-a1be-3519-6b50dac53ec9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36348 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdKURiV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Nov 2017 12:38:21 -0500
Received: by mail-lf0-f42.google.com with SMTP id k66so15106119lfg.3
        for <ceph-devel@vger.kernel.org>; Tue, 21 Nov 2017 09:38:20 -0800 (PST)
In-Reply-To: <4a9f92bd-d595-a1be-3519-6b50dac53ec9@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Thanks for sharing

2017-11-22 1:25 GMT+08:00 Casey Bodley <cbodley@redhat.com>:
> The recording is available here: https://bluejeans.com/s/DMYtT/
>
> Etherpad: http://pad.ceph.com/p/rgw_async_process_request
>
>
>
> On 11/16/2017 01:22 PM, Casey Bodley wrote:
>>
>> Hi all,
>>
>> I've been working on a new http frontend for rgw over the past year and a
>> half that's based on boost::asio and the beast http library. We're aiming to
>> remove its 'experimental' status for the mimic release.
>>
>> Since that project started, I've been brainstorming ways to take advantage
>> of asio's asynchronous primitives throughout more of rgw. I think I've
>> finally landed on a good strategy to incrementally convert process_request()
>> (the main entrypoint for http requests) to be fully asynchronous when used
>> with the beast frontend, without changing how the existing civetweb frontend
>> works at all. The end result would allow us to serve more concurrent
>> requests, reduce the number of threads needed, and plug in
>> qos/prioritization features that would otherwise block frontend threads.
>>
>> I'd like to present this to the rgw team and do a short code walkthrough
>> to show what it looks like. Anyone else that's interested is more than
>> welcome to join us next Tuesday, Nov 21 at 11am EST in
>> https://bluejeans.com/u/cbodley/. I'll share the recording for anyone that
>> can't make it.
>>
>> Casey
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
