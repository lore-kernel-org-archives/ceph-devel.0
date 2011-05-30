From: Sage Weil <sage@newdream.net>
Subject: Re: CRUSH. What wrong?
Date: Sun, 29 May 2011 21:43:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105292141480.25744@cobra.newdream.net>
References: <4DE24862.5080109@ufm.su> <1306749042.1527.8.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47713 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab1E3El5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 May 2011 00:41:57 -0400
In-Reply-To: <1306749042.1527.8.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Wu <cpwu@tnsoft.com.cn>
Cc: Fyodor Ustinov <ufm@ufm.su>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jeff,

On Mon, 30 May 2011, Jeff Wu wrote:
> Hi ,
> Could you attach the detail reproducing steps?
> Are you using the following steps to get crush.new.txt and base on it to
> modify new crush ?
> $ ceph osd getcrushmap -o crush.new
> $ crushtool -d crush.new -o crush.new.txt
> 
> Maybe , you could refer to the following commands to create crush.new
> file,for instance:
> $ crushtool --num_osds 8 -o crush.new --build host straw 8 rack straw 8
> root straw 0
> $ crushtool -d crush.new -o crush.new.txt
> 
> I had filed two bug at :
> http://tracker.newdream.net/issues/1016
> http://tracker.newdream.net/issues/1017

Sorry, these fell through the cracks somehow!

For both of these it looks like the same problem Fyodor had: you need to 
use chooseleaf instead of choose in your crush rule.  Currently you're 
getting back rack bucket ids instead of devices.

sage
