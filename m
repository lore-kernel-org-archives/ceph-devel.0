From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: What would a good OSD node hardware configuration look like?
Date: Tue, 06 Nov 2012 08:36:06 +0100
Message-ID: <5098BDE6.3050801@profihost.ag>
References: <5097F3BD.2000904@conversis.de> <50985677.6090708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44903 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab2KFHgJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 02:36:09 -0500
In-Reply-To: <50985677.6090708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Dennis Jacobfeuerborn <dennisml@conversis.de>, ceph-devel@vger.kernel.org

Am 06.11.2012 01:14, schrieb Josh Durgin:
> On 11/05/2012 09:13 AM, Dennis Jacobfeuerborn wrote:
>> Hi,
>> I'm thinking about building a ceph cluster and I'm wondering what a good
>> configuration would look like for 4-8 (and maybe more) 2HU 8-disk or 3HU
>> 16-disk systems.
>> Would it make sense to make each disk an individual OSD or should I
>> perhaps
>> create several raid-0 and create OSDs from those?
>
> This mainly depends on your ratio of disks to cpu/ram. Generally we
> recommend 1GB ram and 1Ghz per OSD. If you've got enough cpu/ram,
> running 1 OSD/disk is pretty common. It makes recovering from a
> single disk failure faster.

Just i node while using SSDs i've seen osd processes using up to two 3.6 
Ghz cores. So under heavy load and disks and network with enough speed 1 
ghz might be even too low. Right now i'm calculating with 1 3.6Ghz Core 
per OSD when using 10GBE and SSDs.

Greets,
Stefan
