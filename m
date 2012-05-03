From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Possible memory leak in mon?
Date: Wed, 2 May 2012 17:22:17 -0700
Message-ID: <07C999FE3BF7420ABC05B7CFF88B06AD@dreamhost.com>
References: <4FA1B50B.8080603@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45743 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab2ECAWV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 May 2012 20:22:21 -0400
Received: by obbtb18 with SMTP id tb18so1679818obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 May 2012 17:22:20 -0700 (PDT)
In-Reply-To: <4FA1B50B.8080603@bashkirtsev.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday, May 2, 2012 at 3:28 PM, Vladimir Bashkirtsev wrote:
> Dear devs,
> 
> I have three mons and two of them suddenly consumed around 4G of RAM 
> while third one happily lived with 150M. This immediately prompts few 
> questions:
> 
> 1. What is expected memory use of mon? I believed that mon merely 
> directs clients to relevant OSDs and should not consume a lot of 
> resources - please correct me if I am wrong.
> 2. In both cases where mon consumed a lot of memory it was preceded by 
> disk-full condition and both machines where incidents happened are 64 
> bit, rest of cluster 32 bit. mon fs and log files happened to be in the 
> same partition - ceph osd produced a lot of messages, filled up disk, 
> mon crashed (no core as disk was full), manually deleted logs, restarted 
> mon without any issue, some time later found mon using 4G of RAM. 
> Running 0.45. Should I deliberately recreate conditions and crash mon to 
> get more debug info (if you need it of course, and if yes then what)?
> 3. Does figure 4G per process coming from 32 bit pointers in mon? Or mon 
> potentially can consume more than 4G?
> 
> Regards,
> Vladimir
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html

First: one email is enough. 

Second: in normal use your monitors should not consume very much memory. It sounds like something's wrong. Can you please provide the output of "ceph -s"?
Also, do you have any monitor logging on? My best guess is that for some reason the monitors aren't all communicating with each other and so they are buffering messages.
-Greg

