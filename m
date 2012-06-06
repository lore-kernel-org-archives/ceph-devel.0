From: Wido den Hollander <wido@widodh.nl>
Subject: Re: replicas in ceph storage
Date: Wed, 06 Jun 2012 12:34:04 +0200
Message-ID: <4FCF321C.1090507@widodh.nl>
References: <loom.20120606T122126-155@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:35368 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2FFKeH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 06:34:07 -0400
In-Reply-To: <loom.20120606T122126-155@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: udit agarwal <fzdudit@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 06/06/2012 12:24 PM, udit agarwal wrote:
> Hi,
>   I have a query regarding the way to determine the no. of replicas that are
> created for each object in the ceph storage system. I couldn't find a way to
> determine this. please help me with this.
>

The number of replicas is set by the "rep size" attribute of the pool 
you are storing the object in.

$ ceph osd dump -o -|grep "rep size"

That will show something like:

pool 0 'data' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num 
2560 pgp_num 2560 lpg_num 2 lpgp_num 2 last_change 91 owner 0 
crash_replay_interval 45
pool 1 'metadata' rep size 3 crush_ruleset 1 object_hash rjenkins pg_num 
2560 pgp_num 2560 lpg_num 2 lpgp_num 2 last_change 90 owner 0
pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num 2560 
pgp_num 2560 lpg_num 2 lpgp_num 2 last_change 630 owner 0
	removed_snaps [1~1]

In this case all the pools have a "size" of 3, which means all objects 
stored in these pools will be replicated three times.

You can change this parameter with:

$ ceph osd pool set <pool> size <size>

Wido

>   Thanks in advance.
>
> --Udit Agarwal
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

