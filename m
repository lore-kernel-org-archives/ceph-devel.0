From: Matt Weil <mweil@genome.wustl.edu>
Subject: Re: how many MDS active daemons to run
Date: Tue, 20 Dec 2011 17:56:21 -0600
Message-ID: <4EF120A5.2010100@genome.wustl.edu>
References: <4EF11A83.2030006@genome.wustl.edu> <CAF3hT9B0jq0adbT2hy6TjFyzs9TcRfVapnXEV0OAjrnby553zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:40523 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753123Ab1LTX4V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 18:56:21 -0500
In-Reply-To: <CAF3hT9B0jq0adbT2hy6TjFyzs9TcRfVapnXEV0OAjrnby553zg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 12/20/11 5:39 PM, Gregory Farnum wrote:
> On Tue, Dec 20, 2011 at 3:30 PM, Matt Weil<mweil@genome.wustl.edu>  wrote:
>> Hello all:
>>
>> given six osd servers does it make any difference of each one also runs a
>> mds or not?
>>
>> How many mds's is to many.  How does this effect metadata performance.
> Right now a single-MDS system is significantly more stable than a
> system with multiple active MDSes, so if possible you should use that
> configuration. Only add MDSes when you need more metadata throughput
> (probably you only need one).

Thanks for the response.

these osd servers are also going run the client and serve out NFS.

Is it better to split the mds and mon out to a dedicated system?  then 
run standby on the active osd's


>
> Adding more MDSes should increase metadata throughput; it wouldn't
> surprise me if you could construct a set of operations that slow down
> but you're not going to run into one by mistake.
>
> However, if you just start up a metadata server on each OSD node
> without changing the max_mds parameter, what you'll actually get is
> one active MDS and 5 standby daemons, which will be fine and give you
> lots of changes to fail over your MDS in the event of crashes. ;)
> -Greg

