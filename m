From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: MDS crashes (80.8)
Date: Thu, 26 Feb 2015 14:05:30 -0500
Message-ID: <CAGbvivJ4mgXgEnd5Xg3DDp2R0Qx10eNrqtOYvj5ttg02ZHBc5g@mail.gmail.com>
References: <CAGbvivJQYb6KpZPW0ug_q7rbL_NYB2eGS+Vcktvy_W3ECHxKbA@mail.gmail.com>
	<54EF527B.8060403@redhat.com>
	<CAGbvivK+oHAfD3bURzDyRDsoBtKtmp35ZZ-YC7kLyLXD6mQ6fQ@mail.gmail.com>
	<54EF5CF0.3030503@redhat.com>
	<CAGbvivKiuJ1UrACb2W_fX+8TFDvJ0XrayGYXjL3qGRWZMCPSYg@mail.gmail.com>
	<54EF5F6C.8030305@redhat.com>
	<CAGbvivL_5TDYXPbz6Pu7OKrU3WdATY0CY5qDTgUs-qSqwQvX7g@mail.gmail.com>
	<54EF637A.7030906@redhat.com>
	<CAGbvivLaKuOq999tC3OWnwOJrq1Hf4FVnbvCESdMPGbfCetZsA@mail.gmail.com>
	<54EF66C0.9020901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:44685 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbbBZTFb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 14:05:31 -0500
Received: by mail-ob0-f181.google.com with SMTP id vb8so13309834obc.12
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 11:05:30 -0800 (PST)
In-Reply-To: <54EF66C0.9020901@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: ceph-devel@vger.kernel.org

You are corrrect, my keys were not configured correctly.  All are
healthy and working now, thanks for your help.

-Wyllys

On Thu, Feb 26, 2015 at 1:32 PM, John Spray <john.spray@redhat.com> wrote:
> On 26/02/2015 18:27, Wyllys Ingersoll wrote:
>>
>> Excellent, thanks.
>>
>> It starts now without crashing, but I see lots of errors like this:
>>
>> 2015-02-26 08:24:19.134693 7f78091aa700  0 cephx: verify_reply
>> couldn't decrypt with error: error decoding block for decryption
>> 2015-02-26 08:24:19.134695 7f78091aa700  0 -- 10.2.3.33:6800/5236 >>
>> 10.2.2.104:6857/8883 pipe(0x26f5700 sd=33 :50680 s=1 pgs=0 cs=0 l=1
>> c=0x280b1e0).failed verifying authorize reply
>> 2015-02-26 08:24:19.134717 7f7809bb4700  0 cephx: verify_reply
>> couldn't decrypt with error: error decoding block for decryption
>> 2015-02-26 08:24:19.134719 7f7809bb4700  0 -- 10.2.3.33:6800/5236 >>
>> 10.2.3.111:6848/4652 pipe(0x26f4300 sd=23 :58785 s=1 pgs=0 cs=0 l=1
>> c=0x2694c00).failed verifying authorize reply
>> 2015-02-26 08:24:19.134761 7f78093ac700  0 cephx: verify_reply
>> couldn't decrypt with error: error decoding block for decryption
>> 2015-02-26 08:24:19.134764 7f78093ac700  0 -- 10.2.3.33:6800/5236 >>
>> 10.2.3.105:6842/5408 pipe(0x26f5c00 sd=30 :38240 s=1 pgs=0 cs=0 l=1
>> c=0x280a000).failed verifying authorize reply
>>
> It would appear that something is wrong with your deployment, such as
> missing keys.  You might want to take this issue to ceph-users to see if
> anyone can help with whatever system you were using to deploy these
> services.
>
> John
