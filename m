From: Wido den Hollander <wido@widodh.nl>
Subject: Re: osd crashed after adding new osd
Date: Tue, 10 Aug 2010 17:42:06 +0200
Message-ID: <1281454926.2812.3.camel@wido-laptop.pcextreme.nl>
References: <AANLkTi=bUW_twak9n_jwcp2VkrRN_pztEzkUMzW72z5=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:58799 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157Ab0HJPmI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 11:42:08 -0400
In-Reply-To: <AANLkTi=bUW_twak9n_jwcp2VkrRN_pztEzkUMzW72z5=@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Hi Henry,

Is there a core-dump of these crashes in /? If so, these could help
finding the cause of this.

See: http://ceph.newdream.net/wiki/Troubleshooting

And btw, which version of Ceph are you running?

Wido

On Tue, 2010-08-10 at 21:09 +0800, Henry C Chang wrote:
> Hi,
> 
> I have a ceph cluster: 3 (mon+osd) and 2 (mds).
> When I tried to add the 4th osd to the cluster, osd0 and osd1 crashed.
> The error logs are attached.
> 
> My procedure to add the 4th osd is:
> 
> add [osd3] in the conf file: /etc/ceph/ceph.conf
> ceph -c /etc/ceph/ceph.conf mon getmap -o /tmp/monmap
> cosd -c /etc/ceph/ceph.conf -i 3 --mkfs --monmap /tmp/monmap
> ceph -c /etc/ceph/ceph.conf osd setmaxosd 4
> osdmaptool --createsimple 4 --clobber /tmp/osdmap.junk --export-crush
> /tmp/crush.new
> ceph -c /etc/ceph.conf osd setcrushmap -i /tmp/crush.new
> /etc/init.d/ceph -c
> /etc/ceph/d2c5d946-b888-40b3-aac2-adda05477a81.conf start osd
> 
> Is my procedure to add an osd incorrect?
> 
> Thanks,
> Henry

