From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [Qemu] Passing config options to librados
Date: Tue, 15 Mar 2011 14:37:13 -0700
Message-ID: <4D7FDC09.9040309@dreamhost.com>
References: <1300191618.2434.27.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37648 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab1COVhN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2011 17:37:13 -0400
In-Reply-To: <1300191618.2434.27.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On 03/15/2011 05:20 AM, Wido den Hollander wrote:
> I'm using the patch below to force reading the ceph.conf, but imho that
> is not flexible enough.

rados_conf_read_file(cluster, NULL) will use the default
locations now (/etc/ceph/ceph.conf, ~/.ceph/config, and
ceph.conf). I applied a patch like yours that uses the default
locations instead.

> The current RBD code has no way of reading config options from Qemu and
> converting them into librados options by rados_conf_set() nor specifying
> a conf file to be read by rados_conf_read_file().
>
> Something that still has to be implemented or am I missing something?

We plan to allow a config file to be specified for each rbd
drive -- something like rbd:pool/image:path/to/conf like you
suggested in IRC. This will let you use disks from multiple
clusters in one VM as well.

Thanks,
Josh
