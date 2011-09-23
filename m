From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: rbd snap
Date: Fri, 23 Sep 2011 11:25:13 -0700
Message-ID: <4E7CCF09.3080409@dreamhost.com>
References: <4E736107.4050309@tuxadero.com> <Pine.LNX.4.64.1109160928170.11043@cobra.newdream.net> <4E73C064.7020104@tuxadero.com> <4E73CC58.9070503@dreamhost.com> <4E74C653.6080404@tuxadero.com> <4E7CCB3B.7080606@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56427 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab1IWSZN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 14:25:13 -0400
In-Reply-To: <4E7CCB3B.7080606@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: ceph-devel@vger.kernel.org

On 09/23/2011 11:08 AM, Martin Mailand wrote:
> Hi,
> is it possible to access snapshots without to rollback the head of the
> rbd volumen?
> Because I want to do a snapshot of a vm running via librbd and qemu, and
> use the snapshot to make a offsite backup of the vm.

Yup, you can export it from a given snapshot:

     rbd export --snap snapname image /path/to/destination
