From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: new build dep on master
Date: Wed, 31 Oct 2012 19:53:45 -0700
Message-ID: <FF5B0412-DBC3-4208-949A-FA1A20348F34@inktank.com>
References: <alpine.DEB.2.00.1210310903220.11223@cobra.newdream.net> <852DC463-3E96-472A-B5CC-A803D15CB453@inktank.com> <5091A738.2060109@inktank.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52623 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab2KACxt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 22:53:49 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1411925pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 19:53:49 -0700 (PDT)
In-Reply-To: <5091A738.2060109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Looks like Sam fixed that this morning.

Cheers,
Gary

On Oct 31, 2012, at 3:33 PM, Dan Mick wrote:

> Gary, were you also going to update README?  (I know, it's imperfect, but...)
> 
> 
> On 10/31/2012 10:25 AM, Gary Lowell wrote:
>> Hi Sage -
>> 
>> Sam may have the build machines updated.  I'll double check that, and take care of any packaging changes.
>> 
>> Cheers,
>> Gary
>> 
>> On Oct 31, 2012, at 9:03 AM, Sage Weil wrote:
>> 
>>> apt-get install libboost-program-options-dev
>>> 
>>> on debian-based distros; not sure what the rpm equivalent is yet.
>>> 
>>> sage
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

