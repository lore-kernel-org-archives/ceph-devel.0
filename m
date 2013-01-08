From: Denis Fondras <ceph@ledeuns.net>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Tue, 08 Jan 2013 20:44:32 +0100
Message-ID: <50EC7720.1040604@ledeuns.net>
References: <50E81A3D.5070100@ledeuns.net> <50EB0518.9050304@ledeuns.net> <E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com> <50EBDC5E.3090207@ledeuns.net> <CAPYLRzhUWYu8vp-Lk6WgyjxLH-GJ08QakTgWqZEKjVSXCbEZ2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:39951 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134Ab3AHTof (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 14:44:35 -0500
In-Reply-To: <CAPYLRzhUWYu8vp-Lk6WgyjxLH-GJ08QakTgWqZEKjVSXCbEZ2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

> What error message do you get when you try and turn it on? If the
> daemon is crashing, what is the backtrace?

The daemon is crashing. Here is the full log if you want to take a look 
: http://vps.ledeuns.net/ceph-osd.0.log.gz

The RBD rebuild script helped to get the data back. I will now try to 
rebuild a Ceph cluster and do some more tests.

Denis
