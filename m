From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Logging
Date: Mon, 18 Apr 2011 12:13:59 +0200
Message-ID: <4DAC0EE7.4080001@provocation.net>
References: <4DAB77FD.4010804@provocation.net> <BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:40762 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab1DRKON (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 06:14:13 -0400
In-Reply-To: <BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



On 04/18/2011 02:53 AM, Colin McCabe wrote:

Hi

>> Question: what's the "do not log at all" syntax in ceph.conf? I tried
>> putting everything on "debug xyz = 0", but ceph (osd in this case) is
>> still logging plenty. According to this, I think it shouldn't:

> Messages that are output at log level 0 or -1 will always be
> displayed. I'm not sure if this message belongs at that log level or
> not-- I haven't dealt with the OSD repop code in a while.

Wido mentioned "log file = " in a recent posting; I'll try it.

> In general, I don't think that anyone will ever want to turn off
> logging completely. That would be a little bit like running your
> server without syslog. It just doesn't happen in the real world. 

Of course you're right in general, but right now I'm trying to figure why
my cluster is sluggy and logging is one potential cause that I'd like to
test eliminating. I've seen something like this once before (in openldap),
inexplicable slowness that I spent a long time trying to understand by
reading logs, until I found out that it went away completely as soon as
I switched off logging.

Z

