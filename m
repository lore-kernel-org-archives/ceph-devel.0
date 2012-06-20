From: Dan Mick <dan.mick@inktank.com>
Subject: Re: filestore btrfs trans
Date: Wed, 20 Jun 2012 15:46:39 -0700
Message-ID: <4FE252CF.2000603@inktank.com>
References: <4FE19B56.6010808@profihost.ag> <Pine.LNX.4.64.1206200907420.14284@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36141 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab2FTWqm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 18:46:42 -0400
Received: by dady13 with SMTP id y13so10434648dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 15:46:41 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206200907420.14284@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 06/20/2012 09:09 AM, Sage Weil wrote:
> On Wed, 20 Jun 2012, Stefan Priebe - Profihost AG wrote:
>> >  Hello list,
>> >
>> >  i've looked at the wiki (http://ceph.com/wiki/Ceph.conf) but there is no exact
>> >  desciption what filestore btrfs trans does. It seems it is false by default.
>> >
>> >  Should it be enabled when using btrfs?
> Nope.  This is the obsolete trans start/end ioctls that we don't use.  We
> should remove this code.
>
> sage

I filed http://tracker.newdream.net/issues/2623
