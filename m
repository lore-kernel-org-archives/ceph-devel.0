From: John Spray <john.spray@redhat.com>
Subject: Re: MDS crashes (80.8)
Date: Thu, 26 Feb 2015 18:32:32 +0000
Message-ID: <54EF66C0.9020901@redhat.com>
References: <CAGbvivJQYb6KpZPW0ug_q7rbL_NYB2eGS+Vcktvy_W3ECHxKbA@mail.gmail.com>	<54EF527B.8060403@redhat.com>	<CAGbvivK+oHAfD3bURzDyRDsoBtKtmp35ZZ-YC7kLyLXD6mQ6fQ@mail.gmail.com>	<54EF5CF0.3030503@redhat.com>	<CAGbvivKiuJ1UrACb2W_fX+8TFDvJ0XrayGYXjL3qGRWZMCPSYg@mail.gmail.com>	<54EF5F6C.8030305@redhat.com>	<CAGbvivL_5TDYXPbz6Pu7OKrU3WdATY0CY5qDTgUs-qSqwQvX7g@mail.gmail.com>	<54EF637A.7030906@redhat.com> <CAGbvivLaKuOq999tC3OWnwOJrq1Hf4FVnbvCESdMPGbfCetZsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862AbbBZSch (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 13:32:37 -0500
In-Reply-To: <CAGbvivLaKuOq999tC3OWnwOJrq1Hf4FVnbvCESdMPGbfCetZsA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: ceph-devel@vger.kernel.org

On 26/02/2015 18:27, Wyllys Ingersoll wrote:
> Excellent, thanks.
>
> It starts now without crashing, but I see lots of errors like this:
>
> 2015-02-26 08:24:19.134693 7f78091aa700  0 cephx: verify_reply
> couldn't decrypt with error: error decoding block for decryption
> 2015-02-26 08:24:19.134695 7f78091aa700  0 -- 10.2.3.33:6800/5236 >>
> 10.2.2.104:6857/8883 pipe(0x26f5700 sd=33 :50680 s=1 pgs=0 cs=0 l=1
> c=0x280b1e0).failed verifying authorize reply
> 2015-02-26 08:24:19.134717 7f7809bb4700  0 cephx: verify_reply
> couldn't decrypt with error: error decoding block for decryption
> 2015-02-26 08:24:19.134719 7f7809bb4700  0 -- 10.2.3.33:6800/5236 >>
> 10.2.3.111:6848/4652 pipe(0x26f4300 sd=23 :58785 s=1 pgs=0 cs=0 l=1
> c=0x2694c00).failed verifying authorize reply
> 2015-02-26 08:24:19.134761 7f78093ac700  0 cephx: verify_reply
> couldn't decrypt with error: error decoding block for decryption
> 2015-02-26 08:24:19.134764 7f78093ac700  0 -- 10.2.3.33:6800/5236 >>
> 10.2.3.105:6842/5408 pipe(0x26f5c00 sd=30 :38240 s=1 pgs=0 cs=0 l=1
> c=0x280a000).failed verifying authorize reply
>
It would appear that something is wrong with your deployment, such as 
missing keys.  You might want to take this issue to ceph-users to see if 
anyone can help with whatever system you were using to deploy these 
services.

John
