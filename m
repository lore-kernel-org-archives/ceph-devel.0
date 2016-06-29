From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: msgr2 protocol
Date: Wed, 29 Jun 2016 11:59:51 +0000
Message-ID: <DB5PR05MB1607570EB6CCCAB6F68D50E3A9230@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-am1on0079.outbound.protection.outlook.com ([157.56.112.79]:35134
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751980AbcF2L7z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 07:59:55 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

bbbb

On Sat, 28 May 2016 11:19 AM, Yehuda Sadeh-Weinraub <yehuda@xxxxxxxxxx> wrote: 
>On Fri, May 27, 2016 at 10:37 AM, Sage Weil <sweil@xxxxxxxxxx> wrote:
>>
>> If you do a connect and immediately write a few bytes to teh TCP 
>> stream, does that actaully translate to fewer packets?  I was guessing 
>> that the server writing the first bytes of the exchange would be fine 
>> but if it speeds things up for the client to optimistically start the 
>> exchange too we may as well...
>>
>
>While haven't really looked at it recently, I don't think it'd be possible to embed data with the SYN packet using the plain >vanilla tcp implementation. However, I believe that doing connect() and sending data immediately following it should improve >things, specifically if doing async connect (as with the async messenger), but this still needs to be proven.
>
>Yehuda

I am using TCP with network sniffers like Wireshark and this is always the case that I see in Linux  - *sending data soon after connect will always save packet by combining the ACK from the last step of TCP 3-way handshake with the 1st data packet* .  
This is the case even when I did "short" activity between connect and send.

Sniffer will show you 3 packets on the stream:
1.	Client sends SYN packet
2.	Server replies with SYN-ACK packet
3.	Client send *data packet* that have the ACK flag set in it (this ACK completes the TCP 3-way handshake and makes 'accept' return on the server side)

synchronous or asynchronous socket isn't relevant here because 'connect' returns with success upon receiving SYN-ACK from the server regardless of the actual client send of the TCP 3-way completing ACK (i.e., the client application doesn't need this ACK for relying on the socket as connected - only the server side need it).

From my experience, even disabling nagle (TCP_NODELAY) doesn't affect this behavior (probably because TCP_NODELAY only affect sending *data* faster but does not change TCP handshake behavior)

If you need a test application, I can provide you
Avner
