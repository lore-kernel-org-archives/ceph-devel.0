From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Client stuck 'waiting on max_size'
Date: Tue, 06 Dec 2011 21:07:28 -0800
Message-ID: <4EDEF490.5050606@cs.ucsc.edu>
References: <726402583.133585.1323230432339.JavaMail.root@mail-01.cse.ucsc.edu> <1340951383.133589.1323230543007.JavaMail.root@mail-01.cse.ucsc.edu> <CAF3hT9DHJ6gRxU_d3niH_LrgL=zHcEgaYSXgH+DTq+1ZEOU9+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:57246 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab1LGFHG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 00:07:06 -0500
In-Reply-To: <CAF3hT9DHJ6gRxU_d3niH_LrgL=zHcEgaYSXgH+DTq+1ZEOU9+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/6/11 8:49 PM, Gregory Farnum wrote:
> The client is waiting for the MDS to give it permission to make the
> file larger. I think this data comes back in a caps message, but it
> probably got stuck on the MDS for some reason. Try grepping through
> the MDS and client logs for max_size and see if there's something
> obvious (or send it our way).

Logs are here:

   http://piha.soe.ucsc.edu/cephlogs/max_size/

-Noah
