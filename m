From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: CRUSH. What wrong?
Date: Mon, 30 May 2011 12:34:23 +0300
Message-ID: <4DE3649F.60407@ufm.su>
References: <4DE24862.5080109@ufm.su> <Pine.LNX.4.64.1105292052300.25744@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:47225 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636Ab1E3Je1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 May 2011 05:34:27 -0400
In-Reply-To: <Pine.LNX.4.64.1105292052300.25744@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/30/2011 06:54 AM, Sage Weil wrote:
> Hi Fyodor,
>
> The problem is your rules:
>
> On Sun, 29 May 2011, Fyodor Ustinov wrote:
>> # rules
>> rule data {
>>          ruleset 0
>>          type replicated
>>          min_size 1
>>          max_size 10
>>          step take root
>>          step choose firstn 0 type rack
> This is giving you N _racks_.  You probably want
>
>           step chooseleaf firstn 0 type rack
>
> which will give you N devices from distinct racks.
Mea culpa. :(

Thnx!

WBR,
     Fyodor.
