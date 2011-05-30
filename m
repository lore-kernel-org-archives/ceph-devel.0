From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: CRUSH. What wrong?
Date: Mon, 30 May 2011 12:56:16 +0000
Message-ID: <1306760176.1527.11.camel@localhost>
References: <4DE24862.5080109@ufm.su> <1306749042.1527.8.camel@localhost>
	 <Pine.LNX.4.64.1105292141480.25744@cobra.newdream.net>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:31261 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751359Ab1E3E4C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 May 2011 00:56:02 -0400
In-Reply-To: <Pine.LNX.4.64.1105292141480.25744@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Fyodor Ustinov <ufm@ufm.su>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi sage,

Thanks!

Jeff Wu

On Mon, 2011-05-30 at 12:43 +0800, Sage Weil wrote:
> Hi Jeff,
> 
> On Mon, 30 May 2011, Jeff Wu wrote:
> > Hi ,
> > Could you attach the detail reproducing steps?
> > Are you using the following steps to get crush.new.txt and base on it to
> > modify new crush ?
> > $ ceph osd getcrushmap -o crush.new
> > $ crushtool -d crush.new -o crush.new.txt
> > 
> > Maybe , you could refer to the following commands to create crush.new
> > file,for instance:
> > $ crushtool --num_osds 8 -o crush.new --build host straw 8 rack straw 8
> > root straw 0
> > $ crushtool -d crush.new -o crush.new.txt
> > 
> > I had filed two bug at :
> > http://tracker.newdream.net/issues/1016
> > http://tracker.newdream.net/issues/1017
> 
> Sorry, these fell through the cracks somehow!
> 
> For both of these it looks like the same problem Fyodor had: you need to 
> use chooseleaf instead of choose in your crush rule.  Currently you're 
> getting back rack bucket ids instead of devices.
> 
> sage

