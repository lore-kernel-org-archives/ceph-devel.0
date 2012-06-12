From: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Subject: Re: debian updates
Date: Tue, 12 Jun 2012 03:19:34 +0000
Message-ID: <1339471174.7726.71.camel@julia>
References: <Pine.LNX.4.64.1206111939390.10716@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:35638 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab2FLD0Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 23:26:16 -0400
In-Reply-To: <Pine.LNX.4.64.1206111939390.10716@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On Mon, 2012-06-11 at 19:41 -0700, Sage Weil wrote:
> Can you take a look at the last 4 commits of
> 	https://github.com/ceph/ceph/commits/debian
> and let me know if they address the issues you mentioned?
 Yes, they fixes those issues I've mentioned. However you could keep
ceph-kdump-copy for Ubuntu. It's not installable on Debian through, as
its dependency linux-crashdump is not available. I can package it if
you want. Now my fingers are crossed to accept libs3 soon, it's freeze
for Wheezy soon[1]. Ceph 0.47.2 is waiting for that to be in Wheezy.

Laszlo/GCS
[1] http://lists.debian.org/debian-devel-announce/2012/05/msg00004.html

