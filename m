From: Dietmar Maurer <dietmar@proxmox.com>
Subject: RE: ceph cli delay when one mon is down
Date: Wed, 15 Jan 2014 07:33:05 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F75592E9FDF@lisa.maurer-it.com>
References: <24E144B8C0207547AD09C467A8259F75592E9F78@lisa.maurer-it.com>
 <alpine.DEB.2.00.1401142323550.11815@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.maurer-it.com ([94.136.31.133]:47784 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaAOHdJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jan 2014 02:33:09 -0500
In-Reply-To: <alpine.DEB.2.00.1401142323550.11815@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> You can avoid this, and speed things up in general, by using the interactive
> mode:
> 
> #!/bin/sh
> ceph <<EOM
> do something
> do something else
> EOM

Above is a bit clumsy. To be honest, I want to do things with perl, so 
I guess it is better to use perl bindings for librados.

Are perl bindings already available? 

