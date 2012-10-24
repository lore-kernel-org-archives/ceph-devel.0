From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [ceph-commit] =?UTF-8?Q?HEALTH=5FWARN=20=31=39=32=20pgs=20deg?=
 =?UTF-8?Q?raded?=
Date: Wed, 24 Oct 2012 07:55:35 -0700
Message-ID: <d90b8aadf4453a9dbdae4b9b4242d893@hq.newdream.net>
References: <5087F3AE.8080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ps79606.dreamhost.com ([66.33.206.83]:42906 "EHLO
	webmail.hq.newdream.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934915Ab2JXPCv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 11:02:51 -0400
In-Reply-To: <5087F3AE.8080601@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: ceph-devel@vger.kernel.org

Moving to ceph-devel, ceph-commit is for notifications from the source 
code repository

On 2012-10-24 06:57, Roman Alekseev wrote:
> Hi there,
>
>
> I've made simple fresh installation of ceph on Debian server with the
> following configuration:
> ************************
> [global]
>     debug ms = 0
> [osd]
>     osd journal size = 1000
>     filestore xattr use omap = true
>
> [mon.a]
>
>     host = serv1
>     mon addr = 192.168.0.10:6789
>
> [osd.0]
>      host = serv1
>
> [mds.a]
>     host = serv1
> ************************
>
> Seems everything is working fine but when I perform "ceph health"
> command I receive the next message:
> HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean; recovery 21/42
> degraded (50.000%)

The default replication level is 2, but you only have 1 osd. Thus,
you only have 1 copy of everything, and ceph reports this condition
as 'degraded'. You can add a second osd and it will copy data
and report HEALTH_OK.

Josh
