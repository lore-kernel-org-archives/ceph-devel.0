From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: SAS disks for OSD's
Date: Mon, 23 Apr 2012 21:22:15 +0200
Message-ID: <4F95ABE7.6020202@unilogicnetworks.net>
References: <loom.20120423T175101-19@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out117.unilogicnetworks.net ([62.133.206.117]:43392 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754199Ab2DWTWR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Apr 2012 15:22:17 -0400
In-Reply-To: <loom.20120423T175101-19@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hello,

I don't think you will see a great difference in performance between 
"sas" and "sata" disks, because the connection type is only a minor 
point in performance. There are other factors that impact the 
performance a lot more.
How many RPMs are the disks? The more RPM the lower the average seek 
time. Lower average seek time is great for random IO.
How dense are the disks, with more sectors per cilinder you can read or 
write more data per round. Great for sequential IO.

And there are other factors that impact performance. But in general the 
"sata" disks are disks with low RPMs and high density, therefor they are 
(in general) poor on random IO and great on sequential IO. With the 
"sas" disks it's the other way around. But even something like 2.5" vs 
3.5" can impact performance because it can have impact on the density of 
the disk.

But I think using a "sas" disk as journal won't give you any performance 
gain. As journal you want a device that can handle a lot of IOPS and 
also have a lot of bandwidth.
I think a SSD gives a good balance between IOPS, bandwidth, size and 
price (compared to sata/sas disks and nvram).

"sas" disks for the OSD can gain you performance compared to the "sata" 
disks, but it depends on the specs of the disk, the workload, the kind 
and size of the journal, ratio between write/read, etc. So it's a little 
difficult to tell you if the "sas" disks gain you any or enough 
performance for the extra cost.

Stefan

On 04/23/2012 05:56 PM, Madhusudhana U wrote:
> Hi all,
> Is any performance benefit we will get using SAS storage for OSD instead of
> SATA storage ? Is any one using SAS drives which is producing good performance?
>
> Or I can use SAS drives for journal and SATA storage for OSD?
>
> Which one in above two scenario would yield a better performance?
>
> I would like to test above scenarios, before i would like to hear if
> anyone got good results with SAS drives.
>
> Thanks
> __M
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

