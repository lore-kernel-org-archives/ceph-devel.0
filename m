From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: PATCH: link ceph-client version to kernel version
Date: Wed, 07 Jul 2010 17:11:21 +0200
Message-ID: <4C349919.9070409@chaschperli.ch>
References: <i11fb7$mk1$1@dough.gmane.org> <Pine.LNX.4.64.1007070757310.23002@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:40931 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993Ab0GGPL1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jul 2010 11:11:27 -0400
In-Reply-To: <Pine.LNX.4.64.1007070757310.23002@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 07.07.2010 17:03, Sage Weil wrote:
> , how does that work?  This would divorce the kclient version from the
> server side (which is basically already is, teh CEPH_VERSION* defines are
> ignored by the kclient currently) and match it up with the kernel version.
> For most people, that is just whatever upstream kernel they downloaded.
>
> Is the goal just to make the standalone/backported code tell you which
> version the client code corresponds to?  If that's the case, I wonder the
> defines should be generated exclusively in the backport branches of the
> -standalone.git repo.

yes and yes - this is only needed in ceph-client-standalone.

fact is, that kernels smaller than 2.6.34 will be standard next years - 
examples :
* Debian 5.0  2.6.26
* Ubuntu 10.04 LTS: 2.6.32
* Debian 6.0 2.6.32
* RHEL/CentOS 6 2.6.32

they all will need backported ceph modules. if there is no version 
output in modinfo it will be hard to say which version is loaded.

- Thomas
