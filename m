From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: FW: Encoding schemes
Date: Fri, 17 Jun 2016 20:29:17 +0000
Message-ID: <BLUPR0201MB1524707795FDD626321BB040E8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0072.outbound.protection.outlook.com ([65.55.169.72]:55647
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752061AbcFQU3T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 16:29:19 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have a deeper question about bufferlist. Essentially, I have a specific pattern that I want to implement and there are a couple of options about how to orchestrate the bufferlists. I'm looking for an opinion on the best choice.

Naturally, ::encode is the still the theme of the day. I've been thinking about an alternate approach to the encoding problem that approaches it more globally than the per-field, incremental approach that you're looking at.

Specifically, thinks like the # of low-order bits being zero (512, 4K, block sizes...) are really more efficiently encoded globally. Also, the size of an LBA address is more efficiently coded locally (and decoded!).

The major problem with these techniques is that you have to encode the shift values earlier in the buffer from the actual data values. Meaning that EITHER you know the value ahead of time (from, say device information, or config parameters) OR you have to scan the data to determine the correct value.

I've been thinking about a third/hybrid scheme, wherein you assume a large value, start to encode the data and then backtrack (i.e., abandon and restart) if you discover that your assumed value is incorrect.

One pattern to do this is the do the encode into a separate bufferlist. If the encode fails you can bufferlist::clear (or delete and recreate) and restart. Once you've succeeded you append then the new buffer to the original buffer.

The other pattern is to somehow mark the original buffer (bufferlist::size) when you start and then if you fail, you trim (resize) the original buffer back to the mark point. Once you succeeded you're done.

Which do you think would be faster?
