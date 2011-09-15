From: Wido den Hollander <wido@widodh.nl>
Subject: Re: mkcephfs giving problems
Date: Thu, 15 Sep 2011 13:28:55 +0200
Message-ID: <1316086135.3104.4.camel@wido-desktop>
References: <loom.20110915T081127-706@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52304 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933271Ab1IOL24 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2011 07:28:56 -0400
In-Reply-To: <loom.20110915T081127-706@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

As Jantje said, it seems you are not running as root.

But I do have some recommendations for your config:

On Thu, 2011-09-15 at 06:14 +0000, Atish Kathpal wrote:
> [global]
>         auth supported = cephx
>        keyring = /etc/ceph/ceph.keyring
> 
> [mon]
>         mon data = /ceph_data/mon.0
> 

This section is globally, so if you'd add more monitors, they would all
get /ceph_data/mon.0 as data dir.

I'd do:

[mon]
    mon data = /ceph_data/mon.$id

> [mds]
> 
> [osd]
>         osd data = /ceph_data/osd.0
>         osd journal = /ceph_data/osd.0.journal
>         osd journal size = 1000

Same goes here for your OSD, do:

  osd data = /ceph_data/osd.$id
  osd journal = /ceph_data/osd.$id.journal

> 
> [mon.0]
>         host = atish-virtual-machine
>         mon addr = 10.72.147.207:6789

Monitors should not be named "0", "1", etc, but more like:
* mon.alpha
* mon.beta
* mon.charlie

> 
> [osd.0]
>         host = atish-virtual-machine
> 
> [mds.0]
>         host = atish-virtual-machine


And you have only one OSD, is that correct?

Wido

