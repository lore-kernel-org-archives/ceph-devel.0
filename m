From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Looking to Use Ceph
Date: Thu, 03 Jan 2013 15:38:46 +0100
Message-ID: <50E597F6.6000609@widodh.nl>
References: <50E579AF.10206@sussex.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:58297 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab3ACOiu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 09:38:50 -0500
In-Reply-To: <50E579AF.10206@sussex.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "emyr.james" <emyr.james@sussex.ac.uk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 01:29 PM, emyr.james wrote:
> Hi,
>
> I'm thinking of starting to use ceph initially for evaluation...seeing
> how it compares to our existing lustre file system.
> One thing that I would like confirmation of is how ceph stores large
> files. If I store a large file in CephFS is it automatically split up
> into chunks with the various chunks stored and replicated automatically
> across the whole cluster, or does it store the whole file as one object
> on one individial OSD and then has individual replicants of the whole
> file on a small number of other OSD's ? What is the typical block size
> used if files are split up....can this be configured ?
>

Files are by default striped in 4MB blocks which are then distributed 
over the OSDS and replicated.

A 1G file will thus result in 256 different object distributed and 
replicated through your cluster.

You can configure the stripe-size with the "cephfs" tool on a client.

Note: CephFS hasn't got the attention like RADOS and RBD got, so you 
might run into some weird situations.

Wido

> Regards,
>
> Emyr
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

