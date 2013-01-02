From: Wido den Hollander <wido@widodh.nl>
Subject: Re: status monitoring options for ceph cluster
Date: Wed, 02 Jan 2013 16:08:41 +0100
Message-ID: <50E44D79.6070809@widodh.nl>
References: <CAE63xUOt5dpKPnYXN-nbJHPhPdAW2yH3ERDkwE7QO3TaVLFg4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:56280 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab3ABPIn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 10:08:43 -0500
In-Reply-To: <CAE63xUOt5dpKPnYXN-nbJHPhPdAW2yH3ERDkwE7QO3TaVLFg4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 01/02/2013 04:05 PM, Ugis wrote:
> Hi all,
>
> I am planning to set up monitoring of ceph cluster relying on output
> of commands:
>
> #ceph health
> #ceph -s
>
> The need is to retrieve certain values, for example %degraded;
> proportion "X GB / Y GB avail" to calculate available space%. I plan
> to graph those values via zabbix and set up triggers for certain
> tresholds.
> May be somebody already has written shell parser for getting values
> from output of these commands?
>
> Probably this ir wider question - what is the intended approach for
> ceph cluster monitoring? What do you guys use?

You might want to take a look at: http://tracker.newdream.net/issues/685

In version 0.35 a json output was added. I've never tried it before, but 
you might want to look at that.

A blogpost was also recently added: 
http://ceph.com/community/monitoring-a-ceph-cluster/

Wido

>
> BR,
> Ugis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

