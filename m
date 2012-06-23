From: David Blundell <David.Blundell@100percentit.com>
Subject: Re: Unable to restart Mon after reboot
Date: Sat, 23 Jun 2012 10:43:59 +0000
Message-ID: <F38AD123-3C97-44BD-ABE5-33635AD6D768@100percentit.com>
References: <BDAE812E-2659-4025-9B30-2DEC6675B59A@100percentit.com>
 <4FE55567.6080201@inktank.com> <4FE558CB.4010509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.100percentit.com ([217.25.0.14]:41593 "EHLO
	smtp.100percentit.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751680Ab2FWKoG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 06:44:06 -0400
Received: from exchange1.ad.100it.net (unknown [87.254.25.14])
	by smtp.100percentit.com (Postfix) with ESMTP id 33E89D8172
	for <ceph-devel@vger.kernel.org>; Sat, 23 Jun 2012 11:44:04 +0100 (BST)
In-Reply-To: <4FE558CB.4010509@inktank.com>
Content-Language: en-US
Content-ID: <C66621B35A312C4CA46BD2D061D00816@ad.100it.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Dan,

The btrfs checksum had failed on that file.

All three servers are running Fedora 17 with kernel 3.4.3

The logs on all three servers are full of messages like:
Jun 23 04:02:19 Store2 kernel: [63811.494955] ceph-osd: page allocation failure: order:3, mode:0x4020

The difference between the lines is that order: varies between 2, 3, 4 or 5

Is this likely to be a btrfs bug?

David

On 23 Jun 2012, at 06:48, Dan Mick wrote:

> Sorry: that file would actually be /data/mon0/osdmap/latest
> 
> On 06/22/2012 10:34 PM, Dan Mick wrote:
>> Hi David:
>> 
>> The code there is trying to read some stuff off the monitor's storage to
>> initialize, and apparently failing in an odd way. It's trying to read
>> the file 'latest' from the monitor directory (/data/mon0); the file can
>> be opened, and stat says it's 4289 bytes long, but apparently the read
>> is succeeding without error, but only getting back 0 bytes (i.e., not an
>> error, but apparently end of file).
>> 
>> See if there's a file /data/mon0/latest of length 4289, and see if
>> something is odd about its permissions (like maybe the read bits are
>> turned off, or maybe the filesystem it's on has errors).

