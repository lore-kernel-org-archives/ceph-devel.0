From: Casey Bodley <cbodley@redhat.com>
Subject: Re: presentation: making rgw's process_request() asynchronous
Date: Tue, 21 Nov 2017 12:25:34 -0500
Message-ID: <4a9f92bd-d595-a1be-3519-6b50dac53ec9@redhat.com>
References: <ced1785c-834d-d32d-bca6-42e366801e00@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:44853 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdKURZh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Nov 2017 12:25:37 -0500
Received: by mail-qt0-f175.google.com with SMTP id h42so20139407qtk.11
        for <ceph-devel@vger.kernel.org>; Tue, 21 Nov 2017 09:25:36 -0800 (PST)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id g32sm9696694qkh.74.2017.11.21.09.25.34
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 09:25:35 -0800 (PST)
In-Reply-To: <ced1785c-834d-d32d-bca6-42e366801e00@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

The recording is available here: https://bluejeans.com/s/DMYtT/

Etherpad: http://pad.ceph.com/p/rgw_async_process_request


On 11/16/2017 01:22 PM, Casey Bodley wrote:
> Hi all,
>
> I've been working on a new http frontend for rgw over the past year 
> and a half that's based on boost::asio and the beast http library. 
> We're aiming to remove its 'experimental' status for the mimic release.
>
> Since that project started, I've been brainstorming ways to take 
> advantage of asio's asynchronous primitives throughout more of rgw. I 
> think I've finally landed on a good strategy to incrementally convert 
> process_request() (the main entrypoint for http requests) to be fully 
> asynchronous when used with the beast frontend, without changing how 
> the existing civetweb frontend works at all. The end result would 
> allow us to serve more concurrent requests, reduce the number of 
> threads needed, and plug in qos/prioritization features that would 
> otherwise block frontend threads.
>
> I'd like to present this to the rgw team and do a short code 
> walkthrough to show what it looks like. Anyone else that's interested 
> is more than welcome to join us next Tuesday, Nov 21 at 11am EST in 
> https://bluejeans.com/u/cbodley/. I'll share the recording for anyone 
> that can't make it.
>
> Casey

