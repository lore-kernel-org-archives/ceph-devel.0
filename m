From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: How to test HA(HighAvailability) of MDS
Date: Mon, 11 Apr 2011 09:00:19 -0700
Message-ID: <829AB31292094B63835DEEE38D76A232@gmail.com>
References: <BANLkTiknehGsu-2UE65j8QM=zRsJnG6AYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43950 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab1DKQAX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 12:00:23 -0400
Received: by ywj3 with SMTP id 3so2209353ywj.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 09:00:22 -0700 (PDT)
In-Reply-To: <BANLkTiknehGsu-2UE65j8QM=zRsJnG6AYQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: AnnyRen <annyren6@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Monday, April 11, 2011 at 8:35 AM, AnnyRen wrote:
Hi,
> 
> I want to test the reliability of MDS in Ceph File System,
> there are three MONs, two MDSes and three OSD in my test environment.
> 
> With "ceph -s", I saw the MDS's status is
> 2011-04-11 23:30:38.001177 mds e5: 1/1/1 up {0=up:active}, 1 up:standby
> 
> Could you tell me how to set the standby MDS to active? What is the
> instruction? ^_^
> and how can I test the reliability of MDS ?
> May I turn off the active one and see the standby MDS takes over?

So if you just want to see the standby MDS take over, then all you have to do is kill the active MDS process. After a configurable timeout period, the standby MDS will go into replay, which should take a few seconds, then rejoin and reconnect (which should go very quickly), and then back to active.
It sounds like that's all you're after right now.

If you want to increase the number of active MDSes (to deal with a high metadata load), there are some wiki pages about it and similar things:
http://ceph.newdream.net/wiki/Main_Page#Expanding_your_cluster

Hope this helps!
-Greg



