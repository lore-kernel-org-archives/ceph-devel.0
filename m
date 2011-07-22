From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: My favorite question
Date: Fri, 22 Jul 2011 18:27:25 +0300
Message-ID: <4E2996DD.8040809@ufm.su>
References: <4E25646C.4000909@ufm.su> <Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:50578 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab1GVP13 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Jul 2011 11:27:29 -0400
In-Reply-To: <Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 07/19/2011 05:29 PM, Sage Weil wrote:
> On Tue, 19 Jul 2011, Fyodor Ustinov wrote:
>> Hi!
>>
>> 2011-07-19 14:00:39.509391   log 2011-07-19 14:00:34.185718 osd5
>> 10.5.51.145:6803/19737 1563 : [ERR] 0.f8 scrub stat mismatch, got 2074/2074
>> objects, 0/0 clones, 8624991435/8590119115 bytes, 8422853/8388798 kb.
>> 2011-07-19 14:00:39.509391   log 2011-07-19 14:00:34.185732 osd5
>> 10.5.51.145:6803/19737 1564 : [ERR] 0.f8 scrub 1 errors
>>
>> How to respond to this message?
> $ ceph pg repair 0.f8
>
> should do the trick!
>
> sage
Hmm... But today I seen again:

2011-07-22 17:26:51.134596   log 2011-07-22 17:26:51.010146 osd5 
10.5.51.145:6803/19737 2120 : [ERR] 0.f8 scrub stat mismatch, got 
2095/2095 objects, 0/0 clones, 8678199499/8713071819 bytes, 
8474814/8508869 kb.
2011-07-22 17:26:51.134596   log 2011-07-22 17:26:51.010159 osd5 
10.5.51.145:6803/19737 2121 : [ERR] 0.f8 scrub 1 errors

And 'ceph pg repair 0.f8' again fix:

2011-07-22 18:18:31.158248   log 2011-07-22 18:18:24.316646 osd5 
10.5.51.145:6803/19737 2122 : [ERR] 0.f8 repair stat mismatch, got 
2095/2095 objects, 0/0 clones, 8678199499/8713071819 bytes, 
8474814/8508869 kb.
2011-07-22 18:18:31.158248   log 2011-07-22 18:18:24.316680 osd5 
10.5.51.145:6803/19737 2123 : [ERR] 0.f8 repair 1 errors, 1 fixed

WBR,
     Fyodor.
