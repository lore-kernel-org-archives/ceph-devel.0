From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to deal with a single host with several harddisks
Date: Wed, 04 May 2011 15:16:15 +0200
Message-ID: <1304514975.4036.107.camel@wido-laptop.pcextreme.nl>
References: <BANLkTi=_sbPhhtmBBXmmFrR5kM6NVTDayg@mail.gmail.com>
	 <1304503840.4036.84.camel@wido-laptop.pcextreme.nl>
	 <BANLkTi=xLDW0Tc3aXF-a0jrUtGmP7VfuMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:33233 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab1EDNQQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 09:16:16 -0400
In-Reply-To: <BANLkTi=xLDW0Tc3aXF-a0jrUtGmP7VfuMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Wed, 2011-05-04 at 19:31 +0800, tsk wrote:
> 800M or 80M?
> There is 12 disks in my hosts, 1TB each. 10 disks of every host can be
> used for ceph.
> If one cosd per disk, there will be 10 cosd processes, which need a
> lot lot of memory!

> I note that new cosd process takes 35M memory, but another cosd which
> run 5 days takes 112M memory.  Hoping there is no memory leak.

When doing recovery work a OSD process can spike pretty hard in CPU and
memory usage. I just checked a few of mine OSD processes, some are
taking 125M, others are using about 200M.

From what I know, the more PG's you get, the more memory the OSD's start
to consume, so that is something you have to keep in mind.

But for OSD's, more memory is always better! (Isn't that true for
everything?)

Wido

