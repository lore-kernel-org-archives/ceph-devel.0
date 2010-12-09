From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH 1/2] qemu: Add RBD support and some network
 disk fixes
Date: Thu, 9 Dec 2010 11:10:07 +0000
Message-ID: <20101209111007.GF5142@redhat.com>
References: <20101202131928.GV2502@redhat.com>
 <1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
 <4CFE9172.6030302@hq.newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41511 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab0LILKW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Dec 2010 06:10:22 -0500
Content-Disposition: inline
In-Reply-To: <4CFE9172.6030302@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <joshd@hq.newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org, sheepdog@lists.wpkg.org

On Tue, Dec 07, 2010 at 11:56:34AM -0800, Josh Durgin wrote:
> 
> Changes common to all network disks:
> -Make source name optional in the domain schema, since NBD doesn't use it
> -Add a hostName type to the domain schema, and use it instead of genericName, which doesn't include .
> -Don't leak host names or ports
> -Set the source protocol in qemuParseCommandline
> 
> Signed-off-by: Josh Durgin <joshd@hq.newdream.net>
> ---
>  docs/schemas/domain.rng |   11 +++-
>  src/conf/domain_conf.c  |   25 +++++++-
>  src/conf/domain_conf.h  |    1 +
>  src/qemu/qemu_conf.c    |  143 ++++++++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 165 insertions(+), 15 deletions(-)

ACK

Daniel
