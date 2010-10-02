From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: multi-mds crash: In function 'void MDCache::adjust_subtree_auth(CDir*,
 std::pair<int, int>, bool)
Date: Sat, 02 Oct 2010 11:40:18 +0200
Message-ID: <4CA6FE02.5020903@chaschperli.ch>
References: <i82me6$4a8$1@dough.gmane.org> <Pine.LNX.4.64.1010011255370.25313@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:58071 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab0JBJsl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Oct 2010 05:48:41 -0400
In-Reply-To: <Pine.LNX.4.64.1010011255370.25313@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage

> On Thu, 30 Sep 2010, Thomas Mueller wrote:
>
>> hi
>>
>> updated to new git/unstable. mds0 crashed on bonnie++.
>>
>> rev: 0e67718a365b42969e785f544ea3b4258bb2407f
>
> Pushed a fix for this.  The cross-mds rename code didn't updated to match
> some other changes made in the spring.  Fixed in
> commit:e87f751b3dc703f13e7580a24df49fbff1359536




now on pjd-fstest, the mds1 "disappeard", last loglines see

http://pastebin.com/zgnQDdpv

rev: 0b7c1afc43202953123f335057b9a5da428bc9a2

- Thomas
