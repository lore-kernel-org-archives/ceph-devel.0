From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Mon losing touch with OSDs
Date: Sat, 23 Feb 2013 11:08:43 +1100
Message-ID: <20130223000843.GA10200@onthe.net.au>
References: <alpine.DEB.2.00.1302142051250.19927@cobra.newdream.net>
 <20130215220521.GA29999@onthe.net.au>
 <20130217234107.GA19416@onthe.net.au>
 <alpine.DEB.2.00.1302171743460.25660@cobra.newdream.net>
 <20130219030202.GA5010@onthe.net.au>
 <20130220020703.GA8567@onthe.net.au>
 <20130222030614.GA13873@onthe.net.au>
 <alpine.DEB.2.00.1302221344550.5703@cobra.newdream.net>
 <20130222233555.GA9173@onthe.net.au>
 <alpine.DEB.2.00.1302221543090.5703@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:33956 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab3BWAI6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 19:08:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302221543090.5703@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Feb 22, 2013 at 03:43:22PM -0800, Sage Weil wrote:
> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>> On Fri, Feb 22, 2013 at 01:57:32PM -0800, Sage Weil wrote:
>>> On Fri, 22 Feb 2013, Chris Dunlop wrote:
>>>> G'day,
>>>> 
>>>> It seems there might be two issues here: the first being the delayed
>>>> receipt of echo replies causing an seemingly otherwise healthy osd to be
>>>> marked down, the second being the lack of recovery once the downed osd is
>>>> recognised as up again.
>>>> 
>>>> Is it worth my opening tracker reports for this, just so it doesn't get
>>>> lost?
>>> 
>>> I just looked at the logs.  I can't tell what happend to cause that 10 
>>> second delay.. strangely, messages were passing from 0 -> 1, but nothing 
>>> came back from 1 -> 0 (although 1 was queuing, if not sending, them).

Is there any way of telling where they were delayed, i.e. in the 1's output
queue or 0's input queue?

>>> The strange bit is that after this, you get those indefinite hangs.  From 
>>> the logs it looks like the OSD rebound to an old port that was previously 
>>> open from osd.0.. probably from way back.  Do you have logs going further 
>>> back than what you posted?  Also, do you have osdmaps, say, 750 and 
>>> onward?  It looks like there is a bug in the connection handling code 
>>> (that is unrelated to the delay above).
>> 
>> Currently uploading logs starting midnight to dropbox, will send
>> links when when they're up.
>> 
>> How would I retrieve the interesting osdmaps?
> 
> They are in the monitor data directory, in the osdmap_full dir.

Logs from midnight onwards and osdmaps are in this folder:

https://www.dropbox.com/sh/7nq7gr2u2deorcu/Nvw3FFGiy2

  ceph-mon.b2.log.bz2
  ceph-mon.b4.log.bz2
  ceph-mon.b5.log.bz2
  ceph-osd.0.log.bz2
  ceph-osd.1.log.bz2 (still uploading as I type)
  osdmaps.zip

Cheers,

Chris
