From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Hang when mapping a long name rbd image
Date: Fri, 16 Dec 2011 18:40:01 -0800
Message-ID: <4EEC0101.3030905@dreamhost.com>
References: <8512670932FB654F81AF0FEF1BE6D49DA2ECA6@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53099 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab1LQCkC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 21:40:02 -0500
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49DA2ECA6@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

On 12/16/2011 06:21 PM, Eric_YH_Chen@wistron.com wrote:
> Hi, all:
>
> My ceph version is
> ceph version 0.39 (commit:321ecdaba2ceeddb0789d8f4b7180a8ea5785d83)
>
> When I try to map a long name rbd image to device, it would hang for
> long time.
>
> For example:
> sudo rbd map iqn.2012-01.com.sample:storage.ttttttt --secret
> /etc/ceph/secretfile sudo rbd map iqn.2012-01.com.sample:storage.abcdef
> --secret /etc/ceph/secretfile

The limit was increased in this commit:

commit 224736d9113ab4a7cf3f05c05377492bd99b4b02
Author: Stratos Psomadakis <psomas@grnet.gr>
Date:   Thu Nov 10 15:45:37 2011 +0200

     libceph: Allocate larger oid buffer in request msgs

     ceph_osd_request struct allocates a 40-byte buffer for object names.
     RBD image names can be up to 96 chars long (100 with the .rbd suffix),
     which results in the object name for the image being truncated, and a
     subsequent map failure.

     Increase the oid buffer in request messages, in order to avoid the
     truncation.

There is still an outstanding issue with the limits in the kernel not 
being enforced by userspace tools though 
(http://tracker.newdream.net/issues/1701).

>
> It would not hang at every long name image, however, it only happens
> when the image name is very long.
>
> Is it a known issue?
>
> Thanks!

