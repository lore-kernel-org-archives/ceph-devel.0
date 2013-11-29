From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: [PATCH 17/18] client: Write inline data path
Date: Fri, 29 Nov 2013 12:01:09 -0500 (EST)
Message-ID: <938803040.82.1385744469623.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <CAAM7YAnwL4xdY0wysN46yVgb2=MciNA5DGV4Ac=nYgQi4vcfPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2913 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755740Ab3K2RBW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Nov 2013 12:01:22 -0500
In-Reply-To: <CAAM7YAnwL4xdY0wysN46yVgb2=MciNA5DGV4Ac=nYgQi4vcfPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zheng Yan <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

Hi,

I wondered about this.  Were you able to measure an effect?

Thanks,

Matt

----- "Zheng Yan" <ukernel@gmail.com> wrote:

> 
> Besides, this feature should be disabled by default because it's not
> compatible with old clients and it imposes overhead on the mds. we
> need to use a config option or directory attribute to enable it.
> 
> Regards
> Yan, Zheng
> 

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
