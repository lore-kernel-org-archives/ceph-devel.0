From: Sage Weil <sweil@redhat.com>
Subject: RE: Is that possible to run teuthology on local test servers
Date: Thu, 14 Aug 2014 05:59:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408140558190.28244@cobra.newdream.net>
References: <53EC2446.3020708@gmail.com> <085BC98701B92B4C86AE7696562D284D0529FBB5@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60474 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945AbaHNM7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Aug 2014 08:59:48 -0400
In-Reply-To: <085BC98701B92B4C86AE7696562D284D0529FBB5@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vijayendra Shamanna <Vijayendra.Shamanna@sandisk.com>
Cc: guping <magicgup@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You can accomplish the same thing by adding a section like

targets:
  ubuntu@plana37.front.sepia.ceph.com: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlGkqSVZEriH63rFY4R4y6jelC0RGv/A8JtkIGWqRDIjLYsXgB4GoSNsI5H0FGhR+8ZiE2kOimFvpzYXCiFEW9QNWEcdKn75ZsnUnCTJf0fhYUyyD0qaxL00003BhDyPX2pazSPvIB9w+WSATpW3XoL6uos7VIRjGn95VsHOonWjx25rupntyF9ac0VChYCFAO7WVQcxDfQ8MAW3O4YhH+uIuzv62ZahI8l+9A1rKbxcQU5aOaS+lhJArHEGxF38JXGWOmqybhe1x8wc4Fw/1g777VfwbyzG0wh2WgxkZ2R7qzKttnJ+iT8a/Un+ZLi8AnWN7KiwabRiMvc1VXO6zl

to your yaml.  The key is the *public* key of the machine (what you get 
from ssh-keyscan), to verify you are talking to the right target.  That, 
along with the 'roles' and 'tasks' section, is put in a yaml file, and the 
filename is passed to the 'teuthology' binary.

sage


On Thu, 14 Aug 2014, Vijayendra Shamanna wrote:

> Hi,
> 
> I had gotten teuthology to work some time back to a reasonable extent in my local setup with a few quick ugly hacks. The main set of changes were,
> 
> 1. Explicitly named my test systems as "plana01" , "plana02" & "plana03". Some of the teuthology code which checks for VM instances does compare with known set/class of machine names
> 2. In lock_machines() routine (teuthology/task/internal.py), set ctx.config['targets'] as follows:
>     mydict['myuser@plana01'] = 'ssh-rsa <my_ssh_key1>'
>     mydict['myuser@plana02'] = 'ssh-rsa <my_ssh_key2>' and so on..
>    ctx.config['targets'] = mydict
> 3. Comment out the reporting code in teuthology/report.py
> 
> There were a few other minor changes like disabling teuthology branch checkout etc.
> 
> Thanks,
> Viju
> 
> 
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of guping
> Sent: Thursday, August 14, 2014 8:22 AM
> To: ceph-devel@vger.kernel.org
> Subject: Is that possible to run teuthology on local test servers
> 
> I read the doc on the github teuthology, but still can not figure out how to run teuthology on my local test servers.
> Any experience? Any advice?
> 
> --
> Thanks,
> Gu Ping
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
