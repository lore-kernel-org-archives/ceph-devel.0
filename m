From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RBD using problem
Date: Tue, 11 Dec 2012 16:58:01 +0800
Message-ID: <50C6F599.2050007@widodh.nl>
References: <20121211060012.GA16722@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52188 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab2LKI6I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 03:58:08 -0500
In-Reply-To: <20121211060012.GA16722@cs.nctu.edu.tw>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chuanyu Tsai <chuanyu@cs.nctu.edu.tw>
Cc: ceph-devel@vger.kernel.org

Hi Chuanyu,

On 12/11/2012 02:00 PM, Chuanyu Tsai wrote:
> Hi cephers,
> 
> I know that we can setup cluster addr and public addr to let OSDs
> listen on different subnet for different purpose, however, I don't
> have so much public IPs to give all my OSDs an IP per OSD.
> 

Don't confuse "public" with actually route-able IP's on the internet. In
most cases you'll use 192.168.X.X or 10.X.X.X for your Ceph cluster and
let your clients communicate over that.

The "cluster network" is there to let the OSDs do their
inter-OSD-traffic over a different interface so you can gain more
bandwith in certain cases.

Note that you can also use IPv6 for your Ceph cluster, which I assume is
available in Taiwan.

I've been using Ceph with IPv6 for about 3 years now and works like a charm.

Wido

> So my question is, if I follow the link:
> http://www.spinics.net/lists/ceph-devel/msg10941.html
> to set all my pools using the ssd-primary rule or
> something like that, than I bind public IP on every
> ceph-osd-ssd-server-*
> (it means all my primary osd have public IP, right?),
> can this method make me using RBD correctly?
> 
> Or do we have some method to let public network clients use RBD
> and no need to let all OSDs have public IP?
> 
> Regards,
> Chuanyu.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
