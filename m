From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 7/8] rbd: do not read in parent info before snap context
Date: Fri, 25 Jul 2014 07:46:05 -0500
Message-ID: <53D2518D.7060007@ieee.org>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>	<1406191369-6746-8-git-send-email-ilya.dryomov@inktank.com>	<53D211F4.7060006@ieee.org> <CALFYKtAzJZktOMBRHqfCF4mbqMgwF07JpuAsxOHFYEoWABeSsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:56800 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbaGYMqF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 08:46:05 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so3627531ieb.35
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 05:46:04 -0700 (PDT)
In-Reply-To: <CALFYKtAzJZktOMBRHqfCF4mbqMgwF07JpuAsxOHFYEoWABeSsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 07/25/2014 03:36 AM, Ilya Dryomov wrote:
>> >
>>> >> +     if (ret)
>>> >> +             return ret;
> I'll move this bit to "harden rbd_dev_refresh()" commit.

Sounds good.	-Alex
