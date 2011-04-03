From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: HEALTH_WARNING
Date: Sun, 3 Apr 2011 16:38:48 -0700
Message-ID: <BANLkTimHeFzKJpUjcKVFafOwOv90C8Qhcg@mail.gmail.com>
References: <1463999357.13436.1301740919511.JavaMail.root@mail.linserv.se>
	<718796783.13438.1301741738011.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36479 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab1DCXiu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Apr 2011 19:38:50 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2B1FDC066
	for <ceph-devel@vger.kernel.org>; Sun,  3 Apr 2011 16:38:50 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id CDB85C063
	for <ceph-devel@vger.kernel.org>; Sun,  3 Apr 2011 16:38:49 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1566490ewy.19
        for <ceph-devel@vger.kernel.org>; Sun, 03 Apr 2011 16:38:48 -0700 (PDT)
In-Reply-To: <718796783.13438.1301741738011.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel@vger.kernel.org

On Sat, Apr 2, 2011 at 3:55 AM, Martin Wilderoth
<martin.wilderoth@linserv.se> wrote:
> Hello,
>
> I have seperate partitions for my osd and the btrfs file system.
> I also use SSD-disk for journaling.
>
> But I got problem when the root system was filled up with logfiles on one host,
> the file system reported out of diskspace.
>
> But the osd's were not filled to 100%. Later I realised that the root system on one of the osd hosts (osd2 and osd3) had no space left, to much logging.
>
> The only way I know to recover is to create a new filesystem in the cluster :-)
> But it's bad fot the data :-)
>
> When i get problems with one osd it seems as if they are crashing one by one.
> And i dont know how to get them up again whitout deleting all the data.
You should be able to simply clear up some space (don't remove any of
the actual OSD data though!) and then start up the OSD daemon, at
which point it ought to automatically rejoin the cluster.
Is this not working? If not, please start up the daemon with higher
levels of debug logging and put the logs somewhere accessible.
-Greg
