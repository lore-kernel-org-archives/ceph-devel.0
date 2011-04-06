From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: HEALTH_WARNING
Date: Wed, 06 Apr 2011 10:13:50 -0700
Message-ID: <4D9C9F4E.4090408@dreamhost.com>
References: <617102443.13876.1302030472004.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45070 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab1DFRNv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2011 13:13:51 -0400
In-Reply-To: <617102443.13876.1302030472004.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel@vger.kernel.org

On Tue, 5 Apr 2011 21:07:52 +0200 (CEST), Martin Wilderoth
<martin.wilderoth@linserv.se> wrote:
> I did clear some data and the restart but the osd didn't go online
> again. Instead The osd was running for some time and then they became
> dead one by one.
>
> I was re-creating the filesystem and transfering data again with a
> similar result. This time the filesystem was not filled up.
> It seems as the filesystem is hanginging and I can't get any respons from it.
>
> I have done same process again, during the creation it complained on
> journaling
> hdparm -W 0 /dev/sda2. This time I made sure it didn't complain on
> the hdparam of the SSD disks, while I was creating the filesystem
>
> on my host where the filesystem is mounted i have seen some dmesg
> conection filed
>
> [16143.534936] libceph: client4428 fsid 19be9ae7-cdf8-cb03-4178-568342d30fa5
> [16143.535092] libceph: mon0 10.0.6.10:6789 session established
> [16224.427969] libceph: mon0 10.0.6.10:6789 socket closed
> [16224.427975] libceph: mon0 10.0.6.10:6789 session lost, hunting for new mon
> [16224.429637] libceph: mon0 10.0.6.10:6789 connection failed
> [16233.700478] libceph: mon1 10.0.6.11:6789 connection failed
> [16243.716405] libceph: mon2 10.0.6.12:6789 connection failed
> [16253.728529] libceph: mon2 10.0.6.12:6789 connection failed
> [17008.794981] libceph: client4107 fsid 2c3fefe7-3362-f541-27b4-64176adb3f22
> [17008.795127] libceph: mon0 10.0.6.10:6789 session established
>
> Not sure I have everything configured corectly ?

You may have hit a bug in the OSDs - could you add this to your
ceph.conf in the [osd] section, restart the osd daemons, and post the 
logs somewhere accessible?

         debug ms = 1
         debug osd = 25
         debug monc = 20
         debug journal = 20
         debug filestore = 10

We can probably help you debug this faster on IRC (#ceph on irc.oftc.net).

Thanks,
Josh Durgin
