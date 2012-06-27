From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 17:13:20 +0200
Message-ID: <4FEB2310.9080801@profihost.ag>
References: <4FEB04CC.4050008@profihost.ag> <4FEB10DA.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58138 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584Ab2F0PNW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 11:13:22 -0400
In-Reply-To: <4FEB10DA.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

 > Am 27.06.2012 15:55, schrieb Mark Nelson:
> On 6/27/12 8:04 AM, Stefan Priebe - Profihost AG wrote:
> Hi Stefan,
>
> I'm not entirely clear how you are coming to the conclusion regarding
> the CPU requirements.  If we go by the "1Ghz per OSD" suggestion, does
> that mean you plan to have 3.6GHz*20/1GHz = 72 OSDs per server?

oh i'm sorry it seems you got me wrong. I've a testsetup 4x OSDs with 
one disk each in ONE Server with a Intel Xeon 3,6Ghz. Each of the 4 
ceph-osd processes take up to 170% CPU usage right now. So with these 4 
osd disks and daemons i go up to 800% load. So EACH osd process takes up 
to 2 cores of 3,6 Ghz.

So i need right now 2 Core of 3,6Ghz each per OSD drive. So if i want to 
use 8-10 drives per osd server i need 20 cores of 3,6Ghz.

Anything wrong?

Greets
Stefan
