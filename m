From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: packaging for ceph-gui
Date: Tue, 14 Dec 2010 21:27:56 +0100
Message-ID: <1292358476.25794.88.camel@julia.gcs.org.hu>
References: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:34397 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759759Ab0LNU3b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Dec 2010 15:29:31 -0500
In-Reply-To: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On Tue, 2010-12-14 at 11:56 -0800, Sage Weil wrote:
> Colin separated out the gui from the 'ceph' binary (it's gceph) in the 
> unstable branch of git, which means we can break it into a separate 
> package and eliminate all the gtk dependencies for the other stuff.
 Yes, I've seen that, which was a very good decision. ceph is for every
kind of machines, mostly servers. There's no need other binaries (GTK+
or others) that not strictly necessary to operate a service. They occupy
space and may expose security problems. On the other hand, I don't like
running GUIs when I'm on a slow connection (maybe just to fix a config
file from a PDA).

> Maybe a ceph-gui, recommended by ceph?
 It's up to you how to name it. As for the rule of thumb, packages named
after the binary they contain. So it should be gceph, but can be
ceph-gui if you want.
I was a bit lazy to check out, is ceph mandatory for using gceph? As
I've seen no, the logic remained in ceph.cc , the command line and gui
tool went to cmd.cc and gceph.cc respectively.
The question is, when do you want to merge these changes to rc? There
are unstable and gceph trees available, but are they for v0.24 or not?

Laszlo/GCS

