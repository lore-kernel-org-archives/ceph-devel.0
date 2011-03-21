From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: File Deletion (Was: Disk allocation)
Date: Mon, 21 Mar 2011 10:53:24 -0700
Message-ID: <AC59A58E13924407959453B60CAE16DE@gmail.com>
References: <1449881494.12831.1300600065210.JavaMail.root@mail.linserv.se>
 <51655650.12833.1300603409038.JavaMail.root@mail.linserv.se>
 <AANLkTimo+LohYdZdF4SSEar3HHfuHf8tqn5FCvee620B@mail.gmail.com>
 <AANLkTi=Jji78-otu2NFTCe9g9fE7LbiOUQOxeiwx5evq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63151 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab1CURx2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 13:53:28 -0400
Received: by yxs7 with SMTP id 7so2536901yxs.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 10:53:28 -0700 (PDT)
In-Reply-To: <AANLkTi=Jji78-otu2NFTCe9g9fE7LbiOUQOxeiwx5evq@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ben De Luca <bdeluca@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Monday, March 21, 2011 at 10:32 AM, Ben De Luca wrote:
Sorry to jump into the converstation, how slow can the deletion of
> files actually be?
> 
> One of the tests I ran a few weeks ago had me generating files,
> deleting them and then writing them again from a number of clients. I
> noticed that the space would never freed up again. I have my OSD's and
> their journals on dedicated partions.
> 
> I had planned on asking more on this once I had a stable system again.

Well I don't think the time is actually bounded, and it can be slowed down if multiple clients have capabilities on the file. The main issue is that the MDS is responsible for telling the OSDs to delete all the objects which make up the file; generally this shouldn't take too long but if you delete enough files quickly enough it might take some time. If you're watching it and the used space doesn't start dropping within ~20 minutes from last access then there's a problem, though.
Given the scenario you describe it wouldn't surprise me too much if you just went quickly enough that the object deletions never actually occur (ie, they end up getting used again before the MDS has the permissions and the time to delete them). If faster space frees are actually a requirement for some reason you can comment on Bug #630 (http://tracker.newdream.net/issues/630). :)
-Greg



