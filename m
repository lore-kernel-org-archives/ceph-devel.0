From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: inconsistent chunk
Date: Mon, 20 Jun 2011 10:16:10 -0700
Message-ID: <7CF4E65F-BFA1-429D-BE72-CE86ED79992F@dreamhost.com>
References: <4DFAE436.9060606@ufm.su> <E58F9FF9-B13F-45D7-86D3-5C1940A919C7@dreamhost.com> <4DFCC3EE.2090700@ufm.su>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48238 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab1FTRQM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2011 13:16:12 -0400
In-Reply-To: <4DFCC3EE.2090700@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org, samuel.just@dreamhost.com


On Jun 18, 2011, at 8:27 AM, Fyodor Ustinov wrote:

> On 06/17/2011 07:27 PM, Gregory Farnum wrote:
>> 4. Can I recover the data without backup?
>> Possibly. If the inconsistency is just that one of the OSDs is storing the object and another OSD says the object shouldn't exist, that can be recovered from by working out which one is correct.
>> 
>> Have you manually adjusted the contents of any OSDs? Can you think of anything you've done that might have triggered this?
> I step by step down osd servers until only one remains (hmm, it is not clear how this is consistent with "pg_size 2"). After one day I step by step up osd servers.

Well if you've got enough space and step down slowly enough all the data will simply exist on the one up OSD in a degraded form. :)

Is it still marked as inconsistent? If that's really all you did it shouldn't be, but maybe restarting the cluster would let it fix itself. :/
-Greg