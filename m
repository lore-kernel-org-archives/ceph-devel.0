From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Multiple OSDs suicide because of client issues?
Date: Mon, 23 Nov 2015 12:29:30 -0700
Message-ID: <CAANLjFrU0aDV44u7srskMOCHvFaHYEG4kdxnhxH_MMxW6S9Mfw@mail.gmail.com>
References: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com>
	<CAJ4mKGb5F+cuUKdU6PHs47sed9ZCb+qEnNDvxfuxB=vFyDx96A@mail.gmail.com>
	<CAANLjFo=vCsny5=JW1wYiQk5S=oXdtVd0OzXEC=uTGgmDO9ydA@mail.gmail.com>
	<CAJ4mKGbYrDOpiEJiMKZwHaEHGrZT=b58GjzYg4x35U1XtDbDWg@mail.gmail.com>
	<CAANLjFpn+MGw4cY7aZarLuXgiVznovaJGXY2wtXwMmm8n24Qsw@mail.gmail.com>
	<CAJ4mKGaA=OnH3XPM=m5JE+1Rwc38gsmwrJv3FP1MCY5qO1nYrg@mail.gmail.com>
	<CAANLjFoyAyDrxoGLTdPwzRN12ffqkHqNeXgBZBmG+s7i02WBCw@mail.gmail.com>
	<CAJ4mKGawUUwAB7DC6uWf=6xVGpeg=ac3PB1wx2_3msDPCYDkOw@mail.gmail.com>
	<CAANLjFq-eqTy4XN_YTMyS0M2h4Smo1GNSmuqL+FuDAZDG3yXGg@mail.gmail.com>
	<alpine.DEB.2.00.1511231110530.11017@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33470 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbbKWT3b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 14:29:31 -0500
Received: by vkfr145 with SMTP id r145so45242307vkf.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 11:29:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511231110530.11017@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Is there a way through the admin socket or inject args that can tell
the OSD process to dump the in memory logs without crashing? Do you
have an idea of the overhead? From the code it looks like it is always
evaluated, just depends on if it is stored in memory or dumped to
disk. I'm trying to figure out an issue with dout() right now in the
code I'm working on (invalid use of static member) and I'm trying to
understand how it works.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Nov 23, 2015 at 12:12 PM, Sage Weil  wrote:
> On Mon, 23 Nov 2015, Robert LeBlanc wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> We set the debugging to 0/0, but are you talking about lines like:
>>
>>    -12> 2015-11-20 20:59:47.138746 7f70067de700 -1 osd.177 103793
>> heartbeat_check: no reply from osd.133 since back 2015-11-20
>> 20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
>> 20:59:27.138720)
>>    -11> 2015-11-20 20:59:47.138749 7f70067de700 -1 osd.177 103793
>> heartbeat_check: no reply from osd.136 since back 2015-11-20
>> 20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
>> 20:59:27.138720)
>>    -10> 2015-11-20 20:59:47.138751 7f70067de700 -1 osd.177 103793
>> heartbeat_check: no reply from osd.139 since back 2015-11-20
>> 20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
>> 20:59:27.138720)
>>     -9> 2015-11-20 20:59:47.138758 7f70067de700 -1 osd.177 103793
>> heartbeat_check: no reply from osd.147 since back 2015-11-20
>> 20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
>> 20:59:27.138720)
>>     -8> 2015-11-20 20:59:47.138761 7f70067de700 -1 osd.177 103793
>> heartbeat_check: no reply from osd.159 since back 2015-11-20
>> 20:58:51.427880 front 2015-11-20 20:58:51.427880 (cutoff 2015-11-20
>> 20:59:27.138720)
>>     -7> 2015-11-20 20:59:47.138789 7f70067de700 -1 osd.177 103793
>> heartbeat_check: no reply from osd.170 since back 2015-11-20
>> 20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
>> 20:59:27.138720)
>>     -6> 2015-11-20 20:59:47.138794 7f70067de700 -1 osd.177 103793
>> heartbeat_check: no reply from osd.175 since back 2015-11-20
>> 20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
>> 20:59:27.138720)
>>
>> There are 10,000 of those lines in the OSD log which shows all the
>> logs up to the crash. Unless setting the value to 0/0 is eliminating
>> what you are looking for. I've been wondering if setting it to 0/1 or
>> 0/5 or even 0/20 has any runtime performance penalty? It seems like
>> more detailed info on crashes would be helpful, but we don't want to
>> write too much to the SATADOMs.
>
> There is a performance impact but no disk IO (logs are accumulated in
> memory and only flushed out on a crash).
>
> sage

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWU2kWCRDmVDuy+mK58QAAIgUQALpFu8+tdK3+oEktPy5t
J8JTqp/XBRBeb80nvQTBi4ePt5T6O0mDTtbiGE7mcHjNR4Nh/a30CQmWeO//
yRZ3fX+iv4Q2yAzhOArTnYhGPHVwo0mWPNHmvCAlkeLqZ8KAmYzNOaHSU+C0
aJKe7krtaGC/bJC5nYqp/uQza9++3OL9acI8ZnqbfdXAFDRrXIdyjfdg26+h
XJe27ietL83ZyOmtYq0NUaFyrxR14x0prvJhZpqLKuufvKoqGSd/DO6/+mZx
3Gr+w9erhBKdd5Wed454pIWw5AGvoqmIJySfcnqvbdS2M9DhDG4Cl+3Hdu/X
5RQiX//zS4Wq2ego2qISjt00X3ul+4RKOUlfKApQ1ATsLOKR6OWYlgwcSRo9
UWtU5A8cSKctqE+w1ltHW7dQ7D7vxuTxgHmMQi5j76MVvWzg9Rdw0V/IJOvk
vn9CWxpkXKcZIEadaEMx6hHfflW01Z3/6DUq8qpXpJtdbLGyzZcqCzqOEc4R
/o96otd14AXLdjokg8HNJ8FLa9hSd1vLCosm0bRRPLpN9JP5qyOGjeSkemaO
7MjwIubog5eOStsMuIhfsFOsUMttpWyL+BQmAh5YwObkepJl7w0u2IhBV3OB
f+jglWvwHdTPnSQ236gI+KdFTBv+jkoazyvmqviYuCQRM5RKiqQB7e5a5Wsc
va31
=h1p4
-----END PGP SIGNATURE-----
